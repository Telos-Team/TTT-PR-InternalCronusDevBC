page 50023 "TTT-PR ItemListPictures"
{
    Caption = 'Item List w/Pictures';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Item;
    CardPageId = 50024;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(Instructions)
            {
                InstructionalText = 'Picture field is type MediaSet, so the field is just added to the page. OnOpenPage: "SetFilter(Picture, "<>%1", locrecItem.Picture)';
            }
            repeater(GroupName)
            {
                field(No; "No.")
                {
                    ApplicationArea = All;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = All;
                }
                field(PictureCount; Picture.Count())
                {
                    ApplicationArea = All;
                }
                field(PictureMediaId; Picture.MediaId())
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Image = Action;

                trigger OnAction();
                begin
                    MessagE('N/A')
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        locrecItem: Record Item;
    begin
        SetFilter(Picture, '<>%1', locrecItem.Picture);
    end;
}
