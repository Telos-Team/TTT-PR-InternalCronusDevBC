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
        xnClassCurrent := xdocClass.AsXmlNode();
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




    procedure Load(paristrmContent: InStream): Boolean
    begin
        exit(XmlDocument.ReadFrom(paristrmContent, xdocClass));
    end;

    procedure Load(partxtContent: Text): Boolean
    begin
        exit(XmlDocument.ReadFrom(partxtContent, xdocClass));
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




    procedure Class_GoToParentLevel()
    var
        locxe: XmlElement;
    begin
        if xnClassCurrent.GetParent(locxe) then
            xnClassCurrent := locxe.AsXmlNode();
        Clear(xnClass);
    end;

    procedure Class_GoToLowerLevel()
    begin
        xnClassCurrent := xnClass;
        Clear(xnClass);
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
