page 50006 "TTT-PR TranslationWorksheet"
{
    Caption = 'TTTPR Translation Worksheet';
    PageType = List;
    SourceTable = "TTT-PR TranslationLine";
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = "TTT-PR TranslationCode", "TTT-PR SourceContent";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(content)
        {
            group("TTT-PR General")
            {
                field("TTT-PR TargetLanguageFilter"; "TTT-PR TargetLanguageFilter")
                {
                    ApplicationArea = All;
                }
            }
            repeater("TTT-PR Group")
            {
                field("TTT-PR TranslationCode"; "TTT-PR TranslationCode")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TTT-PR SourceContentString"; txtSourceContentString)
                {
                    ApplicationArea = All;
                }
                field("TTT-PR TargetContentString"; txtTargetContentString)
                {
                    ApplicationArea = All;
                }
                field("TTT-PR TargetTranslationFound"; "TTT-PR TargetTranslationFound")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action("TTT-PR ActionName")
            {
                Image = SuggestNumber;
                trigger OnAction();
                begin
                    Message('');
                end;
            }
        }
    }

    var
        txtTargetLanguage: Text[10];
        txtSourceContentString: Text;
        txtTargetContentString: Text;

    trigger OnOpenPage();
    var
    begin
    end;

    trigger OnAfterGetRecord();
    var
    begin
    end;
}