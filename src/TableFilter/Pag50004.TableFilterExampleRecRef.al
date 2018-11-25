page 50004 "TTTPRTableFilterExampleRecRef"
{
    Caption = 'Table Filter Example, RecRef';
    InstructionalText = 'Here I want to try to use a TableFilter field using RecRef - if possible!';
    PageType = List;
    SourceTable = TTTPRTableFilterExample1;
    UsageCategory = Administration;
    ApplicationArea = All;
    DataCaptionFields = ObjectID, ObjectName;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LineNo; LineNo)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(ObjectID; ObjectID)
                {
                    ApplicationArea = All;
                    LookupPageId = "All Objects with Caption";
                    trigger OnValidate();
                    begin
                        CalcFields(ObjectName);
                    end;
                }
                field(ObjectName; ObjectName)
                {
                    ApplicationArea = All;
                }
                field(FilterString; FilterString)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit();
                    var
                        locrecTableFilter: Record "Table Filter";
                        locpagTableFilter: Page "Table Filter";
                    begin
                        TestField(ObjectID);
                        CalcFields(ObjectName);
                        locrecTableFilter.FilterGroup(2);
                        locrecTableFilter.SetRange("Table Number", ObjectID);
                        locrecTableFilter.FilterGroup(0);
                        locpagTableFilter.SetTableView(locrecTableFilter);
                        locpagTableFilter.SetSourceTable(Format(FilterString), ObjectID, ObjectName);
                        if locpagTableFilter.RunModal() = Action::OK then
                            Evaluate(FilterString, locpagTableFilter.CreateTextTableFilter(false));
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