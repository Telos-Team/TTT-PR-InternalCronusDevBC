page 50016 "TTT-PR MediaRepos"
{
    Caption = 'Media Repositories';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Media Repository";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(FileName; "File Name")
                {
                    ApplicationArea = All;
                }
                field(DisplayTarget; "Display Target")
                {
                    ApplicationArea = All;
                }
                field(MediaResourceRef; "Media Resources Ref")
                {
                    ApplicationArea = All;
                }
                field(ImageHasValue; Image.HasValue())
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}