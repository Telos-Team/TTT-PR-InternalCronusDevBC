table 50014 "TTT-PR HyperlinkWrapperTest"
{
    Caption = 'Hyperlink Wrapper Test';
    DataClassification = CustomerContent;
    LookupPageId = "TTT-PR HyperlinkWrapperTest";

    fields
    {
        field(1; "TTT-PR Key"; Code[20])
        {
            Caption = 'Key';
            DataClassification = CustomerContent;
        }

        field(2; "TTT-PR Value"; Text[250])
        {
            Caption = 'Value';
            DataClassification = CustomerContent;
        }
        field(3; "TTT-PR Type"; Text[50])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "TTT-PR Key")
        {
            Clustered = true;
        }
    }
}