page 50008 "TTT-PR Nav2BcData"
{
    Description = 'TTTPR Nav2Bc Data';
    Caption = 'Nav2Bc Data';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TTT-PR Nav2BcData";

    layout
    {
        area(Content)
        {
            repeater("TTT-PR Group")
            {
                field("TTT-PR Template Code"; "TTT-PR TemplateCode")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR Company"; "TTT-PR Company")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR TableNo"; "TTT-PR TableNo")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR RecordNo"; "TTT-PR RecordNo")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR FieldNo"; "TTT-PR FieldNo")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR FieldType"; "TTT-PR FieldType")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR FieldLength"; "TTT-PR FieldLength")
                {
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue"; "TTT-PR FieldValue")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}