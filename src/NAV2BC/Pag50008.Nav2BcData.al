page 50008 "TTTPR Nav2BcData"
{
    Description = 'TTTPR Nav2Bc Data';
    Caption = 'Nav2Bc Data';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TTTPR Nav2BcData";

    layout
    {
        area(Content)
        {
            repeater("TTTPR Group")
            {
                field("TTTPR Template Code"; "TTTPR TemplateCode")
                {
                    ApplicationArea = All;
                }
                field("TTTPR Company"; "TTTPR Company")
                {
                    ApplicationArea = All;
                }
                field("TTTPR TableNo"; "TTTPR TableNo")
                {
                    ApplicationArea = All;
                }
                field("TTTPR RecordNo"; "TTTPR RecordNo")
                {
                    ApplicationArea = All;
                }
                field("TTTPR FieldNo"; "TTTPR FieldNo")
                {
                    ApplicationArea = All;
                }
                field("TTTPR FieldType"; "TTTPR FieldType")
                {
                    ApplicationArea = All;
                }
                field("TTTPR FieldLength"; "TTTPR FieldLength")
                {
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue"; "TTTPR FieldValue")
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