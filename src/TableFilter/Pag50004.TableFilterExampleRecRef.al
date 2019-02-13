page 50004 "TTT-PR TableFilterExRecRef"
{
    Caption = 'Table Filter Example, RecRef';
    InstructionalText = 'Here I want to try to use a TableFilter field using RecRef - if possible!';
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
                    trigger OnValidate();
                    begin
                        CalcFields("TTT-PR ObjectName");
                    end;
                }
                field("TTT-PR ObjectName"; "TTT-PR ObjectName")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR FilterString"; "TTT-PR FilterString")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit();
                    var
                        locrecTableFilter: Record "Table Filter";
                        locpagTableFilter: Page "Table Filter";
                    begin
                        TestField("TTT-PR ObjectID");
                        CalcFields("TTT-PR ObjectName");
                        locrecTableFilter.FilterGroup(2);
                        locrecTableFilter.SetRange("Table Number", "TTT-PR ObjectID");
                        locrecTableFilter.FilterGroup(0);
                        locpagTableFilter.SetTableView(locrecTableFilter);
                        locpagTableFilter.SetSourceTable(Format("TTT-PR FilterString"), "TTT-PR ObjectID", "TTT-PR ObjectName");
                        if locpagTableFilter.RunModal() = Action::OK then
                            Evaluate("TTT-PR FilterString", locpagTableFilter.CreateTextTableFilter(false));
                    end;
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