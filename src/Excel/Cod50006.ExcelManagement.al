codeunit 50006 "TTT-PR ExcelManagement"
{
    Description = 'TTTPR Excel Management';
    Subtype = Normal;

    trigger OnRun();
    begin
        TestorLoadClientExcel();
    end;

    local procedure TestorLoadClientExcel();
    var
        locrecExcelBuffer: Record "Excel Buffer";
        locbooOK: Boolean;
    begin
        locbooOK := LoadClientExcel(locrecExcelBuffer);
        Message('%1, %2', locbooOK, locrecExcelBuffer.Count());
    end;

    local procedure LoadClientExcel(var parvarrecExcelBuffer: Record "Excel Buffer"): Boolean;
    var
        loctxtClientFilename: Text;
        locstrmXml: InStream;
    begin
        if not UploadIntoStream('Select file', '', '', loctxtClientFilename, locstrmXml) then
            exit;
        clear(parvarrecExcelBuffer);
        parvarrecExcelBuffer.DeleteAll(false);
        message('%1', parvarrecExcelBuffer.OpenBookStream(locstrmXml, 'RegisterQueue SP'));
        exit(true);
    end;

}