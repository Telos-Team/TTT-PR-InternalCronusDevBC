codeunit 50013 "TTT-PR MenuSuiteMgt"
{
    Description = 'Menu Suite Management';

    trigger OnRun()
    begin
    end;

    procedure StartImportObjectTextFile()
    var
        loctmprecTempBlob: Record TempBlob temporary;
        loctmprecMenuSuite: Record "TTT-PR MenuSuite" temporary;
        loctmprecMenuNodes: Record "TTT-PR MenuNode" temporary;
        loctmprecMenuNodeTranslations: Record "TTT-PR MenuNodeTranslation" temporary;
    begin
        ImportFile2Blob(loctmprecTempBlob);
        DecodeObjectBlob(loctmprecTempBlob, loctmprecMenuSuite, loctmprecMenuNodes, loctmprecMenuNodeTranslations);
    end;

    local procedure ImportFile2Blob(parvarrecTempBlob: Record TempBlob temporary)
    var
        locstrmIn: InStream;
    begin
        parvarrecTempBlob.Blob.CreateInStream(locstrmIn);
        ImportFile2Stream(locstrmIn);
    end;

    local procedure ImportFile2Stream(parvarstrmIn: instream)
    var
        loctxtClientFilename: Text;
        lblReadTextLbl: label 'Select a file to upload';
    begin
        UploadIntoStream(lblReadTextLbl, '', '', loctxtClientFilename, parvarstrmIn);
    end;

    local procedure DecodeObjectBlob(parvartmprecBlob: Record TempBlob temporary; parvartmprecMenuSuites: Record "TTT-PR MenuSuite" temporary; parvartmprecMenuNodes: Record "TTT-PR MenuNode" temporary; parvartmprecMenuNodeTranslations: Record "TTT-PR MenuNodeTranslation" temporary)
    var
        locstrmIn: InStream;
        loctxtIn: Text;
        loctxtTemp: Text;
        loctxtId: Text;
        loctxtName: Text;
        locintPos: Integer;
        locintBrackets: Integer;
        loclblObjectHeadlineSearchLbl: Label 'OBJECT MenuSuite', Locked = true;
    begin
        parvartmprecBlob.CalcFields(Blob);
        if not parvartmprecBlob.Blob.HasValue() then
            exit;
        parvartmprecBlob.Blob.CreateInStream(locstrmIn);
        while not locstrmIn.EOS() do begin
            locstrmIn.ReadText(loctxtIn);
            IncreaseBrackets(loctxtIn, locintBrackets);
            case true of
                StrPos(loctxtIn, loclblObjectHeadlineSearchLbl) = 1:
                    begin
                        loctxtTemp := CopyStr(loctxtTemp, StrLen(loclblObjectHeadlineSearchLbl) + 1);
                        locintPos := StrPos(loctxtTemp, ' ');
                        loctxtId := CopyStr(loctxtTemp, 1, locintPos - 1);
                        loctxtName := CopyStr(loctxtTemp, locintPos + 1);

                        parvartmprecMenuSuites."TTT-PR Code" := CopyStr(loctxtName, 1, MaxStrLen(parvartmprecMenuSuites."TTT-PR Code"));
                        parvartmprecMenuSuites."TTT-PR Name" := CopyStr(loctxtName, 1, MaxStrLen(parvartmprecMenuSuites."TTT-PR Name"));
                        parvartmprecMenuSuites."TTT-PR Description" := CopyStr(loctxtName, 1, MaxStrLen(parvartmprecMenuSuites."TTT-PR Description"));
                        Evaluate(parvartmprecMenuSuites."TTT-PR Id", loctxtId);

                    end;
            end;
        end;
    end;

    local procedure IncreaseBrackets(partxtIn: Text; parvarintBrackets: Integer)
    begin
        partxtIn := DelChr(partxtIn);
        if CopyStr(partxtIn, 1, 1) = '{' then begin
            parvarintBrackets += 1;
            exit;
        end;
        //if CopyStr()
    end;
}