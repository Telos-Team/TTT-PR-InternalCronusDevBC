page 50007 "TTTPR Nav2BcTemplates"
{
    Description = 'TTTPR Nav2Bc Templates';
    Caption = 'Nav2Bc Templates';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TTTPR Nav2BcTemplate";

    layout
    {
        area(Content)
        {
            repeater("TTTPR Group")
            {
                field("TTTPR Code"; "TTTPR Code")
                {
                    ApplicationArea = All;
                }
                field("TTTPR Description"; "TTTPR Description")
                {
                    ApplicationArea = All;
                }
                field("TTTPR DataLines"; "TTTPR DataLines")
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
            action("TTTPR ImportData")
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
            action("TTTPR SplitData")
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
            action("TTTPR InsertData")
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
            action("TTTPR ShowData")
            {
                Caption = 'Show Data';
                ApplicationArea = All;
                Promoted = True;
                PromotedIsBig = True;
                PromotedOnly = True;
                PromotedCategory = Process;
                Image = ShowList;
                RunObject = page "TTTPR Nav2BcData";
                RunPageLink = "TTTPR TemplateCode" = FIELD ("TTTPR Code");
            }
            action("TTTPR ShowRecords")
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