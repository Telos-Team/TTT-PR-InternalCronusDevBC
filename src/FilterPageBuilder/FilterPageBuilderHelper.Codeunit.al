codeunit 50031 "TTT-PR FilterPageBuilderHelper"
{
    Description = 'Filter Page Builder Helper';

    /// <summary>
    /// Show filter page and return the resulting view.
    /// </summary>
    /// <remarks>
    /// This overload shows only fields in the primary key.
    /// <para>qwer</para>
    /// </remarks>
    /// <returns>
    /// Returnvalue is a view string with UseNames=false.
    /// </returns>
    /// <example>
    /// This is how to run the filter page from a page action:
    /// <code>
    /// trigger OnAction()
    /// var
    ///     loccuFPBHelper: Codeunit "TTT-PR FilterPageBuilderHelper";
    /// begin
    ///     Rec.SetView(loccuFPBHelper.GetViewFromFilterPage(Rec.RecordId().TableNo()));
    /// end;
    /// </code>
    /// </example>
    /// <param name="parintTableNo">Set the table no. to be used for the filter page.</param>
    procedure GetViewFromFilterPage(parintTableNo: Integer): Text
    var
        locfrRec: FieldRef;
        lockrRec: KeyRef;
        locintFieldCount: Integer;
        locintFieldCounter: Integer;
    begin
        SetTableNo(parintTableNo);
        lockrRec := rrRec.KeyIndex(1);
        locintFieldCount := lockrRec.FieldCount();
        for locintFieldCounter := 1 to locintFieldCount do begin
            locfrRec := lockrRec.FieldIndex(locintFieldCounter);
            if locfrRec.Active() then
                SetField(locfrRec.Number());
        end;
        exit(GetViewFromFilterPage());
    end;

    procedure GetViewFromFilterPage(parintTableNo: Integer; partxtView: Text): Text
    begin
        SetTableNo(parintTableNo);
        SetView(partxtView);
        exit(GetViewFromFilterPage());
    end;

    procedure GetViewFromFilterPage() ReturnValue: Text
    var
        locintFieldNo: Integer;
        loctxtFilter: Text;
    begin
        ReturnValue := GetView(false);

        fpbFields.AddRecordRef(rrRec.Name(), rrRec);
        fpbFields.PageCaption(rrRec.Caption());
        fpbFields.SetView(rrRec.Name(), ReturnValue);

        foreach locintFieldNo in listFields do
            if dictFields.ContainsKey(locintFieldNo) then begin
                dictFields.Get(locintFieldNo, loctxtFilter);
                fpbFields.AddFieldNo(rrRec.Name(), locintFieldNo, loctxtFilter);
            end else
                fpbFields.AddFieldNo(rrRec.Name(), locintFieldNo);

        if not fpbFields.RunModal() then
            exit;
        rrRec.SetView(fpbFields.GetView(rrRec.Name(), false));

        ReturnValue := GetView(false);
    end;

    procedure SetTableNo(parintTableNo: Integer)
    begin
        rrRec.Close();
        rrRec.Open(parintTableNo);
    end;

    procedure SetView(partxtView: Text)
    begin
        rrRec.SetView(partxtView);
    end;

    procedure SetField(parintFieldNo: Integer)
    begin
        if listFields.Contains(parintFieldNo) then
            exit;
        listFields.Add(parintFieldNo);
    end;

    procedure SetField(parintFieldNo: Integer; partxtFilter: Text)
    begin
        if dictFields.ContainsKey(parintFieldNo) then
            dictFields.Remove(parintFieldNo);
        dictFields.Add(parintFieldNo, partxtFilter);
        SetField(parintFieldNo);
    end;

    procedure GetView(parbooUseNames: Boolean): Text
    begin
        exit(rrRec.GetView(parbooUseNames));
    end;

    var
        rrRec: RecordRef;
        fpbFields: FilterPageBuilder;
        dictFields: Dictionary of [Integer, Text];
        listFields: List of [Integer];
}