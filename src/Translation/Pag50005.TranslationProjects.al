page 50005 TTTPRTranslationProjects
{
    Caption = 'TTTPR Translation Projects';
    PageType = List;
    SourceTable = "TTTPR TranslationProject";
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = "TTTPR Code", "TTTPR Description";

    layout
    {
        area(content)
        {
            repeater("TTTPR Group")
            {
                field("TTTPR Code"; "TTTPR Code")
                {
                    ApplicationArea = All;
                }
                field("TTTPR Description"; "TTTPR Description")
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
}