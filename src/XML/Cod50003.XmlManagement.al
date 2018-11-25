codeunit 50003 "TTTPRXmlManagement"
{
    trigger OnRun();
    begin
        // TestorLoadClientXml();
        TestorCreateXml();
    end;

    var

    local procedure TestorLoadClientXml();
    var
        locxmlDoc: XmlDocument;
        locbooOK: Boolean;
    begin
        locbooOK := LoadClientXml(locxmlDoc);
        // Message('%1', format(xmlDoc));
        Message('LoadXml:\%1, %2', locbooOK, locxmlDoc.GetChildNodes().Count());
    end;

    local procedure LoadClientXml(var parvarxmlDoc: XmlDocument): Boolean;
    var
        loclblDialogTitleLbl: Label 'Please select XML file', Comment = 'This is the title shown on the upload dialog';
        loclblFromFilterLbl: Label '', Comment = 'This is the filter used when selecting file to upload';
        loctxtFromFolder: Text;
        loctxtClientFilename: Text;
        locstrmXml: InStream;
    begin
        loctxtClientFilename := '';
        if not UploadIntoStream(loclblDialogTitleLbl, loctxtFromFolder, loclblFromFilterLbl, loctxtClientFilename, locstrmXml) then
            exit;
        if not XmlDocument.ReadFrom(locstrmXml, parvarxmlDoc) then
            exit;
        exit(true);
    end;

    local procedure TestorCreateXml();
    var
        locxmlDoc: XmlDocument;
        locbooOK: Boolean;
        loctxtXml: Text;
    begin
        locbooOK := CreateXml(locxmlDoc);
        Message('CreateXml:\%1, %2', locbooOK, locxmlDoc.GetChildNodes().Count());
        if locxmlDoc.WriteTo(loctxtXml) then
            message('%1', loctxtXml);
    end;

    local procedure CreateXml(var parvarxmlDoc: XmlDocument): Boolean;
    var
        locxmlRoot: XmlElement;
        locxmlAttribute: XmlAttribute;
        //locxmlAttributeCollection: XmlAttributeCollection;
        locxmlCData: XmlCData;
        locxmlComment: XmlComment;
        locxmlDecl: XmlDeclaration;
        locxmlDocumentType: XmlDocumentType;
        locxmlElem: XmlElement;
        locxmlElemText: XmlElement;
        locxmlElemAttrib: XmlElement;
        //locxmlNamespaceManager: XmlNamespaceManager;
        locxmlNameTable: XmlNameTable;
        //locxmlNode: XmlNode;
        //locxmlNodeList: XmlNodeList;
        locxmlProcessingInstruction: XmlProcessingInstruction;
        //locxmlReadOptions: XmlReadOptions;
        locxmlText: XmlText;
        //locxmlWriteOptions: XmlWriteOptions;
    begin
        clear(parvarxmlDoc);

        // Declaration
        locxmlDecl := XmlDeclaration.Create('1.0', 'utf-8', '');
        if not parvarxmlDoc.SetDeclaration(locxmlDecl) then
            exit(false);

        // Namespace Declaration
        // TODO
        //locxmlAttribute := XmlAttribute.CreateNamespaceDeclaration('Prefix', 'NamespaceUri');

        // Processing Instruction
        locxmlProcessingInstruction := XmlProcessingInstruction.Create('MyPI', 'Creator="TTTPR"');
        parvarxmlDoc.Add(locxmlProcessingInstruction);

        // Document Type
        locxmlDocumentType := XmlDocumentType.Create('name');
        locxmlDocumentType.SetName('name');
        locxmlDocumentType.SetInternalSubset('int');
        locxmlDocumentType.SetPublicId('publ');
        locxmlDocumentType.SetSystemId('sys');
        if not parvarxmlDoc.Add(locxmlDocumentType) then
            exit(false);

        // Comment
        locxmlComment := XmlComment.Create('This is a comment');
        parvarxmldoc.Add(locxmlComment);

        // Root node
        locxmlRoot := XmlElement.Create('RootNode');
        if not parvarxmlDoc.Add(locxmlRoot) then
            exit(false);

        // Simple node
        locxmlElem := XmlElement.Create('FirstNode', '', 'Value');
        if not locxmlRoot.Add(locxmlElem) then
            exit(false);

        // CData
        locxmlCData := XmlCData.Create('CData section with <xml>content</xml>...æøå ÆØÅ');
        if not locxmlRoot.Add(locxmlCData) then
            exit(false);

        // Text
        locxmlText := XmlText.Create('Text section with lots of text content...><...æøå ÆØÅ');
        locxmlElemText := XmlElement.Create('TextNode', '', locxmlText);
        if not locxmlRoot.Add(locxmlElemText) then
            exit(false);

        // Attribute
        locxmlElemAttrib := XmlElement.Create('AttributeNode', '', 'Value');
        locxmlAttribute := XmlAttribute.Create('MyAttribute', 'AttributeValue');
        locxmlElemAttrib.Add(locxmlAttribute);
        locxmlElemAttrib.Attributes().Set('MyAttribute2', 'AttributeValue');
        if not locxmlRoot.Add(locxmlElemAttrib) then
            exit(false);

        // NameTable
        // How to use??
        locxmlNameTable := parvarxmlDoc.NameTable();

        // Read/Write Options
        //locxmlReadOptions.PreserveWhitespace(false);
        //locxmlWriteOptions.PreserveWhitespace(true);

        exit(true);
    end;
}