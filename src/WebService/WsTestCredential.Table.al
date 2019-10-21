table 50003 "TTT-PR WsTestCredential"
{
    Caption = 'WsTest Credential';
    DataClassification = CustomerContent;
    DataCaptionFields = "TTT-PR Code", "TTT-PR Description";
    DrillDownPageID = "TTT-PR WsTestCredentials";
    LookupPageID = "TTT-PR WsTestCredentials";

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
        field(3; "TTT-PR DomainName"; Text[50])
        {
            Caption = 'Domain name';
            DataClassification = CustomerContent;
        }
        field(4; "TTT-PR Username"; Text[50])
        {
            Caption = 'Username';
            DataClassification = CustomerContent;
        }
        field(5; "TTT-PR Password"; Text[50])
        {
            Caption = 'Password';
            DataClassification = CustomerContent;
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
