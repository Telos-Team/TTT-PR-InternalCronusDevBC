page 50015 "TTT-PR MediaCockpit"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MediaRepos)
            {
                Caption = 'Media Repositories';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;

                trigger OnAction()
                begin
                    Page.Run(Page::"TTT-PR MediaRepos");
                end;
            }
            action(MediaResources)
            {
                Caption = 'Media Resources';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;

                trigger OnAction()
                begin
                    Page.Run(Page::"TTT-PR MediaResources");
                end;
            }
            action(TenantMedia)
            {
                Caption = 'Tenant Media';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;

                trigger OnAction()
                begin
                    Page.Run(Page::"TTT-PR TenantMedia");
                end;
            }
            action(TenantMediaSet)
            {
                Caption = 'Tenant Media Set';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;

                trigger OnAction()
                begin
                    Page.Run(Page::"TTT-PR TenantMediaSet");
                end;
            }
            action(MediaTenantMediaThumbnails)
            {
                Caption = 'Tenant Media Thumbnails';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;

                trigger OnAction()
                begin
                    Page.Run(Page::"TTT-PR TenantMediaThumbnails");
                end;
            }
            action(ItemListPictures)
            {
                Caption = 'Item List w/Pictures';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Action;

                trigger OnAction()
                begin
                    Page.Run(Page::"TTT-PR ItemListPictures");
                end;
            }
        }
    }
}
