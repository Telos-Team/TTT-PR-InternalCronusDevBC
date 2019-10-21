page 50010 "TTT-PR HyperlinkWrapperTest"
{
    Caption = 'Hyperlink Wrapper Test';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "TTT-PR HyperlinkWrapperTest";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("TTT-PR Key"; "TTT-PR Key")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Value3"; '*')
                {
                    Caption = 'Value (Blob)';
                    ApplicationArea = All;
                }
                field("TTT-PR Value"; "TTT-PR Value")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Value2"; "TTT-PR Value")
                {
                    Caption = 'Value (Url)';
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("TTT-PR Type"; "TTT-PR Type")
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
            action("TTT-PR UseHyperlink")
            {
                Caption = 'Use Hyperlink';
                ApplicationArea = All;
                Image = LaunchWeb;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction();
                var
                    loccuHyperlinkWrapper: Codeunit "TTT-PR HyperlinkWrapper";
                begin
                    loccuHyperlinkWrapper.ActivateContentHyperlink("TTT-PR Key", "TTT-PR Type", "TTT-PR Value");
                end;
            }
            action("TTT-PR UseMessage")
            {
                Caption = 'Use Message';
                ApplicationArea = All;
                Image = Text;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    Message('%1', "TTT-PR Value");
                end;
            }
        }
    }
}