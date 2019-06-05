page 50029 "TTT-PR XmlBuffer"
{
    Caption = 'Xml Buffer';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "XML Buffer";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("TTT-PR XmlBufferRepeater")
            {
                Caption = 'Xml Buffer Lines';
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Parent Entry No."; "Parent Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Node Number"; "Node Number")
                {
                    ApplicationArea = All;
                }
                field("Depth"; "Depth")
                {
                    ApplicationArea = All;
                }
                field("Name"; "Name")
                {
                    ApplicationArea = All;
                }
                field("Value"; "Value")
                {
                    ApplicationArea = All;
                }
                field("Data Type"; "Data Type")
                {
                    ApplicationArea = All;
                }
                field("Type"; "Type")
                {
                    ApplicationArea = All;
                }
                field("Path"; "Path")
                {
                    ApplicationArea = All;
                    Width = 50;
                }
                field("Namespace"; "Namespace")
                {
                    ApplicationArea = All;
                    Width = 10;
                }
                field("Value BLOB"; "Value BLOB".HasValue())
                {
                    ApplicationArea = All;
                }
                field("Import ID"; "Import ID")
                {
                    ApplicationArea = All;
                    Width = 5;
                }
            }
        }
    }
}