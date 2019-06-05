codeunit 50025 "TTT-PR WsTestXmlWrapper"
{
    var
        xdocClass: XmlDocument;
        xnRoot: XmlNode;
        xnClass: XmlNode;
        xnClassCurrent: XmlNode;
        xnlClass: XmlNodeList;
        xnsmClass: XmlNamespaceManager;
        intCurrentNodeInList: Integer;
        lblXmlTrueTxt: Label 'true', Locked = true, Comment = 'Xml boolean must always be true/false in lowercase';
        lblXmlFalseTxt: Label 'false', Locked = true, Comment = 'Xml boolean must always be true/false in lowercase';
        lblXmlYesTxt: Label 'yes', Locked = true, Comment = 'The yes/no is used in xml declaration for standalone to ignore DTD';
        lblXmlNoTxt: Label 'no', Locked = true, Comment = 'The yes/no is used in xml declaration for standalone to ignore DTD';


    local procedure Initialize()
    begin
        Clear(xdocClass);
        Clear(xnRoot);
        Clear(xnClass);
        Clear(xnClassCurrent);
        Clear(xnlClass);
        Clear(xnsmClass);
        Clear(intCurrentNodeInList);
    end;

    procedure CreateDoc()
    begin
        CreateDoc(xdocClass);
    end;

    procedure CreateDoc(partxtVersion: Text; partxtEncoding: Text; parbooStandalone: Boolean): Boolean
    begin
        exit(CreateDoc(partxtVersion, partxtEncoding, Boolean2XmlYesNo(parbooStandalone)));
    end;

    procedure CreateDoc(partxtVersion: Text; partxtEncoding: Text; partxtStandalone: Text): Boolean
    begin
        CreateDoc();
        exit(AddDeclaration(partxtVersion, partxtEncoding, partxtStandalone));
    end;

    local procedure CreateDoc(var parvarxdocClass: XmlDocument)
    begin
        Initialize();
        xdocClass := XmlDocument.Create();
        xnClassCurrent := xdocClass.AsXmlNode();
    end;




    procedure Load(paristrmContent: InStream): Boolean
    begin
        Initialize();
        exit(XmlDocument.ReadFrom(paristrmContent, xdocClass));
    end;

    procedure Load(partxtContent: Text): Boolean
    begin
        Initialize();
        exit(XmlDocument.ReadFrom(partxtContent, xdocClass));
    end;




    procedure AddDeclaration(partxtVersion: Text; partxtEncoding: Text; parbooStandalone: Boolean): Boolean
    begin
        exit(AddDeclaration(partxtVersion, partxtEncoding, Boolean2XmlYesNo(parbooStandalone)));
    end;

    procedure AddDeclaration(partxtVersion: Text; partxtEncoding: Text; partxtStandalone: Text): Boolean
    var
        locxdecClass: XmlDeclaration;
    begin
        locxdecClass := XmlDeclaration.Create(partxtVersion, partxtEncoding, partxtStandalone);
        exit(xdocClass.SetDeclaration(locxdecClass));
    end;

    procedure AddNamespaceDeclaration(partxtPrefix: Text; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNamespaceDeclaration(xnClassCurrent, partxtPrefix, partxtNamespaceUri));
    end;

    local procedure AddNamespaceDeclaration(var parvarxnClass: XmlNode; partxtPrefix: Text; partxtNamespaceUri: Text): Boolean
    var
        locxaCreated: XmlAttribute;
    begin
        locxaCreated := XmlAttribute.CreateNamespaceDeclaration(partxtPrefix, partxtNamespaceUri);
        exit(parvarxnClass.AsXmlElement().Add(locxaCreated));
    end;




    procedure AddRootElement(partxtName: Text): Boolean
    begin
        exit(AddRootElement(partxtName, '', ''));
    end;

    procedure AddRootElement(partxtName: Text; partxtPrefix: Text; partxtNameSpaceUri: Text): Boolean
    begin
        exit(AddRootNode(xdocClass, partxtName, partxtPrefix, partxtNameSpaceUri, xnClassCurrent));
    end;

    local procedure AddRootNode(partxtName: Text; var parvarxdocBase: XmlDocument; var parvarxnCreated: XmlNode): Boolean
    begin
        exit(AddRootNode(parvarxdocBase, partxtName, '', '', parvarxnCreated));
    end;

    local procedure AddRootNode(var parvarxdocBase: XmlDocument; partxtName: Text; partxtPrefix: Text; partxtNameSpaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    var
        locxeCreated: XmlElement;
    begin
        if not CreateNode(partxtName, '', partxtPrefix, partxtNameSpaceUri, parvarxnCreated) then
            exit;
        if not parvarxdocBase.AddFirst(parvarxnCreated) then
            exit;
        if not xdocClass.GetRoot(locxeCreated) then
            exit;
        xnRoot := locxeCreated.AsXmlNode();
        xnClassCurrent := xnRoot;
        exit(true);
    end;




    procedure AddNode(partxtName: Text): Boolean
    begin
        exit(AddNode(partxtName, ''));
    end;

    procedure AddNode(partxtName: Text; partxtValue: Text): Boolean
    begin
        exit(AddNode(partxtName, partxtValue, ''));
    end;

    procedure AddNodeNS(partxtName: Text; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNode(partxtName, '', partxtNamespaceUri));
    end;

    procedure AddNode(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNode(xnClassCurrent, partxtName, partxtValue, partxtNamespaceUri, xnClass));
    end;

    procedure AddNodeFollow(partxtName: Text): Boolean
    begin
        exit(AddNodeFollowNS(partxtName, ''));
    end;

    procedure AddNodeFollow(partxtName: Text; partxtValue: Text): Boolean
    begin
        exit(AddNodeFollow(partxtName, partxtValue, ''));
    end;

    procedure AddNodeFollowNS(partxtName: Text; partxtNamespaceUri: Text): Boolean
    begin
        if not AddNode(xnClassCurrent, partxtName, '', partxtNamespaceUri, xnClass) then
            exit;
        xnClassCurrent := xnClass;
        exit(true);
    end;

    procedure AddNodeFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text): Boolean
    begin
        if not AddNode(xnClassCurrent, partxtName, partxtValue, partxtNamespaceUri, xnClass) then
            exit;
        xnClassCurrent := xnClass;
        exit(true);
    end;

    local procedure AddNode(var parvarxnClass: XmlNode; partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        if not CreateNode(partxtName, partxtValue, '', partxtNamespaceUri, parvarxnCreated) then
            exit;
        exit(parvarxnClass.AsXmlElement().Add(parvarxnCreated));
    end;

    local procedure AddNode(var parvarxnClass: XmlNode; partxtName: Text; parstrmValue: InStream; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        if not CreateNode(partxtName, Stream2Text(parstrmValue), '', partxtNamespaceUri, parvarxnCreated) then
            exit;
        exit(parvarxnClass.AsXmlElement().Add(parvarxnCreated));
    end;





    procedure AddNodeAttribute(partxtName: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNode(partxtName, '') then
            exit;
        AddAttribute(xnClass, partxtAttributeName, partxtAttributeValue, '');
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClass, partxtAttributeName, partxtAttributeValue, '');
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClass, partxtAttribute1Name, partxtAttribute1Value, '');
        AddAttribute(xnClass, partxtAttribute2Name, partxtAttribute2Value, '');
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, partxtNamespaceUri) then
            exit;
        AddAttribute(xnClass, partxtAttributeName, partxtAttributeValue, '');
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, partxtNamespaceUri) then
            exit;
        AddAttribute(xnClass, partxtAttribute1Name, partxtAttribute1Value, '');
        AddAttribute(xnClass, partxtAttribute2Name, partxtAttribute2Value, '');
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue, '');
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttribute1Name, partxtAttribute1Value, '');
        AddAttribute(xnClassCurrent, partxtAttribute2Name, partxtAttribute2Value, '');
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, partxtNamespaceUri) then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue, '');
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, partxtNamespaceUri) then
            exit;
        AddAttribute(xnClassCurrent, partxtAttribute1Name, partxtAttribute1Value, '');
        AddAttribute(xnClassCurrent, partxtAttribute2Name, partxtAttribute2Value, '');
        exit(true);
    end;




    procedure AddAttribute(partxtName: Text; partxtValue: Text)
    begin
        AddAttribute(xnClassCurrent, partxtName, partxtValue, '');
    end;

    procedure AddAttribute(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text)
    begin
        AddAttribute(xnClassCurrent, partxtName, partxtValue, partxtNamespaceUri);
    end;

    local procedure AddAttribute(var parvarxnClass: XmlNode; partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text)
    begin
        parvarxnClass.AsXmlElement().SetAttribute(partxtName, partxtValue, partxtNamespaceUri);
    end;

    local procedure AddAttribute(var parvarxeClass: XmlElement; partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text)
    begin
        parvarxeClass.SetAttribute(partxtName, partxtNamespaceUri, partxtValue);
    end;




    procedure AddNodeCData(partxtName: Text; partxtValue: Text): Boolean
    begin
        exit(AddNodeCData(xnClassCurrent, partxtName, partxtValue, '', xnClass));
    end;

    procedure AddNodeCData(partxtName: Text; parstrmValue: InStream): Boolean
    begin
        exit(AddNodeCData(xnClassCurrent, partxtName, parstrmValue, '', xnClass));
    end;

    procedure AddNodeCData(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNodeCData(xnClassCurrent, partxtName, partxtValue, partxtNamespaceUri, xnClass));
    end;

    procedure AddNodeCData(partxtName: Text; parstrmValue: InStream; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNodeCData(xnClassCurrent, partxtName, parstrmValue, partxtNamespaceUri, xnClass));
    end;

    local procedure AddNodeCData(var parvarxnClass: XmlNode; partxtName: Text; parstrmValue: InStream; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        exit(AddNodeCData(parvarxnClass, partxtName, Stream2Text(parstrmValue), partxtNamespaceUri, parvarxnCreated));
    end;

    local procedure AddNodeCData(var parvarxnClass: XmlNode; partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    var
        locxcdNewChild: XmlCData;
    begin
        if not (CreateNode(partxtName, '', '', partxtNamespaceUri, parvarxnCreated)) then
            exit;
        locxcdNewChild := XmlCData.Create(partxtValue);
        if not (parvarxnCreated.AsXmlElement().Add(locxcdNewChild)) then
            exit;
        exit(parvarxnClass.AsXmlElement().Add(parvarxnCreated));
    end;




    local procedure CreateNode(partxtName: Text; partxtValue: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        exit(CreateNode(partxtName, partxtValue, '', '', parvarxnCreated));
    end;

    local procedure CreateNode(partxtName: Text; partxtValue: Text; partxtPrefix: Text; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    var
        locxeCreated: XmlElement;
        locxaCreated: XmlAttribute;
    begin
        Clear(parvarxnCreated);
        if partxtValue <> '' then
            locxeCreated := XmlElement.Create(partxtName, partxtNameSpaceUri, partxtValue)
        else
            locxeCreated := XmlElement.Create(partxtName, partxtNameSpaceUri);
        parvarxnCreated := locxeCreated.AsXmlNode();
        if partxtPrefix <> '' then begin
            locxaCreated := XmlAttribute.CreateNamespaceDeclaration(partxtPrefix, partxtNameSpaceUri);
            if not parvarxnCreated.AsXmlElement().Add(locxaCreated) then
                exit;
        end;
        exit(true);
    end;




    procedure Save(var parvarstrmOut: OutStream)
    begin
        xdocClass.WriteTo(parvarstrmOut);
    end;

    procedure Save(var parvarstrmIn: InStream)
    var
        locrecBlob: Record TempBlob temporary;
        locstrmOut: OutStream;
    begin
        locrecBlob.Blob.CreateOutStream(locstrmOut);
        Save(locstrmOut);
        locrecBlob.Blob.CreateInStream(parvarstrmIn);
    end;

    procedure Save(partxtFilename: Text)
    begin
        Error('N/A');
    end;




    procedure GetXmlDocument(var parvarxdocClass: XmlDocument)
    begin
        parvarxdocClass := xdocClass;
    end;

    procedure SetXmlDocument(var parvarxdocClass: XmlDocument)
    begin
        xdocClass := parvarxdocClass;
    end;

    procedure SetXmlNode(var parvarxnClass: XmlNode)
    begin
        xnClass := parvarxnClass;
    end;

    procedure SetXmlNodeCurrent(var parvarxnCurrent: XmlNode)
    begin
        xnClassCurrent := parvarxnCurrent;
    end;

    procedure SetXmlNodeList(var parvarXmlNodeList: XmlNodeList)
    begin
        xnlClass := parvarXmlNodeList;
    end;

    procedure Copy(var parvarcuToCodeunit: Codeunit "TTT-PR WsTestXmlWrapper")
    begin
        parvarcuToCodeunit.SetXmlDocument(xdocClass);
        parvarcuToCodeunit.SetXmlNode(xnClass);
        parvarcuToCodeunit.SetXmlNodeCurrent(xnClassCurrent);
        parvarcuToCodeunit.SetXmlNodeList(xnlClass);
    end;




    procedure ImportDocumentNode(var parvarcuFromCodeunit: Codeunit "TTT-PR WsTestXmlWrapper")
    var
        locxdocClass: XmlDocument;
    begin
        parvarcuFromCodeunit.GetXmlDocument(locxdocClass);
        ImportDocumentNode(xnClassCurrent, locxdocClass);
    end;

    local procedure ImportDocumentNode(var parvarxnClass: XmlNode; parxdocClass: XmlDocument): Boolean
    var
        locxeDoc: XmlElement;
    begin
        // Convert the document to an element
        if not parxdocClass.GetRoot(locxeDoc) then
            exit;
        // Add the converted element to the requested node
        exit(parvarxnClass.AsXmlElement().Add(locxeDoc));
    end;




    procedure GetOuterXml(): Text
    var
        loctxtXml: Text;
    begin
        if GetOuterXml(loctxtXml) then
            exit(loctxtXml);
    end;

    procedure GetOuterXml(parbooPreserveWhitespace: Boolean): Text
    var
        loctxtXml: Text;
    begin
        if GetOuterXml(loctxtXml, parbooPreserveWhitespace) then
            exit(loctxtXml);
    end;

    procedure GetOuterXml(var parvartxtXml: Text): Boolean
    begin
        exit(GetOuterXml(parvartxtXml, false));
    end;

    procedure GetOuterXml(var parvartxtXml: Text; parbooPreserveWhitespace: Boolean): Boolean
    begin
        exit(GetOuterXml(xdocClass, parvartxtXml, parbooPreserveWhitespace));
    end;

    procedure GetOuterXml(var parvarostrmXml: OutStream): Boolean
    begin
        exit(GetOuterXml(parvarostrmXml, false));
    end;

    procedure GetOuterXml(var parvarostrmXml: OutStream; parbooPreserveWhitespace: Boolean): Boolean
    begin
        exit(GetOuterXml(xdocClass, parvarostrmXml, parbooPreserveWhitespace));
    end;

    local procedure GetOuterXml(var parvarxdClass: XmlDocument; var parvartxtXml: Text; parbooPreserveWhitespace: Boolean): Boolean
    var
        locxwo: XmlWriteOptions;
    begin
        locxwo.PreserveWhitespace(parbooPreserveWhitespace);
        exit(parvarxdClass.WriteTo(locxwo, parvartxtXml));
    end;

    local procedure GetOuterXml(var parvarxdClass: XmlDocument; var parvarostrmXml: OutStream; parbooPreserveWhitespace: Boolean): Boolean
    var
        locxwo: XmlWriteOptions;
    begin
        locxwo.PreserveWhitespace(parbooPreserveWhitespace);
        exit(parvarxdClass.WriteTo(locxwo, parvarostrmXml));
    end;




    procedure ShowXml()
    begin
        Message(GetOuterXml());
    end;

    procedure ShowXml(partxtHeader: Text)
    begin
        Message('%1:\%2', GetOuterXml());
    end;

    procedure ShowCurrentNode()
    begin
        Message('%1', Format(xnClassCurrent));
    end;




    procedure GoToParentLevel()
    var
        locxe: XmlElement;
    begin
        if xnClassCurrent.GetParent(locxe) then
            xnClassCurrent := locxe.AsXmlNode();
        Clear(xnClass);
    end;

    procedure GoToLowerLevel()
    begin
        xnClassCurrent := xnClass;
        Clear(xnClass);
    end;




    procedure HasChildNodes(): Boolean
    begin
        exit(xnClassCurrent.AsXmlElement().HasElements());
    end;

    procedure GoToFirstChild(): Boolean
    begin
        Clear(intCurrentNodeInList);
        if not HasChildNodes() then
            exit;

        xnlClass := xnClassCurrent.AsXmlElement().GetChildNodes();
        intCurrentNodeInList := 1;
        exit(GetNodeListItem(intCurrentNodeInList));
    end;

    procedure GoToNextSibling(): Boolean
    begin
        intCurrentNodeInList += 1;
        exit(GetNodeListItem(intCurrentNodeInList));
    end;

    procedure GetNodeListItem(parintItemIndex: Integer): Boolean
    begin
        if parintItemIndex < 0 then
            exit(false);
        exit(xnlClass.Get(parintItemIndex, xnClassCurrent));
    end;




    procedure CreateNamespaceManager()
    begin
        xnsmClass.NameTable(xdocClass.NameTable());
    end;

    procedure AddNamespace(partxtPrefix: Text; partxtUri: Text)
    begin
        if xnsmClass.HasNamespace(partxtPrefix) then
            exit;
        xnsmClass.AddNamespace(partxtPrefix, partxtUri);
    end;




    procedure FindNodes(partxtNodePath: Text): Integer
    begin
        Clear(xnlClass);
        if not xdocClass.SelectNodes(partxtNodePath, xnsmClass, xnlClass) then
            exit;
        exit(xnlClass.Count());
    end;

    procedure FindNode(partxtNodePath: Text): Boolean
    begin
        Clear(xnClassCurrent);
        exit(xdocClass.SelectSingleNode(partxtNodePath, xnsmClass, xnClassCurrent));
    end;

    procedure FindChildsOfNode(partxtNodePath: Text): Integer
    begin
        if not FindNode(partxtNodePath) then
            exit;
        if not HasChildNodes() then
            exit;
        xnlClass := xnClassCurrent.AsXmlElement().GetChildNodes();
        intCurrentNodeInList := 1;
        if not GetNodeListItem(intCurrentNodeInList) then
            exit;
        exit(xnlClass.Count());
    end;

    procedure FindChildsOfNode(partxtNodePath: Text; var parvardictValues: Dictionary of [text, text]): Boolean
    begin
        Clear(parvardictValues);
        if FindChildsOfNode(partxtNodePath) = 0 then
            exit;
        repeat
            parvardictValues.Add(GetNodeName(), GetNodeText());
        until not GoToNextSibling();
        exit(true);
    end;

    procedure FindChildsOfNode(partxtNodePath: Text; var parvarlstValues: List of [text]): Boolean
    var
        loctxtValue: Text;
    begin
        Clear(parvarlstValues);
        if FindChildsOfNode(partxtNodePath) = 0 then
            exit;
        repeat
            loctxtValue := GetNodeText();
            if not parvarlstValues.Contains(loctxtValue) then
                parvarlstValues.Add(loctxtValue);
        until not GoToNextSibling();
        exit(true);
    end;

    procedure GetNodeName(): Text
    begin
        exit(xnClassCurrent.AsXmlElement().Name());
    end;

    procedure GetNodeText() ReturnValue: Text
    begin
        exit(xnClassCurrent.AsXmlElement().InnerXml());
    end;

    procedure GetNodeCDataTxtFieldRef(var parvarfrBlob: FieldRef): Boolean
    var
        locxcdClass: XmlCData;
    begin
        if not GetCDataChild(xnClassCurrent, locxcdClass) then
            exit;
        exit(GetCDataTxtFieldRef(locxcdClass, parvarfrBlob));
    end;

    procedure GetNodeAttributeText(partxtName: Text): Text
    var
        locxaClass: XmlAttribute;
    begin
        if not GetAttributeNode(xnClassCurrent, partxtName, locxaClass) then
            exit;
        exit(locxaClass.Value());
    end;

    local procedure GetAttributeNode(parxnIn: XmlNode; partxtName: Text; var parvarxaOut: XmlAttribute): Boolean
    var
        locxacClass: XmlAttributeCollection;
        locxeClass: XmlElement;
    begin
        Clear(parvarxaOut);
        locxeClass := parxnIn.AsXmlElement();
        if not locxeClass.HasAttributes() then
            exit;
        locxacClass := locxeClass.Attributes();
        exit(locxacClass.Get(partxtName, parvarxaOut));
    end;

    local procedure GetCDataChild(parxnClass: XmlNode; var parvarxcdResult: XmlCData): Boolean
    var
        locxnlClass: XmlNodeList;
        locxnClass: XmlNode;
        locxeClass: XmlElement;
    begin
        Clear(parvarxcdResult);
        locxeClass := parxnClass.AsXmlElement();
        if not locxeClass.HasElements() then
            exit;
        locxnlClass := locxeClass.GetChildNodes();
        if locxnlClass.Count() = 0 then
            exit;
        locxnlClass.Get(1, locxnClass);
        if not locxnClass.IsXmlCData() then
            exit;
        parvarxcdResult := locxnClass.AsXmlCData();
        exit(true);
    end;

    local procedure GetCDataTxtFieldRef(parxcdClass: XmlCData; var parvarfrBlob: FieldRef): Boolean
    var
        loctmprecBlob: Record "TempBlob" temporary;
        locrrBlob: RecordRef;
        locfrBlob: FieldRef;
        locstrmBlob: OutStream;
        loctxtBlob: Text;
    begin
        loctxtBlob := parxcdClass.Value();
        loctmprecBlob.Blob.CreateOutStream(locstrmBlob);
        locstrmBlob.Write(loctxtBlob);
        locrrBlob.GetTable(loctmprecBlob);
        locfrBlob := locrrBlob.Field(loctmprecBlob.FieldNo(Blob));
        parvarfrBlob.Value := locfrBlob.Value();
        exit(true);
    end;




    procedure GetCRC() ReturnValue: Integer
    var
    // loctmprecSetup: Record "PAL Setup" temporary;
    // loccuCrc: Codeunit "PAL CrcManagement";
    // locstrmIn: InStream;
    // locstrmOut: OutStream;
    // loctxtContent: Text;
    begin
        Error('GetCRC() not handled in this extension')
        // loctmprecSetup."PAL TempBlob".CreateOutStream(locstrmOut);
        // xdClass.WriteTo(locstrmOut);

        // loctmprecSetup."PAL TempBlob".CreateInStream(locstrmIn);
        // if locstrmIn.Read(loctxtContent) = 0 then
        //     exit;
        // loccuCrc.GetCRC(loctxtContent, ReturnValue);
    end;




    procedure Boolean2XmlString(parbooValue: Boolean): Text
    begin
        if parbooValue then
            exit(lblXmlTrueTxt)
        else
            exit(lblXmlFalseTxt);
    end;

    procedure Boolean2XmlYesNo(parbooValue: Boolean): Text
    begin
        if parbooValue then
            exit(lblXmlYesTxt)
        else
            exit(lblXmlNoTxt);
    end;

    local procedure Stream2Text(parstrmValue: InStream) ReturnValue: Text
    var
        locintRead: Integer;
    begin
        locintRead := parstrmValue.Read(ReturnValue);
    end;
}
