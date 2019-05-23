page 50021 "TTT-PR TenantMediaSet"
{
    Caption = 'Tenant Media Set';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Tenant Media Set";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(ID; ID)
                {
                    ApplicationArea = All;
                }
                field(CompanyName; "Company Name")
                {
                    ApplicationArea = All;
                }
                field(MediaID; "Media ID")
                {
                    ApplicationArea = All;
                }
                field(MediaIndex; "Media Index")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}