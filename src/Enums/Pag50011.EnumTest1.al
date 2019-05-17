page 50011 "TTT-PR EnumTest1"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Integer;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Number; Number)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Test)
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction()
                var
                    loccuEnumMgt: Codeunit "TTT-PR EnumManagement";
                begin
                    loccuEnumMgt.Test1();
                end;
            }
        }
    }

}