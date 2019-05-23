page 50018 "TTT-PR WsTestCredentials"
{
    Caption = 'WsTest Credentials';
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
                field("TTT-PR Url"; "TTT-PR Url")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Username"; "TTT-PR Username")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR AccessKey"; "TTT-PR AccessKey")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR DomainName"; "TTT-PR DomainName")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Password"; "TTT-PR Password")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
