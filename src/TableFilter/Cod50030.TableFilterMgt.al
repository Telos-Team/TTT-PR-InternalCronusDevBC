codeunit 50030 "TTT-PR TableFilterMgt"
{
    procedure EditTableFilterRecByFieldNos(parintTableNoFieldNo: Integer; parintFilterStringFieldNo: Integer; var parvarrecTable: Variant): Boolean
    var
        locrrTable: RecordRef;
        locfrTableNo: FieldRef;
    begin
        locrrTable.GetTable(parvarrecTable);
        locfrTableNo := locrrTable.Field(parintTableNoFieldNo);
        if not EditTableFilter(locfrTableNo.Value(), parintFilterStringFieldNo, parvarrecTable) then
            exit;
        locrrTable.SetTable(parvarrecTable);
        exit(true);
    end;

    procedure EditTableFilterByFieldNos(parintTableNoFieldNo: Integer; parintFilterStringFieldNo: Integer; var parvarrecTable: RecordRef): Boolean
    var
        locfrTableNo: FieldRef;
    begin
        locfrTableNo := parvarrecTable.Field(parintTableNoFieldNo);
        exit(EditTableFilter(locfrTableNo.Value(), parintFilterStringFieldNo, parvarrecTable))
    end;

    procedure EditTableFilter(parintTableNo: Integer; parintFilterStringFieldNo: Integer; var parvarrrTable: RecordRef): Boolean
    var
        locpagTableFilter: Page "Table Filter";
        locrrTable: RecordRef;
        locfrTableFilter: FieldRef;
        loctxtFilterString: Text;
    begin
        locrrTable.Open(parintTableNo, true);
        locfrTableFilter := parvarrrTable.Field(parintFilterStringFieldNo);
        loctxtFilterString := Format(locfrTableFilter.Value());

        locpagTableFilter.SetSourceTable(loctxtFilterString, locrrTable.Number(), locrrTable.Name());
        if locpagTableFilter.RunModal() <> Action::OK then
            exit(false);
        loctxtFilterString := locpagTableFilter.CreateTextTableFilter(false);
        Evaluate(locfrTableFilter, loctxtFilterString);
        exit(true);
    end;

    local procedure GetFilterString(parintTableNo: Integer; parintFilterStringFieldNo: Integer; parrrTable: RecordRef): Text
    var
        locrrTable: RecordRef;
        locfrTableFilter: FieldRef;
        loctxtFilterString: Text;
    begin
        locrrTable.Open(parintTableNo, true);
        locfrTableFilter := parrrTable.Field(parintFilterStringFieldNo);
        loctxtFilterString := Format(locfrTableFilter.Value());
        exit(loctxtFilterString);
    end;

    procedure ShowTableFilter(parintTableNo: Integer; parintFilterStringFieldNo: Integer; parrrTable: RecordRef): Boolean
    var
        loctmprecTableFilter: Record "Table Filter" temporary;
    begin
        ParseTableFilter(parintTableNo, GetFilterString(parintTableNo, parintFilterStringFieldNo, parrrTable), loctmprecTableFilter);
        Page.Run(Page::"Table Filter", loctmprecTableFilter);
    end;

    procedure ParseTableFilter(parintTableNo: Integer; partxtTableFilterString: Text; var parvarTableFilter: Record "Table Filter" temporary)
    begin
        Clear(parvarTableFilter);
        parvarTableFilter.DeleteAll(false);

        RemoveTableNameFromFilterString(partxtTableFilterString);
        while StrLen(partxtTableFilterString) > 0 do
            if ExtractNameValue(parintTableNo, partxtTableFilterString, parvarTableFilter) then
                parvarTableFilter.Insert(false);
    end;

    local procedure ExtractNameValue(parintTableNo: Integer; var TableFilterText: Text; var parvarrecTableFilter: Record "Table Filter"): Boolean
    var
        locrecField: Record Field;
        loctxtFieldName: Text;
        loctxtFilterValue: Text;
    begin
        if STRPOS(COPYSTR(TableFilterText, 1, 1), '"') = 1 then
            loctxtFieldName := GetQuotedValue(TableFilterText, '=')
        else
            loctxtFieldName := GetValue(TableFilterText, '=');
        if STRPOS(COPYSTR(TableFilterText, 1, 1), '"') = 1 then
            loctxtFilterValue := GetQuotedValue(TableFilterText, ',')
        else
            loctxtFilterValue := GetValue(TableFilterText, ',');

        locrecField.SetRange(TableNo, parintTableNo);
        locrecField.SetRange("Field Caption", loctxtFieldName);
        if not locrecField.FindFirst() then
            exit;

        parvarrecTableFilter."Line No." += 1;
        parvarrecTableFilter."Table Number" := locrecField.TableNo;
        parvarrecTableFilter."Table Name" := locrecField.TableName;
        parvarrecTableFilter."Field Number" := locrecField."No.";
        parvarrecTableFilter."Field Name" := locrecField.FieldName;
        parvarrecTableFilter."Field Caption" := locrecField."Field Caption";
        parvarrecTableFilter."Field Filter" := CopyStr(loctxtFilterValue, 1, MaxStrLen(parvarrecTableFilter."Field Filter"));
        exit(true);
    end;

    local procedure GetValue(var partxtTextString: Text; partxtDelimiter: Text) PartOfText: Text
    // Copied from page "Table Filter"
    var
        locintDelimiterPosition: Integer;
    begin
        locintDelimiterPosition := StrPos(partxtTextString, partxtDelimiter);
        if locintDelimiterPosition = 0 then begin
            // If delimiter wasn't found read everything until the end of the string:
            PartOfText := CopyStr(partxtTextString, 1, StrLen(partxtTextString));
            partxtTextString := '';
        end else begin
            PartOfText := CopyStr(partxtTextString, 1, locintDelimiterPosition - 1);
            partxtTextString := CopyStr(partxtTextString, locintDelimiterPosition + 1, StrLen(partxtTextString) - locintDelimiterPosition);
        end;

        exit(PartOfText);
    end;

    local procedure GetQuotedValue(var partxtTextString: Text; partxtDelimiter: Text) PartOfText: Text
    // Copied from page "Table Filter"
    var
        locintLength: Integer;
        locintPosition: Integer;
        locbooEvenQuote: Boolean;
        locbooIsDelimiter: Boolean;
        locbooIsQuote: Boolean;
        loctxtOneCharString: Text;

    begin
        partxtTextString := CopyStr(partxtTextString, 2, StrLen(partxtTextString) - 1);
        locintLength := StrLen(partxtTextString);

        locbooEvenQuote := false;
        locintPosition := 1;
        while locintPosition <= locintLength do begin
            loctxtOneCharString := CopyStr(partxtTextString, locintPosition, 1);

            locbooIsDelimiter := loctxtOneCharString = partxtDelimiter;
            if locbooIsDelimiter and locbooEvenQuote then begin
                PartOfText := CopyStr(partxtTextString, 1, locintPosition - 2);
                PartOfText := UnescapeQuotedValue(PartOfText);
                partxtTextString := CopyStr(partxtTextString, locintPosition + 1, StrLen(partxtTextString) - locintPosition);
                exit(PartOfText);
            end;

            locbooIsQuote := StrPos(loctxtOneCharString, '"') = 1;
            if locbooIsQuote then
                locbooEvenQuote := not locbooEvenQuote;

            locintPosition += 1;
        end;

        PartOfText := CopyStr(partxtTextString, 1, locintPosition - 2);
        PartOfText := UnescapeQuotedValue(PartOfText);
        partxtTextString := '';
        exit(PartOfText);
    end;

    local procedure UnescapeQuotedValue(partxtTextValue: Text): Text
    // Copied from standard page "Table Filter"
    var
        InnerQuotePosition: Integer;
        loctxtTextValue2: Text;
    begin
        InnerQuotePosition := StrPos(partxtTextValue, '""');
        if InnerQuotePosition = 0 then
            exit(partxtTextValue);

        while InnerQuotePosition > 0 do begin
            loctxtTextValue2 += CopyStr(partxtTextValue, 1, InnerQuotePosition);
            partxtTextValue := CopyStr(partxtTextValue, InnerQuotePosition + 2, StrLen(partxtTextValue) - InnerQuotePosition - 1);
            InnerQuotePosition := StrPos(partxtTextValue, '""');
        end;

        loctxtTextValue2 += partxtTextValue;
        exit(loctxtTextValue2);
    end;

    local procedure RemoveTableNameFromFilterString(var parvartxtTableFilterString: Text)
    // Copied from page "Table Filter"
    var
        loctxtTableName2: Text;
    begin
        if StrPos(CopyStr(parvartxtTableFilterString, 1, 1), '"') = 1 then
            loctxtTableName2 := GetQuotedValue(parvartxtTableFilterString, ':')
        else
            loctxtTableName2 := GetValue(parvartxtTableFilterString, ':');
        parvartxtTableFilterString := CopyStr(parvartxtTableFilterString, 2, STRLEN(parvartxtTableFilterString) - 1);
    end;

}
