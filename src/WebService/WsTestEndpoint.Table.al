table 50002 "TTT-PR WsTestEndpoint"
{
    Caption = 'WsTest Endpoint';
    DataClassification = CustomerContent;
    DataCaptionFields = "TTT-PR Code", "TTT-PR Description";
    DrillDownPageID = "TTT-PR WsTestEndpoints";
    LookupPageID = "TTT-PR WsTestEndpoints";

    fields
    {
        field(1; "TTT-PR Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "TTT-PR Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR Url"; Text[250])
        {
            Caption = 'Url';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(4; "TTT-PR Environment"; Text[250])
        {
            Caption = 'Environment';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
    }

    keys
    {
        key(PK; "TTT-PR Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "TTT-PR Code", "TTT-PR Description")
        {
        }
    }
}
