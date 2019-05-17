codeunit 50021 "TTT-PR HyperlinkWrapper"
{
    trigger OnRun()
    begin
        Testor1();
    end;

    local procedure Testor1()
    begin
        ActivateContentHyperlink('MyFile.xml', 'application/xml', '<root><record><field name="field1">value1</field><field name="field2">value2</field></record><record><field name="field1">value3</field><field name="field2">value4</field></record></root>');
    end;

    procedure ActivateContentHyperlink(partxtName: Text; partxtType: Text; parvarContent: Variant)
    var
        loctxtContent: Text;
        locstrmContent: InStream;
    begin
        case true of
            parvarContent.IsInStream():
                begin
                    locstrmContent := parvarContent;
                    ActivateContentHyperlink(partxtName, partxtType, locstrmContent);
                    exit;
                end;
            else
                loctxtContent := Format(parvarContent);
        end;
        ActivateContentHyperlink(partxtName, partxtType, loctxtContent);
    end;

    procedure ActivateContentHyperlink(partxtName: Text; partxtType: Text; parstrmContent: InStream)
    var
        loctxtContent: Text;
    begin
        parstrmContent.Read(loctxtContent);
        ActivateContentHyperlink(partxtName, partxtType, loctxtContent);
    end;

    procedure ActivateContentHyperlink(partxtName: Text; partxtType: Text; partxtContent: Text)
    var
        loctxtUrl: Text;
    begin
        if partxtType = '' then
            partxtType := lblMimeApplicationXmlLbl;
        loctxtUrl := StoreContent(partxtName, partxtType, partxtContent);
        Hyperlink(loctxtUrl);
    end;

    local procedure StoreContent(partxtName: Text; partxtType: Text; partxtContent: Text) Url: Text
    var
        lochcltRequest: HttpClient;
        lochcontRequest: HttpContent;
        lochcontResponse: HttpContent;
        lochrespMessage: HttpResponseMessage;
        locjoRequest: JsonObject;
        locjoResponse: JsonObject;
        locjtID: JsonToken;
        locbooOK: Boolean;
        loctxtRequest: Text;
        loctxtResponse: Text;
        loctxtID: Text;
    begin
        locjoRequest.Add('user', ConvertStr(UserId(), '\', '-'));
        locjoRequest.Add('tenant', TenantId());
        locjoRequest.Add('name', partxtName);
        locjoRequest.Add('type', partxtType);
        locjoRequest.Add('content', partxtContent);
        locjoRequest.WriteTo(loctxtRequest);

        lochcontRequest.WriteFrom(loctxtRequest);
        if lochcltRequest.Post(
                GetStoreUrlMask(),
                lochcontRequest,
                lochrespMessage) then
            locbooOK := true;
        if locboook then
            locbooOK := lochrespMessage.IsSuccessStatusCode();
        if not locbooOK then
            error(lblHttpErr, lochrespMessage.HttpStatusCode(), lblStoreUrlTok, lochrespMessage.ReasonPhrase());

        lochcontResponse := lochrespMessage.Content();
        lochcontResponse.ReadAs(loctxtResponse);
        locjoResponse.ReadFrom(loctxtResponse);
        locjoResponse.Get('id', locjtID);
        locjtID.WriteTo(loctxtID);
        loctxtID := DelChr(loctxtID, '<>', '"');

        Url := GetShowUrlMask(loctxtID);
    end;

    local procedure GetStoreUrlMask(): Text
    begin
        Exit(
            StrSubstNo(
                lblStoreUrlMaskTxt,
                lblStoreUrlTok,
                lblStoreKeyTok))
    end;

    local procedure GetShowUrlMask(partxtID: Text): Text
    begin
        Exit(
            StrSubstNo(
                lblShowUrlMaskTxt,
                lblShowUrlTok,
                lblShowKeyTok,
                TenantId(),
                partxtID))
    end;

    var
        //lblMimeTextHtmlLbl: Label 'text/html', Comment = 'Used for ContentType.', MaxLength = 999, Locked = true;
        lblMimeApplicationXmlLbl: Label 'application/xml', Comment = 'Used for ContentType.', MaxLength = 999, Locked = true;
        lblHttpErr: Label 'Status: %1\Url: %2\%3', Comment = '%1=StatusCode, %2=Store Url, %3=ReasonPhrase';
        lblStoreUrlMaskTxt: Label '%1?code=%2';
        lblShowUrlMaskTxt: Label '%1?code=%2&tenant=%3&id=%4';
        lblStoreUrlTok: Label 'https://palette-hyperlink-app.azurewebsites.net/api/StoreContent';
        lblShowUrlTok: Label 'https://palette-hyperlink-app.azurewebsites.net/api/ShowContent';
        lblStoreKeyTok: Label 'NObaxZiQCUvWSDuDAxlZivpThpgwZeYxkKqo2XNGHeYwHineT4T41g==';
        lblShowKeyTok: Label 'N06wn/1624tr0rCshKMNcS6iXCFTZnf1BYtMIeNxcP6cju9lRZwfQg==';
}
