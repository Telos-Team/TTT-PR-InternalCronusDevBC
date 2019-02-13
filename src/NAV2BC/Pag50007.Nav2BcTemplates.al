page 50007 "TTT-PR Nav2BcTemplates"
{
    Description = 'TTTPR Nav2Bc Templates';
    Caption = 'Nav2Bc Templates';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TTT-PR Nav2BcTemplate";

    layout
    {
        area(Content)
        {
            repeater("TTT-PR Group")
            {
                field("TTT-PR Code"; "TTT-PR Code")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Description"; "TTT-PR Description")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR DataLines"; "TTT-PR DataLines")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("TTT-PR ImportData")
            {
                Caption = 'Import Data';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Import;

                trigger OnAction();
                begin
                    ImportData();
                end;
            }
            action("TTT-PR SplitData")
            {
                Caption = 'Split Data';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Split;

                trigger OnAction();
                begin
                    SplitData();
                end;
            }
            action("TTT-PR InsertData")
            {
                Caption = 'Insert Data';
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Image = Save;

                trigger OnAction();
                begin
                    InsertData();
                end;
            }
        }
        area(Navigation)
        {
            action("TTT-PR ShowData")
            {
                Caption = 'Show Data';
                ApplicationArea = All;
                Promoted = True;
                PromotedIsBig = True;
                PromotedOnly = True;
                PromotedCategory = Process;
                Image = ShowList;
                RunObject = page "TTT-PR Nav2BcData";
                RunPageLink = "TTT-PR TemplateCode" = FIELD ("TTT-PR Code");
            }
            action("TTT-PR ShowRecords")
            {
                Caption = 'Show Records';
                ApplicationArea = All;
                Promoted = True;
                PromotedIsBig = True;
                PromotedOnly = True;
                PromotedCategory = Process;
                Image = ShowList;

                trigger OnAction()
                begin
                    ShowRecords();
                end;
            }
        }
    }
}