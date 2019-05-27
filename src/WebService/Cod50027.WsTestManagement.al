codeunit 50027 "TTT-PR WsTestManagement"
{
    var
        cuXml: Codeunit "TTT-PR WsTestXmlWrapper";
        txtNsUriTxt: Text;
        lblBcSoapNsUriTxt: Label 'http://schemas.xmlsoap.org/soap/envelope/';
        lblPalSoapNsUriTxt: Label 'http://www.w3.org/2003/05/soap-envelope';
        lblBcNsUriTxt: Label 'urn:microsoft-dynamics-schemas/codeunit/%1';
        lblPalNsUriTxt: Label 'http://palette.se/';

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
        cuXml.AddNamespaceDeclaration('BC', txtNsUriTxt);
    end;

    procedure AddRoot4Pal()
    begin
        cuXml.AddRootElement('Envelope', 'soap12', lblPalSoapNsUriTxt);
        cuXml.AddNamespaceDeclaration('xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        cuXml.AddNamespaceDeclaration('xsd', 'http://www.w3.org/2001/XMLSchema');
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

    procedure GetOuterXml(): Text
    begin
        exit(cuXml.GetOuterXml());
    end;
}
