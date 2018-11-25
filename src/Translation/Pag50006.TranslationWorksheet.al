page 50006 TTTPRTranslationWorksheet
{
    Caption = 'TTTPR Translation Worksheet';
    PageType = List;
    SourceTable = TTTPRTranslationLine;
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = TranslationCode, SourceContent;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TargetLanguageFilter; TargetLanguageFilter)
                {
                    ApplicationArea = All;
                }
            }
            repeater(Group)
            {
                field(TranslationCode; TranslationCode)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(SourceContentString; txtSourceContentString)
                {
                    ApplicationArea = All;
                }
                field(TargetContentString; txtTargetContentString)
                {
                    ApplicationArea = All;
                }
                field(TargetTranslationFound; TargetTranslationFound)
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
            action(ActionName)
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