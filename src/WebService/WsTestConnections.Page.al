page 50004 "TTT-PR WsTestConnections"
{
    Caption = 'Connections';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TTT-PR WsTestConnection";

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
                field("TTT-PR EndpointCode"; "TTT-PR EndpointCode")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR CredentialCode"; "TTT-PR CredentialCode")
                {
                    ApplicationArea = All;
                    Width = 5;
                }
                field("TTT-PR AuthenticationType"; "TTT-PR AuthenticationType")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR OK"; "TTT-PR OK")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}