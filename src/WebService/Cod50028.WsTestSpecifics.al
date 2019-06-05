codeunit 50028 "TTT-PR WsTestSpecifics"
{
    Description = 'The procedures here are created to match the services in WsTestServices';

    procedure CallWsSimpleText(partxtUrl: Text; partxtUsername: Text; partxtAccessKey: Text)
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Bc('WsTest', 'SimpleText');
        loccuMgt.AddParameter4Bc('partxtInput', 'Hello World!');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.SetAuthorizationInfo(partxtUsername, partxtAccessKey);
        loccuHttp.CallWs(partxtUrl, 'SimpleText', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure CallWsSimpleTextVar(partxtUrl: Text; partxtUsername: Text; partxtAccessKey: Text)
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Bc('WsTest', 'SimpleTextVar');
        loccuMgt.AddParameter4Bc('parvartxtInput', 'Hello World!');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.SetAuthorizationInfo(partxtUsername, partxtAccessKey);
        loccuHttp.CallWs(partxtUrl, 'SimpleText', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;

    procedure CallWsSimpleTextVars(partxtUrl: Text; partxtUsername: Text; partxtAccessKey: Text)
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        locbtOutput: BigText;
        locdictResult: Dictionary of [Text, Text];
        loctxtInMessage: Text;
        locintLoop: Integer;
        loclstKeys: List of [Text];
        loclstValues: List of [Text];
    begin
        loccuMgt.Initalize4Bc('WsTest', 'SimpleTextVars');
        loccuMgt.AddParameter4Bc('partxtInput', 'Hello World!');
        loccuMgt.AddParameter4Bc('parvartxtOutput1', 'A');
        loccuMgt.AddParameter4Bc('parvartxtOutput2', 'B');
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.SetAuthorizationInfo(partxtUsername, partxtAccessKey);
        loccuHttp.CallWs(partxtUrl, 'SimpleTextVars', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
        if not loccuMgt.Decode4Bc(loctxtInMessage, 'SimpleTextVars', locdictResult) then
            exit;
        if locdictResult.Count() > 0 then begin
            loclstKeys := locdictResult.Keys();
            loclstValues := locdictResult.Values();
            for locintLoop := 1 to locdictResult.Count() do
                locbtOutput.AddText(StrSubstNo('%1%2\', loclstKeys.Get(locintLoop), loclstValues.Get(locintLoop)));
            Message(Format(locbtOutput));
        end;
    end;

    procedure CallWsDateTimeDiff(partxtUrl: Text; partxtUsername: Text; partxtAccessKey: Text)
    var
        loccuMgt: Codeunit "TTT-PR WsTestManagement";
        loccuHttp: Codeunit "TTT-PR WsTestHttpWrapper";
        loctxtInMessage: Text;
    begin
        loccuMgt.Initalize4Bc('WsTest', 'DateTimeDiff');
        loccuMgt.AddParameter4Bc('pardtInput', Format(CurrentDateTime(), 0, '<Standard Format,9>'));
        loccuMgt.AddParameter4Bc('parvardtOutput', Format(0DT, 0, '<Standard Format,9>'));
        Message('Request:\%1', loccuMgt.GetOuterXml());
        loccuHttp.SetRequestContent(loccuMgt.GetOuterXml());

        loccuHttp.SetAuthorizationInfo(partxtUsername, partxtAccessKey);
        loccuHttp.CallWs(partxtUrl, 'SimpleText', true);
        loccuHttp.GetResponseContentString(loctxtInMessage);
        Message('Response:\%1', loctxtInMessage);
    end;
}
