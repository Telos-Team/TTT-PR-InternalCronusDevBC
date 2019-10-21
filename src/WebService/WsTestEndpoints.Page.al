page 50005 "TTT-PR WsTestEndpoints"
{
    Caption = 'Endpoints';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TTT-PR WsTestEndpoint";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("TTT-PR Code"; "TTT-PR Code")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Description"; "TTT-PR Description")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Url"; "TTT-PR Url")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Environment"; "TTT-PR Environment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}