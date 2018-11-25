codeunit 50008 TTTPRAzureFunctionsSimple
{
    Description = 'TTTPR';
    Subtype = Normal;

    // https://tttpr-functionapp.azurewebsites.net 
    // http://robertmayer.se/2016/04/19/azure-function-app-to-send-emails/


    trigger OnRun();
    begin
        TestSimpleHelloWorld()
    end;

    var
    local procedure TestSimpleHelloWorld();
    var
        loclblUrlLbl: label 'https://tttpr-functionapp.azurewebsites.net/api/HelloWorld';
        lochttpContent: HttpContent;
        lochttpClient: HttpClient;
        lochttpResponse: HttpResponseMessage;
        lochttpHeaders: HttpHeaders;
        locjsonObject: JsonObject;
        locbooPostResult: Boolean;
        locbooReadResult: Boolean;
        loctxtRequest: Text;
        loctxtReturnValue: Text;
    begin
        locjsonObject.Add('hello', 'WORLD!');
        locjsonObject.WriteTo(loctxtRequest);
        lochttpContent.WriteFrom(loctxtRequest);
        lochttpContent.GetHeaders(lochttpHeaders);
        lochttpHeaders.Remove('content-type');
        lochttpHeaders.Add('content-type', 'application/json');
        locbooPostResult := lochttpClient.Post(loclblUrlLbl, lochttpContent, lochttpResponse);
        lochttpContent := lochttpResponse.Content();
        locbooReadResult := lochttpContent.ReadAs(loctxtReturnValue);
        locbooPostResult := not locbooPostResult;
        message('Post: %1\Read: %2\Request: %3\Response: %4', locbooPostResult, locbooReadResult, loctxtRequest, loctxtReturnValue);
    end;
}