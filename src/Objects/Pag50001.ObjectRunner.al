page 50001 "TTTPRObjectRunnerList"
{
    Caption = 'Object Runner';
    PageType = List;
    SourceTable = TTTPRObjectRunner;
    SourceTableTemporary = true;
    Editable = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    PromotedActionCategories = 'New, Process, Report, Filters, 5, 6, 7, 8, 9, 10';

    layout
    {
        area(content)
        {
            group("TTTPR General")
            {
                field("TTTPR ObjectTypeSelector"; optObjectTypeSelector)
                {
                    ApplicationArea = All;
                    AssistEdit = true;

                    trigger OnValidate();
                    begin
                        CallFillTable();
                    end;
                }
            }
            repeater("TTTPR Group")
            {
                field("TTTPR ObjectTypeName"; "TTTPR ObjectTypeName")
                {
                    ApplicationArea = All;
                }
                field("TTTPR ObjectID"; "TTTPR ObjectID")
                {
                    ApplicationArea = All;
                }
                field("TTTPR ObjectName"; "TTTPR ObjectName")
                {
                    ApplicationArea = All;
                }
                field("TTTPR ObjectCaption"; "TTTPR ObjectCaption")
                {
                    ApplicationArea = All;
                }
                field("TTTPR ObjectSubType"; "TTTPR ObjectSubType")
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
            action("TTTPR RunObject")
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
            action("TTTPR ShowFieldList")
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
            group("TTTPR FilterActions")
            {
                Caption = 'Filter Objects';
                ToolTip = 'Set filters on objects';
                action("TTTPR SetFilterNormal")
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
                action("TTTPR SetFilterDev")
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
                action("TTTPR SetFilterSysVirt")
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
                action("TTTPR actConstructGetSystemVirtualTableVariantAL")
                {
                    Caption = 'Create GetSystemVirtualTableVariant AL';
                    ToolTip = 'Create AL for GetSystemVirtualTableVariant()';
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    Image = ShowSelected;
                    trigger OnAction();
                    var
                        loccuObjMgt: Codeunit TTTPRObjectManagement;
                    begin
                        loccuObjMgt.ConstructGetSystemVirtualTableVariantAL();
                    end;
                }
            }
        }
    }

    var
        recObjectTypeSelector: Record AllObjWithCaption;
        optObjectTypeSelector: Option " ",TableData,Table,,Report,,Codeunit,XmlPort,MenuSuite,Page,Query,System,FieldNumber;

    trigger OnOpenPage();
    begin
        CallFillTable();
    end;

    local procedure CallFillTable();
    var
    begin
        if optObjectTypeSelector <> optObjectTypeSelector::" " then
            rec.SetRange("TTTPR ObjectType", optObjectTypeSelector - 1)
        else
            rec.setrange("TTTPR ObjectType");
        FillTable(rec);
    end;
}