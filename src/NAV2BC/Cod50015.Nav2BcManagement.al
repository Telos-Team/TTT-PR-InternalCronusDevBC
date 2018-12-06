codeunit 50015 "TTTPR Nav2BcManagement"
{
    Description = 'TTTPR Nav2Bc Management';
    Subtype = Normal;

    trigger OnRun()
    begin
    end;

    var
        myInt: Integer;

    procedure ImportData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locxmlImport: XmlPort "TTTPR Nav2BcImportData";
        loctxtClientFilename: Text;
        locstrmIn: InStream;
        locbooOK: Boolean;
    begin
        loctxtClientFilename := 'C:\Data\Temp\Nav2Bc.txt';
        locbooOK := UploadIntoStream('Select a file to upload', '', '', loctxtClientFilename, locstrmIn);
        if GuiAllowed() then
            message('UploadIntoStream: %1: %2', locbooOK, loctxtClientFilename);

        locxmlImport.SetTemplateCode(parrecTempl."TTTPR Code");
        locxmlImport.TextEncoding(TextEncoding::MSDos);
        locxmlImport.SetSource(locstrmIn);
        locxmlImport.Import();
        //locxmlImport.Run();

    end;

    procedure SplitData(parrecTempl: Record "TTTPR Nav2BcTemplate")
    var
        locrecTempl: Record "TTTPR Nav2BcTemplate";
        locrecData: Record "TTTPR Nav2BcData";
        locrecData2: Record "TTTPR Nav2BcData";
    begin
        locrecData.SetRange("TTTPR TemplateCode", parrecTempl."TTTPR Code");
        locrecData.FindSet();
        repeat
            if not locrecTempl.Get(StrSubstNo('%1%2', locrecData."TTTPR TemplateCode", locrecData."TTTPR TableNo")) then begin
                locrecTempl.Init();
                locrecTempl.Validate("TTTPR Code", StrSubstNo('%1%2', locrecData."TTTPR TemplateCode", locrecData."TTTPR TableNo"));
                locrecTempl.Insert(true);
            end;
            locrecData2 := locrecData;
            locrecData2."TTTPR TemplateCode" := locrectempl."TTTPR Code";
            locrecData2.Insert();
        until locrecData.Next() = 0;
    end;
}