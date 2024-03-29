page 50009 "TTT-PR Nav2BcRecords"
{
    Description = 'TTTPR Nav2Bc Records';
    Caption = 'Nav2Bc Records';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "TTT-PR Nav2BcRecord";

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
                field("TTT-PR FieldValue1"; GetFieldValue(1))
                {
                    CaptionClass = GetFieldHeader(1);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue2"; GetFieldValue(2))
                {
                    CaptionClass = GetFieldHeader(2);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue3"; GetFieldValue(3))
                {
                    CaptionClass = GetFieldHeader(3);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue4"; GetFieldValue(4))
                {
                    CaptionClass = GetFieldHeader(4);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue5"; GetFieldValue(5))
                {
                    CaptionClass = GetFieldHeader(5);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue6"; GetFieldValue(6))
                {
                    CaptionClass = GetFieldHeader(6);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue7"; GetFieldValue(7))
                {
                    CaptionClass = GetFieldHeader(7);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue8"; GetFieldValue(8))
                {
                    CaptionClass = GetFieldHeader(8);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue9"; GetFieldValue(9))
                {
                    CaptionClass = GetFieldHeader(9);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue10"; GetFieldValue(10))
                {
                    CaptionClass = GetFieldHeader(10);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue11"; GetFieldValue(11))
                {
                    CaptionClass = GetFieldHeader(11);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue12"; GetFieldValue(12))
                {
                    CaptionClass = GetFieldHeader(12);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue13"; GetFieldValue(13))
                {
                    CaptionClass = GetFieldHeader(13);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue14"; GetFieldValue(14))
                {
                    CaptionClass = GetFieldHeader(14);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue15"; GetFieldValue(15))
                {
                    CaptionClass = GetFieldHeader(15);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue16"; GetFieldValue(16))
                {
                    CaptionClass = GetFieldHeader(16);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue17"; GetFieldValue(17))
                {
                    CaptionClass = GetFieldHeader(17);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue18"; GetFieldValue(18))
                {
                    CaptionClass = GetFieldHeader(18);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue19"; GetFieldValue(19))
                {
                    CaptionClass = GetFieldHeader(19);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue20"; GetFieldValue(20))
                {
                    CaptionClass = GetFieldHeader(20);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue21"; GetFieldValue(21))
                {
                    CaptionClass = GetFieldHeader(21);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue22"; GetFieldValue(22))
                {
                    CaptionClass = GetFieldHeader(22);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue23"; GetFieldValue(23))
                {
                    CaptionClass = GetFieldHeader(23);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue24"; GetFieldValue(24))
                {
                    CaptionClass = GetFieldHeader(24);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue25"; GetFieldValue(25))
                {
                    CaptionClass = GetFieldHeader(25);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue26"; GetFieldValue(26))
                {
                    CaptionClass = GetFieldHeader(26);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue27"; GetFieldValue(27))
                {
                    CaptionClass = GetFieldHeader(27);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue28"; GetFieldValue(28))
                {
                    CaptionClass = GetFieldHeader(28);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue29"; GetFieldValue(29))
                {
                    CaptionClass = GetFieldHeader(29);
                    ApplicationArea = All;
                }
                field("TTT-PR FieldValue30"; GetFieldValue(30))
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