page 50024 "TTT-PR ItemCardPicture"
{
    Caption = 'Item Card w/Picture';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(No; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(UnitPrice; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field(PictureMediaId; Picture.MediaId())
                {
                    Caption = 'Picture Media Id';
                    ApplicationArea = All;
                }
                field(UnitCost; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                group(PicturePart)
                {
                    ShowCaption = false;
                    part(PicPart; "TTT-PR ItemPictureCardPart")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        SubPageLink = "No." = field("No.");
                    }
                }
            }
        }
    }
}
