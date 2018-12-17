page 50009 "TTTPR Nav2BcRecords"
{
    Description = 'TTTPR Nav2Bc Records';
    Caption = 'Nav2Bc Records';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TTTPR Nav2BcRecord";

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
                field("TTTPR FieldValue1"; GetFieldValue(1))
                {
                    CaptionClass = GetFieldHeader(1);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue2"; GetFieldValue(2))
                {
                    CaptionClass = GetFieldHeader(2);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue3"; GetFieldValue(3))
                {
                    CaptionClass = GetFieldHeader(3);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue4"; GetFieldValue(4))
                {
                    CaptionClass = GetFieldHeader(4);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue5"; GetFieldValue(5))
                {
                    CaptionClass = GetFieldHeader(5);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue6"; GetFieldValue(6))
                {
                    CaptionClass = GetFieldHeader(6);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue7"; GetFieldValue(7))
                {
                    CaptionClass = GetFieldHeader(7);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue8"; GetFieldValue(8))
                {
                    CaptionClass = GetFieldHeader(8);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue9"; GetFieldValue(9))
                {
                    CaptionClass = GetFieldHeader(9);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue10"; GetFieldValue(10))
                {
                    CaptionClass = GetFieldHeader(10);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue11"; GetFieldValue(11))
                {
                    CaptionClass = GetFieldHeader(11);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue12"; GetFieldValue(12))
                {
                    CaptionClass = GetFieldHeader(12);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue13"; GetFieldValue(13))
                {
                    CaptionClass = GetFieldHeader(13);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue14"; GetFieldValue(14))
                {
                    CaptionClass = GetFieldHeader(14);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue15"; GetFieldValue(15))
                {
                    CaptionClass = GetFieldHeader(15);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue16"; GetFieldValue(16))
                {
                    CaptionClass = GetFieldHeader(16);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue17"; GetFieldValue(17))
                {
                    CaptionClass = GetFieldHeader(17);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue18"; GetFieldValue(18))
                {
                    CaptionClass = GetFieldHeader(18);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue19"; GetFieldValue(19))
                {
                    CaptionClass = GetFieldHeader(19);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue20"; GetFieldValue(20))
                {
                    CaptionClass = GetFieldHeader(20);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue21"; GetFieldValue(21))
                {
                    CaptionClass = GetFieldHeader(21);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue22"; GetFieldValue(22))
                {
                    CaptionClass = GetFieldHeader(22);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue23"; GetFieldValue(23))
                {
                    CaptionClass = GetFieldHeader(23);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue24"; GetFieldValue(24))
                {
                    CaptionClass = GetFieldHeader(24);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue25"; GetFieldValue(25))
                {
                    CaptionClass = GetFieldHeader(25);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue26"; GetFieldValue(26))
                {
                    CaptionClass = GetFieldHeader(26);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue27"; GetFieldValue(27))
                {
                    CaptionClass = GetFieldHeader(27);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue28"; GetFieldValue(28))
                {
                    CaptionClass = GetFieldHeader(28);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue29"; GetFieldValue(29))
                {
                    CaptionClass = GetFieldHeader(29);
                    ApplicationArea = All;
                }
                field("TTTPR FieldValue30"; GetFieldValue(30))
                {
                    CaptionClass = GetFieldHeader(30);
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }
}