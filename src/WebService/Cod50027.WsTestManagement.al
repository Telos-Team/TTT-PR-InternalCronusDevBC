codeunit 50027 "TTT-PR WsTestManagement"
{
    var
        cuXml: Codeunit "TTT-PR WsTestXmlWrapper";
        txtNsUriTxt: Text;
        lblPalSoapNsUriTxt: Label 'http://www.w3.org/2003/05/soap-envelope';
        lblPalXsiNsUriTxt: Label 'http://www.w3.org/2001/XMLSchema-instance';
        lblPalXsdNsUriTxt: Label 'http://www.w3.org/2001/XMLSchema';
        lblPalNsUriTxt: Label 'http://palette.se/';
        lblBcSoapNsUriTxt: Label 'http://schemas.xmlsoap.org/soap/envelope/';
        lblBcNsUriTxt: Label 'urn:microsoft-dynamics-schemas/codeunit/%1';

    procedure Initalize(partxtVersion: Text; partxtEncoding: Text; parbooStandalone: Boolean)
    begin
        Clear(cuXml);
        cuXml.CreateDoc(partxtVersion, partxtEncoding, parbooStandalone);
    end;

    procedure Initalize4Bc(partxtService: Text; partxtMethod: Text)
    begin
        Initalize('1.0', 'utf-8', true);
        txtNsUriTxt := StrSubstNo(lblBcNsUriTxt, partxtService);
        AddRoot4Bc();
        AddHeader4Bc();
        AddBody4Bc();
        AddMethod4Bc(partxtMethod);
    end;

    procedure Initalize4Pal(partxtMethod: Text)
    begin
        Initalize('1.0', 'utf-8', true);
        txtNsUriTxt := lblPalNsUriTxt;
        AddRoot4Pal();
        AddBody4Pal();
        AddMethod4Pal(partxtMethod);
    end;

    procedure AddRoot(partxtName: Text; partxtPrefix: Text; partxtNamespaceUri: Text)
    begin
        cuXml.AddRootElement(partxtName, partxtPrefix, partxtNamespaceUri);
    end;

    procedure AddRoot4Bc()
    begin
        cuXml.AddRootElement('Envelope', 'soap', lblBcSoapNsUriTxt);
        cuXml.AddNamespaceDeclaration('bc', txtNsUriTxt);
    end;

    procedure AddRoot4Pal()
    begin
        cuXml.AddRootElement('Envelope', 'soap12', lblPalSoapNsUriTxt);
        cuXml.AddNamespaceDeclaration('xsi', lblPalXsiNsUriTxt);
        cuXml.AddNamespaceDeclaration('xsd', lblPalXsdNsUriTxt);
        cuXml.AddNamespaceDeclaration('pal', txtNsUriTxt);
    end;

    procedure AddNameSpaceDeclaration(partxtPrefix: Text; partxtNamespaceUri: Text)
    begin
        cuXml.AddNamespaceDeclaration(partxtPrefix, partxtNamespaceUri);
    end;

    procedure AddHeader4Bc()
    begin
        cuXml.AddNode('Header', '', lblBcSoapNsUriTxt);
    end;

    procedure AddTag(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text)
    begin
        cuXml.AddNode(partxtName, partxtValue, partxtNamespaceUri);
    end;

    procedure AddTagFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text)
    begin
        cuXml.AddNodeFollow(partxtName, partxtValue, partxtNamespaceUri);
    end;

    procedure AddAuthentication4Pal(partxtEnvironment: Text; partxtUserID: Text; partxtPassword: Text)
    begin
        cuXml.AddNode('Environment', partxtEnvironment, txtNsUriTxt);
        cuXml.AddNode('UserID', partxtUserID, txtNsUriTxt);
        cuXml.AddNode('Password', partxtPassword, txtNsUriTxt);
    end;

    procedure AddBody4Bc()
    begin
        cuXml.AddNodeFollow('Body', '', lblBcSoapNsUriTxt);
    end;

    procedure AddBody4Pal()
    begin
        cuXml.AddNodeFollow('Body', '', lblPalSoapNsUriTxt);
    end;

    procedure AddMethod4Bc(partxtMethod: Text)
    begin
        cuXml.AddNodeFollow(partxtMethod, '', txtNsUriTxt);
    end;

    procedure AddMethod4Pal(partxtMethod: Text)
    begin
        cuXml.AddNodeFollow(partxtMethod, '', txtNsUriTxt);
    end;

    procedure AddParameter4Bc(partxtName: Text; partxtValue: Text)
    begin
        cuXml.AddNode(partxtName, partxtValue, txtNsUriTxt);
    end;

    procedure AddRecord(var parvarcuXmlRecord: Codeunit "TTT-PR WsTestXmlWrapper")
    begin
        cuXml.ImportDocumentNode(parvarcuXmlRecord);
    end;

    procedure GetOuterXml(): Text
    begin
        exit(cuXml.GetOuterXml());
    end;

    procedure Decode4Bc(partxtXml: Text; partxtMethod: Text; var parvardictValues: Dictionary of [text, text]): Boolean
    var
        locintNodes: Integer;
    begin
        Clear(parvardictValues);
        Clear(cuXml);
        cuXml.Load(partxtXml);
        cuXml.CreateNamespaceManager();
        cuXml.AddNamespace('soap', lblBcSoapNsUriTxt);
        cuXml.AddNamespace('bc', txtNsUriTxt); // Fake, because it is a default namespace in the response!
        locintNodes := cuXml.FindNodes('soap:Envelope/soap:Body/bc:' + partxtMethod + '_Result');
        if locintNodes = 0 then
            exit;
        cuXml.GetNodeListItem(1);
        if not cuXml.GoToFirstChild() then
            exit(true);
        repeat
            Message('%1', cuXml.GetNodeName());
            parvardictValues.Add(cuXml.GetNodeName(), cuXml.GetNodeText());
        until cuXml.GoToNextSibling() = false;
        exit(true);
    end;

    procedure Decode4Pal(partxtXml: Text; partxtMethod: Text; var parvardictValues: Dictionary of [text, text]): Boolean
    var
        loctxtXPath: Text;
    begin
        Decode4Pal(partxtXml, partxtMethod);
        loctxtXPath := StrSubstNo('soap:Envelope/soap:Body/pal:%1Response/pal:%1Result', partxtMethod);
        exit(cuXml.FindChildsOfNode(loctxtXPath, parvardictValues));
    end;

    procedure Decode4Pal(partxtXml: Text; partxtMethod: Text; var parvarlstValues: List of [text]): Boolean
    var
        loctxtXPath: Text;
    begin
        Decode4Pal(partxtXml, partxtMethod);
        loctxtXPath := StrSubstNo('soap:Envelope/soap:Body/pal:%1Response/pal:%1Result', partxtMethod);
        exit(cuXml.FindChildsOfNode(loctxtXPath, parvarlstValues));
    end;

    local procedure Decode4Pal(partxtXml: Text; partxtMethod: Text)
    begin
        Clear(cuXml);
        cuXml.Load(partxtXml);
        cuXml.CreateNamespaceManager();
        cuXml.AddNamespace('soap', lblPalSoapNsUriTxt);
        cuXml.AddNamespace('xsi', lblPalXsiNsUriTxt);
        cuXml.AddNamespace('xsd', lblPalXsdNsUriTxt);
        cuXml.AddNamespace('soap', lblPalSoapNsUriTxt);
        cuXml.AddNamespace('pal', txtNsUriTxt); // Fake pal, because it is a default namespace in the response!
    end;

    procedure Dictionary2Text(pardictValues: Dictionary of [text, text]; partxtDivider: Text): Text
    var
        locbtOutput: BigText;
        locintLoop: Integer;
        loclstKeys: List of [Text];
        loclstValues: List of [Text];
    begin
        if pardictValues.Count() = 0 then
            exit;
        loclstKeys := pardictValues.Keys();
        loclstValues := pardictValues.Values();
        for locintLoop := 1 to pardictValues.Count() do
            locbtOutput.AddText(StrSubstNo('%1=%2%3', loclstKeys.Get(locintLoop), loclstValues.Get(locintLoop), partxtDivider));
        exit(Format(locbtOutput));
    end;

    procedure List2Text(parlstValues: List of [text]; partxtDivider: Text): Text
    var
        locbtOutput: BigText;
        locintCount: Integer;
        locintLoop: Integer;
        loctxtValue: Text;
    begin
        locintCount := parlstValues.Count();
        if locintCount = 0 then
            exit;
        for locintLoop := 1 to locintCount do
            if parlstValues.Get(locintLoop, loctxtValue) then
                locbtOutput.AddText(StrSubstNo('%1%2', loctxtValue, partxtDivider));
        exit(Format(locbtOutput));
    end;

    procedure ShowXmlBuffer()
    var
        loctmprecXmlBuffer: Record "XML Buffer";
    begin
        loctmprecXmlBuffer.LoadFromText(cuXml.GetOuterXml());
        Clear(loctmprecXmlBuffer);
        Page.Run(Page::"TTT-PR XmlBuffer", loctmprecXmlBuffer);
    end;

    procedure TEMP_LoadIntoXmlBuffer()
    var
        loctmprecXmlBuffer: Record "XML Buffer";
    begin
        loctmprecXmlBuffer.LoadFromText(cuXml.GetOuterXml());
        Clear(loctmprecXmlBuffer);
        loctmprecXmlBuffer.FindSet();
        repeat
        until loctmprecXmlBuffer.Next() = 0;
    end;
}
