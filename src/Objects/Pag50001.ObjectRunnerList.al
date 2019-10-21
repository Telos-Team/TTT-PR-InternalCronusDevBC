page 50001 "TTT-PR ObjectRunnerList"
{
    Caption = 'TTTPR Object Runner';
    PageType = List;
    SourceTable = "TTT-PR ObjectRunner";
    SourceTableTemporary = true;
    Editable = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    PromotedActionCategories = 'New, Process, Report, Filters, 5, 6, 7, 8, 9, 10';

    layout
    {
        area(content)
        {
            group("TTT-PR General")
            {
                field("TTT-PR ObjectTypeSelector"; optObjectTypeSelector)
                {
                    ApplicationArea = All;
                    AssistEdit = true;

                    trigger OnValidate();
                    begin
                        CallFillTable();
                    end;
                }
            }
            repeater("TTT-PR Group")
            {
                field("TTT-PR ObjectTypeName"; "TTT-PR ObjectTypeName")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR ObjectID"; "TTT-PR ObjectID")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR ObjectName"; "TTT-PR ObjectName")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR ObjectCaption"; "TTT-PR ObjectCaption")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR ObjectSubType"; "TTT-PR ObjectSubType")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action("TTT-PR RunObject")
            {
                Caption = 'Run Object';
                ToolTip = 'Run the selected object';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = SuggestNumber;
                PromotedIsBig = true;
                trigger OnAction();
                begin
                    RunObject();
                end;
            }
            action("TTT-PR ShowFieldList")
            {
                Caption = 'Show Field List';
                ToolTip = 'Show the Field List for selected table';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SuggestNumber;
                trigger OnAction();
                begin
                    ShowFieldList();
                end;
            }
            group("TTT-PR FilterActions")
            {
                Caption = 'Filter Objects';
                ToolTip = 'Set filters on objects';
                action("TTT-PR SetFilterNormal")
                {
                    Caption = 'Normal Objects';
                    ToolTip = 'Show only normal objects';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = SuggestNumber;
                    trigger OnAction();
                    begin
                        SetFilterNormal();
                    end;
                }
                action("TTT-PR SetFilterDev")
                {
                    Caption = 'Dev Objects';
                    ToolTip = 'Show only dev objects';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = SuggestNumber;
                    trigger OnAction();
                    begin
                        SetFilterDev();
                    end;
                }
                action("TTT-PR SetFilterSysVirt")
                {
                    Caption = 'System/Virtual Objects';
                    ToolTip = 'Show only system/virtual objects';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Image = SuggestNumber;
                    trigger OnAction();
                    begin
                        SetFilterSysVirt();
                    end;
                }
                action("TTT-PR actConstructGetSystemVirtualTableVariantAL")
                {
                    Caption = 'Create GetSystemVirtualTableVariant AL';
                    ToolTip = 'Create AL for GetSystemVirtualTableVariant()';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Image = ShowSelected;
                    ApplicationArea = All;
                    trigger OnAction();
                    var
                        loccuObjMgt: Codeunit "TTT-PR ObjectManagement";
                    begin
                        loccuObjMgt.ConstructGetSystemVirtualTableVariantAL();
                    end;
                }

                action("TTT-PR actConstructRepeaterFieldListAL")
                {
                    Caption = 'Create Repeater Field list AL';
                    ToolTip = 'Create AL for Repeater Field list';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Image = ShowSelected;
                    ApplicationArea = All;
                    trigger OnAction();
                    var
                        loccuObjMgt: Codeunit "TTT-PR ObjectManagement";
                    begin
                        loccuObjMgt.ConstructRepeaterFieldListAL(rec."TTT-PR ObjectID");
                    end;
                }
            }
        }
    }

    var
        optObjectTypeSelector: Option " ",TableData,Table,,Report,,Codeunit,XmlPort,MenuSuite,Page,Query,System,FieldNumber;

    trigger OnOpenPage();
    begin
        CallFillTable();
    end;

    local procedure CallFillTable();
    var
    begin
        if optObjectTypeSelector <> optObjectTypeSelector::" " then
            rec.SetRange("TTT-PR ObjectType", optObjectTypeSelector - 1)
        else
            rec.setrange("TTT-PR ObjectType");
        FillTable(rec);
    end;
}