page 50005 "TTT-PR TranslationProjects"
{
    Caption = 'TTTPR Translation Projects';
    PageType = List;
    SourceTable = "TTT-PR TranslationProject";
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = "TTT-PR Code", "TTT-PR Description";

    layout
    {
        area(content)
        {
            repeater("TTT-PR Group")
            {
                field("TTT-PR Code"; "TTT-PR Code")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Description"; "TTT-PR Description")
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
}