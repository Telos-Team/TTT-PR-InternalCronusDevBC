page 50005 TTTPRTranslationProjects
{
    Caption = 'TTTPR Translation Projects';
    PageType = List;
    SourceTable = TTTPRTranslationProject;
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = Code, Description;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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
}