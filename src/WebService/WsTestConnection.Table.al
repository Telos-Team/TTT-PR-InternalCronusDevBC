table 50004 "TTT-PR WsTestConnection"
{
    Caption = 'WsTest Web Connection';
    DataClassification = CustomerContent;
    DataCaptionFields = "TTT-PR Code", "TTT-PR Description";
    DrillDownPageID = "TTT-PR WsTestConnections";
    LookupPageID = "TTT-PR WsTestConnections";

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
        field(3; "TTT-PR EndpointCode"; Code[50])
        {
            Caption = 'Endpoint Code';
            DataClassification = CustomerContent;
            TableRelation = "TTT-PR WsTestEndpoint";
        }
        field(4; "TTT-PR CredentialCode"; Code[50])
        {
            Caption = 'Credential Code';
            DataClassification = CustomerContent;
            TableRelation = "TTT-PR WsTestCredential";
        }
        field(5; "TTT-PR AuthenticationType"; Enum "TTT-PR WsTestAuthenticationType")
        {
            Caption = 'Authentication Type';
            DataClassification = CustomerContent;
        }
        field(6; "TTT-PR OK"; Boolean)
        {
            Caption = 'OK';
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
}