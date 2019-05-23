page 50019 "TTT-PR MediaResources"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Media Resources";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(MediaReference; "Media Reference")
                {
                    ApplicationArea = All;
                }
                field(MediaSetReference; "MediaSet Reference")
                {
                    ApplicationArea = All;
                }
                field(BlobHasValue; Blob.HasValue())
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}