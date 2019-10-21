page 50006 "TTT-PR WsTestCredentials"
{
    Caption = 'Credentials';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TTT-PR WsTestCredential";

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
                field("TTT-PR Username"; "TTT-PR Username")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Password"; "TTT-PR Password")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR DomainName"; "TTT-PR DomainName")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}