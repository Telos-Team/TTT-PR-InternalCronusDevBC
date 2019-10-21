codeunit 50024 "TTT-PR WsTestHttpWrapper"
{
    var
        hhContentHeaders: HttpHeaders;
        hhRequestHeaders: HttpHeaders;
        hhResponseHeaders: HttpHeaders;
        hcResponseContent: HttpContent;
        hcRequestContent: HttpContent;
        hrmRequestMessage: HttpRequestMessage;
        hrmResponseMessage: HttpResponseMessage;
        hcClient: HttpClient;
        txtAuthorization: Text;
        txtUsername: Text;
        txtPassword: Text;
        txtDomain: Text;
        intTimeout: Integer;

    procedure CallWsTestor(partxtAddress: Text; partxtService: Text; partxtMethod: Text; partxtParamName: Text; partxtParamValue: Text; partxtUsername: Text; partxtPassword: Text; partxtDomainName: Text; parenumAuthenticationType: enum "TTT-PR WsTestAuthenticationType")
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Bc(partxtService, partxtMethod);
        loccuMgt.AddParameter4Bc(partxtParamName, partxtParamValue);
        Message('Request:\ \%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.SetAuthorizationInfo(partxtUsername, partxtPassword, partxtDomainName, parenumAuthenticationType);
        loccuHttp.CallWs(partxtAddress, partxtMethod, true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\ \%1', loctxtInMessage);
    end;

    procedure CallWs(partxtAddress: Text; parbooFail: Boolean): Boolean
    begin
        exit(CallWs(partxtAddress, '', parbooFail));
    end;

    procedure CallWs(partxtAddress: Text; partxtAction: Text; parbooFail: Boolean): Boolean
    var
        loctxtInMessage: Text;
        loctxtAuthorizationInfo: Text;
    begin
        Clear(hcResponseContent);
        Clear(hrmResponseMessage);
        Clear(hcClient);

        hrmRequestMessage.Content := hcRequestContent;
        hrmRequestMessage.SetRequestUri(partxtAddress);
        hrmRequestMessage.Method('POST');
        hrmRequestMessage.GetHeaders(hhRequestHeaders);

        loctxtAuthorizationInfo := GetAuthorizationInfo();
        if loctxtAuthorizationInfo <> '' then
            AddRequestHeader('Authorization', GetAuthorizationInfo());
        AddRequestHeader('Connection', 'keep-alive');
        if partxtAction <> '' then
            AddRequestHeader('SOAPAction', partxtAction);

        if intTimeout = 0 then
            intTimeout := hcClient.Timeout()
        else
            hcClient.Timeout(intTimeout);

        if not SendReceive(parbooFail) then
            exit(false);
        if not CheckResponseMessageIsSuccess(parbooFail) then
            exit(false);
        hcResponseContent := hrmResponseMessage.Content();
        hcResponseContent.GetHeaders(hhResponseHeaders);
        if GetResponseContentString(loctxtInMessage) then
            exit(true);
        if parbooFail then
            Error('Simon Says:\ \Read content failed!')
        else
            exit(false);
    end;

    procedure SetRequestContent(partxtContent: Text)
    begin
        hcRequestContent.WriteFrom(partxtContent);
        hcRequestContent.GetHeaders(hhContentHeaders);
        AddContentHeader('Content-Type', 'text/xml;charset=UTF-8');
    end;

    procedure AddRequestHeader(partxtName: Text; partxtValue: Text)
    begin
        if hhRequestHeaders.Remove(partxtName) then;
        if not hhRequestHeaders.Add(partxtName, partxtValue) then
            Error('Simon Says:\ \Unable to add request header\Name: %1\Value: %2', partxtName, partxtValue);
    end;

    procedure AddContentHeader(partxtName: Text; partxtValue: Text)
    begin
        if hhContentHeaders.Remove(partxtName) then;
        if not hhContentHeaders.Add(partxtName, partxtValue) then
            Error('Simon Says:\ \Unable to add content header\Name: %1\Value: %2', partxtName, partxtValue);
    end;

    procedure SetAuthorizationInfo(partxtUsername: Text; partxtPassword: Text; partxtDomain: Text; parenumAuthenticationType: enum "TTT-PR WsTestAuthenticationType")
    var
        loctmprecTempBlob: Record TempBlob temporary;
        loctxtAuthInfo: Text;
        loctxtAuthType: Text;
        locparbooWindowsAuthHandled: Boolean;
    begin
        txtUsername := partxtUsername;
        txtPassword := partxtPassword;
        txtDomain := partxtDomain;

        case parenumAuthenticationType of
            parenumAuthenticationType::Basic:
                begin
                    loctxtAuthInfo := StrSubstNo('%1:%2', partxtUsername, partxtPassword);
                    loctxtAuthType := 'Basic';
                    loctmprecTempBlob.WriteAsText(loctxtAuthInfo, TextEncoding::Windows);
                    txtAuthorization := StrSubstNo('%1 %2', loctxtAuthType, loctmprecTempBlob.ToBase64String());
                end;
            parenumAuthenticationType::Windows:
                begin
                    OnSetDomainAutorizationInfo(partxtUsername, partxtPassword, partxtDomain, hcClient, txtAuthorization, locparbooWindowsAuthHandled);
                    if not locparbooWindowsAuthHandled then
                        Error('Simon Says:\ \You must install the Windows Authentication extension to use the domain feature!');
                end;
            else
                Error('Simon Says:\ \Unhandled Authentication Type: %1', parenumAuthenticationType);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetDomainAutorizationInfo(partxtUsername: Text; partxtPassword: Text; partxtDomain: Text; var parvarxcClient: HttpClient; var parvartxtAuthorization: Text; var parvarbooWindowsAuthHandled: Boolean)
    begin
        // Use one of these in a dependant internal extension event subscriber to set windows authentication.
        // parvarxcClient.UseDefaultNetworkWindowsAuthentication(): Boolean
        // parvarxcClient.UseWindowsAuthentication(partxtUsername, partxtPassword, partxtDomain): Boolean
    end;

    procedure SetTimeout(parintMilliseconds: Integer)
    begin
        intTimeout := Abs(parintMilliseconds);
    end;

    procedure SendReceive(parbooFail: Boolean): Boolean
    begin
        if hcClient.Send(hrmRequestMessage, hrmResponseMessage) then
            exit(true);
        // if hrmResponseMessage.HttpStatusCode() = 200 then
        //     exit(true);
        if parbooFail then
            Error('Simon Says:\ \Send failed!')
        else
            exit(false);
    end;

    procedure CheckResponseMessageIsSuccess(parbooFail: Boolean): Boolean
    begin
        if hrmResponseMessage.IsSuccessStatusCode() then
            exit(true);
        if parbooFail then
            Error('Simon Says:\ \Web service returned: %1 - %2!',
                GetResponseMessageHttpStatusCode(),
                GetResponseMessageReasonPhrase())
        else
            exit(false);
    end;

    procedure GetAuthorizationInfo(): Text
    begin
        exit(txtAuthorization);
    end;

    procedure GetResponseContent(var parvarhcResponseContent: HttpContent)
    begin
        parvarhcResponseContent := hcResponseContent;
    end;

    [TryFunction]
    procedure GetResponseContentString(var parvartxtResponseContent: Text)
    begin
        hcResponseContent.ReadAs(parvartxtResponseContent)
    end;

    procedure GetResponseMessageHttpStatusCode(): Integer
    begin
        exit(hrmResponseMessage.HttpStatusCode());
    end;

    procedure GetResponseMessageReasonPhrase(): Text
    begin
        exit(hrmResponseMessage.ReasonPhrase());
    end;
}
