page 50000 "TTT-PR FPB_CustList"
{
    Caption = 'Filter Page Builder Customer List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No"; "No.")
                {
                    ApplicationArea = All;
                }
                field("Name"; "Name")
                {
                    ApplicationArea = All;
                }
                field("PostCode"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field("CountryRegionCode"; "Country/Region Code")
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
            action(ShowFilterPageBuilder)
            {
                Caption = 'Filter Page Builder';
                ToolTip = 'Shows the filter page using the current view and specific fields and filters (No. = ..30000). Try to set other filters before calling the filter page.';
                ApplicationArea = All;
                Image = EditFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                var
                    loccuFPBHelper: Codeunit "TTT-PR FilterPageBuilderHelper";
                begin
                    loccuFPBHelper.SetTableNo(RecordId().TableNo());
                    loccuFPBHelper.SetView(GetView(false));
                    loccuFPBHelper.SetField(FieldNo("No."), '..30000');
                    loccuFPBHelper.SetField(FieldNo("Name"));
                    SetView(loccuFPBHelper.GetViewFromFilterPage());
                end;
            }
            action(ShowFilterPageBuilderPK)
            {
                Caption = 'Filter Page Builder (PK)';
                ToolTip = 'Shows the filter page using only fields in the primary key.';
                ApplicationArea = All;
                Image = EditFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    loccuFPBHelper: Codeunit "TTT-PR FilterPageBuilderHelper";
                begin
                    SetView(loccuFPBHelper.GetViewFromFilterPage(RecordId().TableNo()));
                end;
            }
        }
    }
}