codeunit 50029 "TTT-PR PalWsTest"
{
    procedure ShowVersion()
    // <?xml version="1.0" encoding="utf-8" standalone="yes"?>
    // <soap12:Envelope 
    //   xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    //   xmlns:pal="http://palette.se/">
    //   <soap12:Body>
    //     <pal:GetVersion />
    //   </soap12:Body>
    // </soap12:Envelope>

    // <?xml version="1.0" encoding="utf-8"?>
    // <soap:Envelope 
    //   xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    //   <soap:Body>
    //     <GetVersionResponse xmlns="http://palette.se/">
    //       <GetVersionResult>7.1.0.996</GetVersionResult>
    //     </GetVersionResponse>
    //   </soap:Body>
    // </soap:Envelope>
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loclstResult: List of [Text];
        loctxtInMessage: Text;
        loclblMethodTxt: Label 'GetVersion';
    begin
        loccuMgt.Initalize4Pal(loclblMethodTxt);
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);

        loccuMgt.Decode4Pal(loctxtInMessage, loclblMethodTxt, loclstResult);
        Message(loccuMgt.List2Text(loclstResult, '\'));
    end;

    procedure AuthenticateUser()
    // <?xml version="1.0" encoding="utf-8" standalone="yes"?>
    // <soap12:Envelope 
    //   xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    //   xmlns:pal="http://palette.se/">
    //   <soap12:Body>
    //     <pal:AuthenticateUser>
    //       <pal:Environment>TelosTeamTest</pal:Environment>
    //       <pal:UserID>palette@telosteam.dk</pal:UserID>
    //       <pal:Password>NavisionMagician</pal:Password>
    //     </pal:AuthenticateUser>
    //   </soap12:Body>
    // </soap12:Envelope>

    // <?xml version="1.0" encoding="utf-8"?>
    // <soap:Envelope 
    //   xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    //   <soap:Body>
    //     <AuthenticateUserResponse xmlns="http://palette.se/">
    //       <AuthenticateUserResult>true</AuthenticateUserResult>
    //     </AuthenticateUserResponse>
    //   </soap:Body>
    // </soap:Envelope>
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        locdictResult: Dictionary of [Text, Text];
        loctxtInMessage: Text;
        loclblMethodTxt: Label 'AuthenticateUser';
    begin
        loccuMgt.Initalize4Pal(loclblMethodTxt);
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician2');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);

        loccuMgt.Decode4Pal(loctxtInMessage, loclblMethodTxt, locdictResult);
        Message(loccuMgt.Dictionary2Text(locdictResult, '\'));
    end;

    procedure ListEnvironments()
    // <?xml version="1.0" encoding="utf-8" standalone="yes"?>
    // <soap12:Envelope 
    //   xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    //   xmlns:pal="http://palette.se/">
    //   <soap12:Body>
    //     <pal:ListEnvironments>
    //       <pal:Environment>TelosTeamTest</pal:Environment>
    //       <pal:UserID>palette@telosteam.dk</pal:UserID>
    //       <pal:Password>NavisionMagician</pal:Password>
    //     </pal:ListEnvironments>
    //   </soap12:Body>
    // </soap12:Envelope>

    // <?xml version="1.0" encoding="utf-8"?>
    // <soap:Envelope 
    //   xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    //   <soap:Body>
    //     <ListEnvironmentsResponse xmlns="http://palette.se/">
    //       <ListEnvironmentsResult><string>AdaptionTest</string>
    //         <string>Britannia</string><string>BritanniaTest</string>
    //         <string>FOATest</string><string>HFORSTest</string>
    //         <string>ROGMTest</string><string>ShareITTest</string>
    //         <string>TelosTeamTest</string>
    //       </ListEnvironmentsResult>
    //     </ListEnvironmentsResponse>
    //   </soap:Body>
    // </soap:Envelope>
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loclstResult: List of [Text];
        loctxtInMessage: Text;
        loclblMethodTxt: Label 'ListEnvironments';

    begin
        loccuMgt.Initalize4Pal(loclblMethodTxt);
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
        loccuMgt.Decode4Pal(loctxtInMessage, loclblMethodTxt, loclstResult);
        Message(loccuMgt.List2Text(loclstResult, '\'));
    end;

    procedure ListCompanies()
    // <?xml version="1.0" encoding="utf-8" standalone="yes"?>
    // <soap12:Envelope 
    // xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" 
    // xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    // xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    // xmlns:pal="http://palette.se/">
    // <soap12:Body>
    //     <pal:ListCompanies>
    //       <pal:Environment>TelosTeamTest</pal:Environment>
    //       <pal:UserID>palette@telosteam.dk</pal:UserID>
    //       <pal:Password>NavisionMagician</pal:Password>
    //     </pal:ListCompanies>
    //   </soap12:Body>
    // </soap12:Envelope>

    // <?xml version="1.0" encoding="utf-8"?>
    // <soap:Envelope 
    //   xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    //   <soap:Body>
    //     <ListCompaniesResponse xmlns="http://palette.se/">
    //       <ListCompaniesResult>
    //         <string>BFC_DK</string>
    //         <string>Cronus</string><string>DAT</string>
    //         <string>NAV</string><string>Template</string>
    //       </ListCompaniesResult>
    //     </ListCompaniesResponse>
    //   </soap:Body>
    // </soap:Envelope>
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
        loclstResult: List of [Text];
        loclblMethodTxt: Label 'ListCompanies';
    begin
        loccuMgt.Initalize4Pal(loclblMethodTxt);
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
        loccuMgt.Decode4Pal(loctxtInMessage, loclblMethodTxt, loclstResult);
        Message(loccuMgt.List2Text(loclstResult, '\'));
    end;

    procedure InsertRecord()
    // <?xml version="1.0" encoding="utf-8" standalone="yes"?>
    // <soap12:Envelope 
    //   xmlns:soap12="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
    //   xmlns:pal="http://palette.se/">
    //   <soap12:Body>
    //     <pal:InsertAccount>
    //       <pal:Environment>TelosTeamTest</pal:Environment>
    //       <pal:UserID>palette@telosteam.dk</pal:UserID>
    //       <pal:Password>NavisionMagician</pal:Password>
    //       <pal:Account xmlns:pal="http://palette.se/">
    //         <Company>DAT</Company>
    //         <Account>4711</Account>
    //         <Name>29-05-19 23:08</Name>
    //         <KeyType>1</KeyType>
    //       </pal:Account>
    //       <pal:TransferFromQueue>true</pal:TransferFromQueue>
    //     </pal:InsertAccount>
    //   </soap12:Body>
    // </soap12:Envelope>

    // <?xml version="1.0" encoding="utf-8"?>
    // <soap:Envelope
    //   xmlns:soap="http://www.w3.org/2003/05/soap-envelope" 
    //   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    //   xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    //   <soap:Body>
    //     <InsertAccountResponse xmlns="http://palette.se/">
    //       <InsertAccountResult>
    //         <ResultCode>0</ResultCode>
    //         <Message>Account successfully inserted with Account 4711</Message>
    //       </InsertAccountResult>
    //     </InsertAccountResponse>
    //   </soap:Body>
    // </soap:Envelope>
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loccuXmlRecord: Codeunit "TTT-PR WsTestXmlWrapper";
        locdictResult: Dictionary of [Text, Text];
        loctxtInMessage: Text;
        loclblMethodTxt: Label 'InsertAccount';
    begin
        loccuXmlRecord.CreateDoc();
        loccuXmlRecord.AddRootElement('Account', 'pal', 'http://palette.se/');
        loccuXmlRecord.AddNode('Company', 'DAT');
        loccuXmlRecord.AddNode('Account', '4711');
        loccuXmlRecord.AddNode('Name', Format(CurrentDateTime()));
        loccuXmlRecord.AddNode('KeyType', '1');

        loccuMgt.Initalize4Pal(loclblMethodtxt);
        loccuMgt.AddAuthentication4Pal('TelosTeamTest', 'palette@telosteam.dk', 'NavisionMagician');
        loccuMgt.AddRecord(loccuXmlRecord);
        loccuMgt.AddTag('TransferFromQueue', 'true', 'http://palette.se/');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.CallWs('http://webservice.documentcloud.dk/telosteam/palettewebservice.asmx', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);

        loccuMgt.Decode4Pal(loctxtInMessage, loclblMethodTxt, locdictResult);
        Message(loccuMgt.Dictionary2Text(locdictResult, '\'));

    end;
}