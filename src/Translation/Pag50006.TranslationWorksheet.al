page 50006 TTTPRTranslationWorksheet
{
    Caption = 'TTTPR Translation Worksheet';
    PageType = List;
    SourceTable = "TTTPR TranslationLine";
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = "TTTPR TranslationCode", "TTTPR SourceContent";
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(content)
        {
            group("TTTPR General")
            {
                field("TTTPR TargetLanguageFilter"; "TTTPR TargetLanguageFilter")
                {
                    ApplicationArea = All;
                }
            }
            repeater("TTTPR Group")
            {
                field("TTTPR TranslationCode"; "TTTPR TranslationCode")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TTTPR SourceContentString"; txtSourceContentString)
                {
                    ApplicationArea = All;
                }
                field("TTTPR TargetContentString"; txtTargetContentString)
                {
                    ApplicationArea = All;
                }
                field("TTTPR TargetTranslationFound"; "TTTPR TargetTranslationFound")
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
            action("TTTPR ActionName")
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