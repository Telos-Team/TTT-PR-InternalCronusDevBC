page 50022 "TTT-PR TenantMediaThumbnails"
{
    Caption = 'Tenant Media Thumbnails';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Tenant Media Thumbnails";

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
                field(ContentField; Content.HasValue())
                {
                    Caption = 'Content HasValue';
                    ApplicationArea = All;
                }
                field(Embedded; Embedded)
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
                field(MediaID; "Media ID")
                {
                    ApplicationArea = All;
                }
                field(MimeType; "Mime Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}