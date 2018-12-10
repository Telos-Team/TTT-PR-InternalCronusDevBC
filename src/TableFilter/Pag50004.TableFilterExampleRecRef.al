page 50004 "TTTPR TableFilterExampleRecRef"
{
    Caption = 'Table Filter Example, RecRef';
    InstructionalText = 'Here I want to try to use a TableFilter field using RecRef - if possible!';
    PageType = List;
    SourceTable = "TTTPR TableFilterExample1";
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = "TTTPR ObjectID", "TTTPR ObjectName";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater("TTTPR Group")
            {
                field("TTTPR LineNo"; "TTTPR LineNo")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("TTTPR ObjectID"; "TTTPR ObjectID")
                {
                    ApplicationArea = All;
                    LookupPageId = "All Objects with Caption";
                    trigger OnValidate();
                    begin
                        CalcFields("TTTPR ObjectName");
                    end;
                }
                field("TTTPR ObjectName"; "TTTPR ObjectName")
                {
                    ApplicationArea = All;
                }
                field("TTTPR FilterString"; "TTTPR FilterString")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit();
                    var
                        locrecTableFilter: Record "Table Filter";
                        locpagTableFilter: Page "Table Filter";
                    begin
                        TestField("TTTPR ObjectID");
                        CalcFields("TTTPR ObjectName");
                        locrecTableFilter.FilterGroup(2);
                        locrecTableFilter.SetRange("Table Number", "TTTPR ObjectID");
                        locrecTableFilter.FilterGroup(0);
                        locpagTableFilter.SetTableView(locrecTableFilter);
                        locpagTableFilter.SetSourceTable(Format("TTTPR FilterString"), "TTTPR ObjectID", "TTTPR ObjectName");
                        if locpagTableFilter.RunModal() = Action::OK then
                            Evaluate("TTTPR FilterString", locpagTableFilter.CreateTextTableFilter(false));
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