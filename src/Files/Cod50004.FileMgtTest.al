codeunit 50004 TTTPRFileMgtTest
{
    Description = 'TTTPR';
    Subtype = Normal;

    trigger OnRun();
    begin
        // TestorUploadIntoStream();
        TestorImportBlob();
    end;

    var

    local procedure TestorUploadIntoStream();
    var
        //loccuFileMgt: Codeunit "File Management";
        //loctxtFilename: Text;
        loctxtClientFilename: Text;
        //loctxtClientFoldername: Text;
        locstrmIn: InStream;
        locbooOK: Boolean;
    begin
        loctxtClientFilename := 'C:\Data\Temp\kk2.txt';
        locbooOK := UploadIntoStream('Select a file to upload', '', '', loctxtClientFilename, locstrmIn);
        message('UploadIntoStream: %1: %2', locbooOK, loctxtClientFilename);
    end;

    local procedure TestorImportBlob();
    var
        locrecTempBlob: Record TempBlob;
        locstrmIn: InStream;
        locstrmOut: OutStream;
        //loctxtClientFilename: Text;
        loctxtContent: Text;
    begin
        locrecTempBlob.Blob.Import('c:\Data\kk.txt');
        locrecTempBlob.Blob.CreateInStream(locstrmIn);
        locstrmIn.ReadText(loctxtContent, 10);
        message('%1', loctxtContent);
        CopyStream(locstrmOut, locstrmIn);
        locrecTempBlob.CalcFields(blob);
        message('HasValue: %1', locrecTempBlob.Blob.HasValue());
    end;

    local procedure TestorImportBlobStream();
    var
        locrecTempBlob: Record TempBlob;
        locstrmIn: InStream;
        locstrmOut: OutStream;
        loctxtClientFilename: Text;
        loctxtContent: Text;
    begin
        locrecTempBlob.Blob.CreateOutStream(locstrmOut);
        UploadIntoStream('Select a file to upload', '', '', loctxtClientFilename, locstrmIn);
        locstrmIn.ReadText(loctxtContent, 10);
        message('%1', loctxtContent);
        CopyStream(locstrmOut, locstrmIn);
        locrecTempBlob.CalcFields(blob);
        message('HasValue: %1', locrecTempBlob.Blob.HasValue());
    end;
}