codeunit 50029 "TTT-PR PalWsTest"
{
    procedure ShowVersion()
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Pal('GetVersion');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure AuthenticateUser()
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Pal('AuthenticateUser');
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure ListEnvironments()
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Pal('ListEnvironments');
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure ListCompanies()
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Pal('ListCompanies');
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure InsertRecord()
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loccuXmlRecord: Codeunit "TTT-PR WsTestXmlWrapper";
        loctxtInMessage: Text;
    begin
        loccuXmlRecord.CreateDoc();
        loccuXmlRecord.AddRootElement('Account', 'pal', 'http://palette.se/');
        loccuXmlRecord.AddNode('Company', 'DAT');
        loccuXmlRecord.AddNode('Account', '4711');
        loccuXmlRecord.AddNode('Name', Format(CurrentDateTime()));
        loccuXmlRecord.AddNode('KeyType', '1');

        loccuMgt.Initalize4Pal('InsertAccount');
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        loccuMgt.AddRecord(loccuXmlRecord);
        loccuMgt.AddTag('TransferFromQueue', 'true', 'http://palette.se/');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;
}