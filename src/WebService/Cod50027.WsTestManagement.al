codeunit 50027 "TTT-PR WsTestManagement"
{
    var
        cuXml: Codeunit "TTT-PR WsTestXmlWrapper";
        txtBcNsUriTxt: Text;
        lblSoapNsUriTxt: Label 'http://schemas.xmlsoap.org/soap/envelope/';
        lblBcNsUriTxt: Label 'urn:microsoft-dynamics-schemas/codeunit/%1';

    procedure Initalize4Bc(partxtService: Text)
    begin
        Clear(cuXml);
        txtBcNsUriTxt := StrSubstNo(lblBcNsUriTxt, partxtService);
    end;

    procedure Initalize4Bc(partxtService: Text; partxtMethod: Text)
    begin
        Initalize4Bc(partxtService);
        AddRoot4Bc();
        AddHeader4Bc();
        AddBody4Bc();
        AddMethod4Bc(partxtMethod);
    end;

    procedure AddRoot4Bc()
    begin
        cuXml.CreateDoc('1.0', 'utf-8', true);
        cuXml.AddRootElement('Envelope', 'soap', lblSoapNsUriTxt);
        cuXml.AddNamespaceDeclaration('BC', txtBcNsUriTxt);
    end;

    procedure AddHeader4Bc()
    begin
        cuXml.AddNode('Header', '', lblSoapNsUriTxt);
    end;

    procedure AddBody4Bc()
    begin
        cuXml.AddNodeFollow('Body', '', lblSoapNsUriTxt);
    end;

    procedure AddMethod4Bc(partxtMethod: Text)
    begin
        cuXml.AddNodeFollow(partxtMethod, '', txtBcNsUriTxt);
    end;

    procedure AddParameter4Bc(partxtName: Text; partxtValue: Text)
    begin
        cuXml.AddNode(partxtName, partxtValue, txtBcNsUriTxt);
    end;

    procedure GetOuterXml(): Text
    begin
        exit(cuXml.GetOuterXml());
    end;
}
