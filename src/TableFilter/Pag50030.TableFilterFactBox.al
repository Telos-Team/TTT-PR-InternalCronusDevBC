page 50030 "TTT-PR TableFilterFactBox"
{
    Caption = 'Table Filters';
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Table Filter";
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(Header)
            {
                ShowCaption = false;

                field(HeaderField; txtHeader)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    QuickEntry = false;
                    ShowCaption = false;
                }
            }
            repeater(Lines)
            {
                field(FieldCaption; "Field Caption")
                {
                    ApplicationArea = All;
                }
                field(FieldFilter; "Field Filter")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure SetSourceTable(parintTableNo: Integer; partxtFilterString: Text; partxtHeader: Text)
    var
        loccuTableFilterMgt: Codeunit "TTT-PR TableFilterMgt";
    begin
        Clear(txtHeader);
        if not IsTemporary() then
            exit;
        Clear(rec);
        DeleteAll(false);
        if partxtFilterString <> '' then begin
            txtHeader := partxtHeader;
            loccuTableFilterMgt.ParseTableFilter(parintTableNo, partxtFilterString, rec);
            Clear(rec);
        end;
        CurrPage.Update(false);
    end;

    var
        txtHeader: Text;
}