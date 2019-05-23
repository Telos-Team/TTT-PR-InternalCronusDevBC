page 50020 "TTT-PR TenantMedia"
{
    Caption = 'Tenant Media';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Tenant Media";

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
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(CompanyName; "Company Name")
                {
                    ApplicationArea = All;
                }
                field(ContentHasValue; Content.HasValue())
                {
                    Caption = 'Content HasValue';
                    ApplicationArea = All;
                }
                field(CreatingUser; "Creating User")
                {
                    ApplicationArea = All;
                }
                field(ExpirationDate; "Expiration Date")
                {
                    ApplicationArea = All;
                }
                field(FileName; "File Name")
                {
                    ApplicationArea = All;
                }
                field(Width; Width)
                {
                    ApplicationArea = All;
                }
                field(Height; Height)
                {
                    ApplicationArea = All;
                }
                field(Mimetype; "Mime Type")
                {
                    ApplicationArea = All;
                }
                field(ProhibitCache; "Prohibit Cache")
                {
                    ApplicationArea = All;
                }
                field(SecurityToken; "Security Token")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}