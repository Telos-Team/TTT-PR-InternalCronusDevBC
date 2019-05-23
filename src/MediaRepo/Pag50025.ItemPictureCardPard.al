page 50025 "TTT-PR ItemPictureCardPart"
{
    Caption = 'Item Picture';
    PageType = CardPart;
    SourceTable = Item;
    LinksAllowed = false;

    layout
    {
        area(Content)
        {
            field(Picture; Picture)
            {
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }
}
