codeunit 50024 "TTT-PR WsTestHttpWrapper"
{
    Description = '';
    // Auth https://community.dynamics.com/business/f/758/t/303472
    // https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/deployment/implement-security-certificates-production-environment
    // https://community.dynamics.com/nav/b/dynamicsnavcloudfronts/archive/2017/11/20/how-to-login-windows-client-and-web-client-using-navuserpassword-authentication-in-microsoft-dynamics-nav

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

    procedure CallWsSimpleStringTestor(partxtAddress: Text; partxtService: Text; partxtMethod: Text; partxtParamName: Text; partxtParamValue: Text; partxtUsername: Text; partxtAccessKey: Text; partxtDomainName: Text; partxtPassword: Text)
    var
        loctbTelegram: TextBuilder;
        loctxtInMessage: Text;
    begin
        // This procedure shows how to use this codeunit as a wrapper for alle http variables.
        loctbTelegram.Append(StrSubstNo('<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:BC="urn:microsoft-dynamics-schemas/codeunit/%1">', partxtService));
        loctbTelegram.Append('<soap:Header/>');
        loctbTelegram.Append('<soap:Body>');
        loctbTelegram.Append(StrSubstNo('<BC:%1>', partxtMethod));
        loctbTelegram.Append(Strsubstno('<BC:%1>', partxtParamName));
        loctbTelegram.Append(partxtParamValue);
        loctbTelegram.Append(Strsubstno('</BC:%1>', partxtParamName));
        loctbTelegram.Append(StrSubstNo('</BC:%1>', partxtMethod));
        loctbTelegram.Append('</soap:Body>');
        loctbTelegram.Append('</soap:Envelope>');
        Message('Request:\%1', loctbTelegram.ToText());

        SetRequestContent(loctbTelegram.ToText());
        if partxtDomainName = '' then
            SetAuthorizationInfo(partxtUsername, partxtAccessKey)
        else
            SetAuthorizationInfo(partxtUsername, partxtPassword, partxtDomainName);
        CallWs(partxtAddress, partxtService, partxtMethod, true);
        GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure CallWs(partxtAddress: Text; partxtService: Text; partxtMethod: Text; parbooFail: Boolean): Boolean
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
        AddRequestHeader('SOAPAction', partxtMethod);

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
            Error('Read content failed!')
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
            Error('Unable to add request header\Name: %1\Value: %2', partxtName, partxtValue);
    end;

    procedure AddContentHeader(partxtName: Text; partxtValue: Text)
    begin
        if hhContentHeaders.Remove(partxtName) then;
        if not hhContentHeaders.Add(partxtName, partxtValue) then
            Error('Unable to add content header\Name: %1\Value: %2', partxtName, partxtValue);
    end;

    procedure SetAuthorizationInfo(partxtUsername: Text; partxtPassword: Text; partxtDomain: Text)
    var
        loctmprecTempBlob: Record TempBlob temporary;
        loctxtAuthInfo: Text;
        loctxtAuthType: Text;
    begin
        txtUsername := partxtUsername;
        txtPassword := partxtPassword;
        txtDomain := partxtDomain;

        if partxtDomain = '' then begin
            loctxtAuthInfo := StrSubstNo('%1:%2', partxtUsername, partxtPassword);
            loctxtAuthType := 'Basic';
        end else
            Error('Windows credentials are not supported by Extension');

        loctmprecTempBlob.WriteAsText(loctxtAuthInfo, TextEncoding::Windows);
        txtAuthorization := StrSubstNo('%1 %2', loctxtAuthType, loctmprecTempBlob.ToBase64String());
    end;

    procedure SetAuthorizationInfo(partxtUsername: Text; partxtPassword: Text)
    begin
        SetAuthorizationInfo(partxtUsername, partxtPassword, '');
    end;

    procedure SetTimeout(parintMilliseconds: Integer)
    begin
        intTimeout := Abs(parintMilliseconds);
    end;

    procedure SendReceive(parbooFail: Boolean): Boolean
    begin
        if hcClient.Send(hrmRequestMessage, hrmResponseMessage) then
            exit(true);
        if parbooFail then
            Error('Send failed!')
        else
            exit(false);
    end;

    procedure CheckResponseMessageIsSuccess(parbooFail: Boolean): Boolean
    begin
        if hrmResponseMessage.IsSuccessStatusCode() then
            exit(true);
        if parbooFail then
            Error('Web service returned: %1 - %2!',
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

// <?xml version="1.0" encoding="ISO-8859-1"?>
// <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
// <SOAP-ENV:Body>
// <SOAP-ENV:Fault>
// <faultcode>SOAP-ENV:Client</faultcode>
// <faultstring>Unauthorized The credentials provided are incorrect</faultstring>
// </SOAP-ENV:Fault>
// </SOAP-ENV:Body>
// </SOAP-ENV:Envelope>


// <?xml version="1.0" encoding="ISO-8859-1"?>
// <definitions xmlns:tns="urn:microsoft-dynamics-schemas/codeunit/WsTest" xmlns="http://schemas.xmlsoap.org/wsdl/" targetNamespace="urn:microsoft-dynamics-schemas/codeunit/WsTest">
//     <types>
//         <schema xmlns="http://www.w3.org/2001/XMLSchema" targetNamespace="urn:microsoft-dynamics-schemas/codeunit/WsTest" elementFormDefault="qualified">
//             <element name="DateTimeDiff">
//                 <complexType>
//                     <sequence>
//                         <element name="pardtInput" type="dateTime" maxOccurs="1" minOccurs="1"/>
//                         <element name="parvardtOutput" type="dateTime" maxOccurs="1" minOccurs="1"/>
//                     </sequence>
//                 </complexType>
//             </element>
//             <element name="DateTimeDiff_Result">
//                 <complexType>
//                    <sequence>
//                        <element name="return_value" type="int" maxOccurs="1" minOccurs="1"/>
//                        <element name="parvardtOutput" type="dateTime" maxOccurs="1" minOccurs="1"/>
//                    </sequence>
//                 </complexType>
//             </element>
//             <element name="SimpleTextVar">
//                 <complexType>
//                     <sequence>
//                         <element name="parvartxtInput" type="string" maxOccurs="1" minOccurs="1"/>
//                     </sequence>
//                 </complexType>
//             </element>
//             <element name="SimpleTextVar_Result">
//                 <complexType>
//                     <sequence>
//                         <element name="parvartxtInput" type="string" maxOccurs="1" minOccurs="1"/>
//                     </sequence>
//                 </complexType>
//             </element>
//             <element name="SimpleText">
//                 <complexType>
//                     <sequence>
//                         <element name="partxtInput" type="string" maxOccurs="1" minOccurs="1"/>
//                     </sequence>
//                 </complexType>
//             </element>
//             <element name="SimpleText_Result">
//                 <complexType>
//                     <sequence>
//                         <element name="return_value" type="string" maxOccurs="1" minOccurs="1"/>
//                     </sequence>
//                 </complexType>
//             </element>
//         </schema>
//     </types>
//     <message name="DateTimeDiff">
//         <part name="parameters" element="tns:DateTimeDiff"/>
//     </message>
//     <message name="DateTimeDiff_Result">
//         <part name="parameters" element="tns:DateTimeDiff_Result"/>
//     </message>
//     <message name="SimpleTextVar">
//         <part name="parameters" element="tns:SimpleTextVar"/>
//     </message>
//     <message name="SimpleTextVar_Result">
//         <part name="parameters" element="tns:SimpleTextVar_Result"/>
//     </message>
//     <message name="SimpleText">
//         <part name="parameters" element="tns:SimpleText"/>
//     </message>
//     <message name="SimpleText_Result">
//         <part name="parameters" element="tns:SimpleText_Result"/>
//     </message>
//     <portType name="WsTest_Port">
//         <operation name="DateTimeDiff">
//             <input name="DateTimeDiff" message="tns:DateTimeDiff"/>
//             <output name="DateTimeDiff_Result" message="tns:DateTimeDiff_Result"/>
//         </operation>
//         <operation name="SimpleTextVar">
//             <input name="SimpleTextVar" message="tns:SimpleTextVar"/>
//             <output name="SimpleTextVar_Result" message="tns:SimpleTextVar_Result"/>
//         </operation>
//         <operation name="SimpleText">
//             <input name="SimpleText" message="tns:SimpleText"/>
//             <output name="SimpleText_Result" message="tns:SimpleText_Result"/>
//         </operation>
//     </portType>
//     <binding name="WsTest_Binding" type="tns:WsTest_Port">
//         <binding xmlns="http://schemas.xmlsoap.org/wsdl/soap/" transport="http://schemas.xmlsoap.org/soap/http"/>
//         <operation name="DateTimeDiff">
//             <operation xmlns="http://schemas.xmlsoap.org/wsdl/soap/" style="document" soapAction="urn:microsoft-dynamics-schemas/codeunit/WsTest:DateTimeDiff"/>
//             <input name="DateTimeDiff">
//                 <body xmlns="http://schemas.xmlsoap.org/wsdl/soap/" use="literal"/>
//             </input>
//             <output name="DateTimeDiff_Result">
//                 <body xmlns="http://schemas.xmlsoap.org/wsdl/soap/" use="literal"/>
//             </output>
//         </operation>
//         <operation name="SimpleTextVar">
//             <operation xmlns="http://schemas.xmlsoap.org/wsdl/soap/" style="document" soapAction="urn:microsoft-dynamics-schemas/codeunit/WsTest:SimpleTextVar"/>
//             <input name="SimpleTextVar">
//                 <body xmlns="http://schemas.xmlsoap.org/wsdl/soap/" use="literal"/>
//             </input>
//             <output name="SimpleTextVar_Result">
//                 <body xmlns="http://schemas.xmlsoap.org/wsdl/soap/" use="literal"/>
//             </output>
//         </operation>
//         <operation name="SimpleText">
//             <operation xmlns="http://schemas.xmlsoap.org/wsdl/soap/" style="document" soapAction="urn:microsoft-dynamics-schemas/codeunit/WsTest:SimpleText"/>
//             <input name="SimpleText">
//                 <body xmlns="http://schemas.xmlsoap.org/wsdl/soap/" use="literal"/>
//             </input>
//             <output name="SimpleText_Result">
//                 <body xmlns="http://schemas.xmlsoap.org/wsdl/soap/" use="literal"/>
//             </output>
//         </operation>
//     </binding>
//     <service name="WsTest">
//         <port name="WsTest_Port" binding="tns:WsTest_Binding">
//             <address xmlns="http://schemas.xmlsoap.org/wsdl/soap/" location="https://api.businesscentral.dynamics.com/v1.0/8ca4b31c-0d2d-4c60-8dea-e388d27fcb71/Sandbox/WS/CRONUS%20Danmark%20A%252FS/Codeunit/WsTest?tenant=msneua5672t00028824&aid=FIN"/>
//         </port>
//     </service>
// </definitions>


// <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:BC="urn:microsoft-dynamics-schemas/codeunit/WsTest"><soap:Header/><soap:Body><BC:SimpleText><BC:partxtInput>Hello World!</BC:partxtInput></BC:SimpleText></soap:Body></soap:Envelope>