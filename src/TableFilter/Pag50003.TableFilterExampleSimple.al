page 50003 "TTT-PR TableFilterExSimple"
{
    Caption = 'Table Filter Example, Simple';
    InstructionalText = 'Just a simple example - easy to copy from!';
    PageType = List;
    SourceTable = "TTT-PR TableFilterExample1";
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = "TTT-PR ObjectID", "TTT-PR ObjectName";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater("TTT-PR Group")
            {
                field("TTT-PR LineNo"; "TTT-PR LineNo")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TTT-PR ObjectID"; "TTT-PR ObjectID")
                {
                    ApplicationArea = All;
                    LookupPageId = "All Objects with Caption";
                }
                field("TTT-PR ObjectName"; "TTT-PR ObjectName")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR ObjectCaption"; "TTT-PR ObjectCaption")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR FilterString"; "TTT-PR FilterString")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit();
                    begin
                        FilterStringOnAssistEdit();
                    end;
                }
            }
        }
        area(factboxes)
        {
            part(FieldFilterFactBox; "TTT-PR TableFilterFactBox")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("TTT-PR ShowTableFilter")
            {
                Caption = 'Show Table Filter';
                Image = SuggestNumber;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ShowTableFilter("TTT-PR ObjectID", FieldNo("TTT-PR FilterString"));
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.FieldFilterFactBox.Page.SetSourceTable("TTT-PR ObjectID", Format("TTT-PR FilterString"), "TTT-PR ObjectCaption");
    end;
}
