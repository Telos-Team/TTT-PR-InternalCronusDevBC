codeunit 50025 "TTT-PR WsTestXmlWrapper"
{
    var
        xdocClass: XmlDocument;
        xnRoot: XmlNode;
        xnClass: XmlNode;
        xnClassCurrent: XmlNode;
        xnlClass: XmlNodeList;
        lblXmlTrueTxt: Label 'true';
        lblXmlFalseTxt: Label 'false';


    procedure CreateDoc()
    begin
        CreateDoc(xdocClass);
    end;

    local procedure CreateDoc(var parvarxdocClass: XmlDocument)
    begin
        Clear(xdocClass);
        xdocClass := XmlDocument.Create();
    end;

    procedure CreateDoc(partxtVersion: Text; partxtEncoding: Text; parbooStandalone: Boolean): Boolean
    begin
        exit(CreateDoc(partxtVersion, partxtEncoding, Boolean2XmlText(parbooStandalone)));
    end;

    procedure CreateDoc(partxtVersion: Text; partxtEncoding: Text; partxtStandalone: Text): Boolean
    begin
        CreateDoc();
        exit(AddDeclaration(partxtVersion, partxtEncoding, partxtStandalone));
    end;

    procedure AddDeclaration(partxtVersion: Text; partxtEncoding: Text; parbooStandalone: Boolean): Boolean
    begin
        exit(AddDeclaration(partxtVersion, partxtEncoding, Boolean2XmlText(parbooStandalone)));
    end;

    procedure AddDeclaration(partxtVersion: Text; partxtEncoding: Text; partxtStandalone: Text): Boolean
    var
        locxdecClass: XmlDeclaration;
    begin
        locxdecClass := XmlDeclaration.Create(partxtVersion, partxtEncoding, partxtStandalone);
        exit(xdocClass.SetDeclaration(locxdecClass));
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
        exit(true);
    end;






    procedure AddNode(partxtName: Text; partxtValue: Text): Boolean
    begin
        exit(AddNode(partxtName, partxtValue, ''));
    end;

    procedure AddNode(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNode(xnClassCurrent, partxtName, partxtValue, partxtNamespaceUri, xnClass));
    end;

    procedure AddNodeFollow(partxtName: Text; partxtValue: Text): Boolean
    begin
        exit(AddNodeFollow(partxtName, partxtValue, ''));
    end;

    procedure AddNodeFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text): Boolean
    begin
        exit(AddNode(xnClassCurrent, partxtName, partxtValue, partxtNamespaceUri, xnClassCurrent));
    end;

    local procedure AddNode(var parvarxnClass: XmlNode; partxtName: Text; parstrmValue: InStream; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        if not CreateNode(partxtName, Stream2Text(parstrmValue), '', partxtNamespaceUri, parvarxnCreated) then
            exit;
        exit(parvarxnClass.AsXmlElement().Add(parvarxnCreated));
    end;

    local procedure AddNode(var parvarxnClass: XmlNode; partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        if not CreateNode(partxtName, partxtValue, '', partxtNamespaceUri, parvarxnCreated) then
            exit;
        exit(parvarxnClass.AsXmlElement().Add(parvarxnCreated));
    end;






    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttribute(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNode(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttributeName: Text; partxtAttributeValue: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddNodeAttributeFollow(partxtName: Text; partxtValue: Text; partxtNamespaceUri: Text; partxtAttribute1Name: Text; partxtAttribute1Value: Text; partxtAttribute2Name: Text; partxtAttribute2Value: Text): Boolean
    begin
        if not AddNodeFollow(partxtName, partxtValue, '') then
            exit;
        AddAttribute(xnClassCurrent, partxtAttributeName, partxtAttributeValue);
        exit(true);
    end;

    procedure AddAttribute(partxtName: Text; partxtValue: Text)
    begin
        AddAttribute(xnClassCurrent, partxtName, partxtValue);
    end;

    local procedure AddAttribute(var parvarxnClass: XmlNode; partxtName: Text; partxtValue: Text)
    begin
        parvarxnClass.AsXmlElement().SetAttribute(partxtName, partxtValue);
    end;

    local procedure AddAttribute(var parvarxeClass: XmlElement; partxtName: Text; partxtValue: Text)
    begin
        parvarxeClass.SetAttribute(partxtName, partxtValue);
    end;

    local procedure AddAttribute(var parvarxnClass: XmlNode; partxtName: Text; partxtUri: Text; partxtValue: Text)
    begin
        parvarxnClass.AsXmlElement().SetAttribute(partxtName, partxtUri, partxtValue);
    end;

    local procedure AddAttribute(var parvarxeClass: XmlElement; partxtName: Text; partxtUri: Text; partxtValue: Text)
    begin
        parvarxeClass.SetAttribute(partxtName, partxtUri, partxtValue);
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
        if not (CreateNode(partxtName, '', partxtNamespaceUri, parvarxnCreated)) then
            exit;
        locxcdNewChild := XmlCData.Create(partxtValue);
        if not (parvarxnCreated.AsXmlElement().Add(locxcdNewChild)) then
            exit;
        exit(parvarxnClass.AsXmlElement().Add(parvarxnCreated));
    end;






    local procedure CreateNode(partxtName: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        exit(CreateNode(partxtName, '', parvarxnCreated));
    end;

    local procedure CreateNode(partxtName: Text; partxtValue: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        exit(CreateNode(partxtName, partxtValue, '', '', parvarxnCreated));
    end;

    local procedure CreateNode(partxtName: Text; partxtPrefix: Text; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    begin
        exit(CreateNode(partxtName, '', partxtPrefix, partxtNamespaceUri, parvarxnCreated));
    end;

    local procedure CreateNode(partxtName: Text; partxtValue: Text; partxtPrefix: Text; partxtNamespaceUri: Text; var parvarxnCreated: XmlNode): Boolean
    var
        locxeCreated: XmlElement;
        locxaCreated: XmlAttribute;
    begin
        Clear(parvarxnCreated);
        locxeCreated := XmlElement.Create(partxtName, partxtNameSpaceUri, partxtValue);
        parvarxnCreated := locxeCreated.AsXmlNode();
        if (partxtPrefix <> '') or (partxtNameSpaceUri <> '') then begin
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

    local procedure ImportDocumentNode(var parvarxnClass: XmlNode; parxdocClass: XmlDocument)
    var
        locxnDoc: XmlNode;
    begin
        // Convert the document to a node
        locxnDoc := parxdocClass.AsXmlNode();
        // Add the node to the requested node
        parvarxnClass.AsXmlDocument().Add(locxnDoc);
    end;




    procedure GetOuterXml(): Text
    var
        loctxtXml: Text;
    begin
        if GetOuterXml(loctxtXml) then
            exit(loctxtXml);
    end;

    procedure GetOuterXml(var parvartxtXml: Text): Boolean
    begin
        exit(GetOuterXml(xdocClass, parvartxtXml));
    end;

    procedure GetOuterXml(var parvarostrmXml: OutStream): Boolean
    begin
        exit(GetOuterXml(xdocClass, parvarostrmXml));
    end;

    local procedure GetOuterXml(var parvarxdClass: XmlDocument; var parvartxtXml: Text): Boolean
    begin
        exit(parvarxdClass.WriteTo(parvartxtXml));
    end;

    local procedure GetOuterXml(var parvarxdClass: XmlDocument; var parvarostrmXml: OutStream): Boolean
    begin
        exit(parvarxdClass.WriteTo(parvarostrmXml));
    end;




    procedure ShowXml()
    begin
        Message(GetOuterXml());
    end;

    procedure ShowXml(partxtHeader: Text)
    begin
        Message('%1:\%2', GetOuterXml());
    end;








    local procedure Boolean2XmlText(parbooValue: Boolean): Text
    begin
        if parbooValue then
            exit(lblXmlTrueTxt)
        else
            exit(lblXmlFalseTxt);
    end;

    local procedure Stream2Text(parstrmValue: InStream) ReturnValue: Text
    var
        locintRead: Integer;
    begin
        locintRead := parstrmValue.Read(ReturnValue);
    end;



}