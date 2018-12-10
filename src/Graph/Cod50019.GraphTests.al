codeunit 50019 "TTTPR GraphTests"
{
    trigger OnRun()
    begin
        ShowMe();
    end;

    var


    local procedure ShowMe()
    var
        lochttpClt: HttpClient;
        lochttpResp: HttpResponseMessage;
        lochttpCont: HttpContent;
        loctxtRead: Text;
    begin
        lochttpClt.Get('https://graph.microsoft.com/v1.0/me/', lochttpResp);
        lochttpCont := lochttpResp.Content();
        lochttpCont.ReadAs(loctxtRead);
        Message(loctxtRead);
    end;
}