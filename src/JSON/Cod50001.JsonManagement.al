codeunit 50002 TTTPRJsonManagement
{
    Description = 'TTTPR';
    Subtype = Normal;

    trigger OnRun();
    begin
        TestSimpleJsonObject();
        TestSimpleJsonArray();
    end;

    var

    local procedure TestSimpleJsonObject();
    var
        locjsonObject: JsonObject;
        loctxtValue: Text;
    begin
        locjsonObject.Add('Hello', 'World');
        locjsonObject.Add('Hi', 'there');
        locjsonObject.WriteTo(loctxtValue);
        message('Value: %1', loctxtValue);
    end;

    local procedure TestSimpleJsonArray();
    var
        locjsonObject: JsonObject;
        locjsonObject2: JsonObject;
        locjsonArray: JsonArray;
        loctxtValue: Text;
    begin
        locjsonObject.Add('Hello', 'World');
        locjsonObject.Add('Hi', 'there');
        locjsonArray.Add(locjsonObject);

        locjsonObject2.Add('Once', 'again');
        locjsonArray.Add(locjsonObject2);

        locjsonArray.WriteTo(loctxtValue);
        message('Value: %1', loctxtValue);
    end;

}