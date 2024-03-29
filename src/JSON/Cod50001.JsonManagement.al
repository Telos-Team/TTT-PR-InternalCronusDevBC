codeunit 50002 "TTT-PR JsonManagement"
{
    Description = 'TTTPR Json Management';
    Subtype = Normal;

    trigger OnRun();
    begin
        TestSimpleJsonObject();
        TestSimpleJsonArray();
    end;

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