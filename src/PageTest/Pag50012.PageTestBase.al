page 50012 "TTT-PR PageTestBase"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Actions';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = '';
                field("TTT-PR ActionInfo"; 'Please note the difference in action result when pressing esc and cancel comparing LookupMode to non LookupMode')
                {
                    Caption = 'Action info';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("TTT-PR ShowModal")
            {
                Caption = 'Modal';
                ToolTip = 'This will perform Page.Runmodal(x, rec)';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                begin
                    Clear(locrecInt);
                    if Page.RunModal(Page::"TTT-PR PageTestSelector", locrecInt) <> Action::LookupOK then
                        exit;
                    ShowRecordInfo(locrecInt, Action::None);
                end;
            }
            action("TTT-PR ShowModalGetRecord")
            {
                Caption = 'Modal, Get Record';
                ToolTip = 'This will run Pagevariable.RunModal()';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                    locpag: Page "TTT-PR PageTestSelector";
                    locactPressed: Action;
                begin
                    Clear(locrecInt);
                    locactPressed := locpag.RunModal();
                    locpag.GetRecord(locrecInt);
                    ShowRecordInfo(locrecInt, locactPressed);
                end;
            }
            action("TTT-PR ShowModalLookupGetRecord")
            {
                Caption = 'Modal, LookupMode, Get Record';
                ToolTip = 'This will run Pagevariable.RunModal()';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                    locpag: Page "TTT-PR PageTestSelector";
                    locactPressed: Action;
                begin
                    Clear(locrecInt);
                    locpag.LookupMode(true);
                    locactPressed := locpag.RunModal();
                    locpag.GetRecord(locrecInt);
                    ShowRecordInfo(locrecInt, locactPressed);
                end;
            }
            action("TTT-PR ShowModalGetMarked")
            {
                Caption = 'Modal, Get Marked';
                ToolTip = 'This will run Pagevar.RunModal() and use SetSelectionFilter';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                    locpag: Page "TTT-PR PageTestSelector";
                    locactPressed: Action;
                begin
                    locactPressed := locpag.RunModal();
                    locpag.GetRecord(locrecInt);
                    locpag.SetSelectionFilter(locrecInt);
                    ShowRecordInfo(locrecInt, locactPressed);
                end;
            }
            action("TTT-PR ShowModalLookupGetMarked")
            {
                Caption = 'Modal, LookupMode, Get Marked';
                ToolTip = 'This will run Pagevar.RunModal() and use SetSelectionFilter';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                    locpag: Page "TTT-PR PageTestSelector";
                    locactPressed: Action;
                begin
                    locpag.LookupMode(true);
                    locactPressed := locpag.RunModal();
                    locpag.GetRecord(locrecInt);
                    locpag.SetSelectionFilter(locrecInt);
                    ShowRecordInfo(locrecInt, locactPressed);
                end;
            }
            action("TTT-PR ShowModalFiltersGetMarked")
            {
                Caption = 'Modal, Filters, Get Marked';
                ToolTip = 'This will run Pagevar.RunModal() with filtered record and use SetSelectionFilter';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                    locpag: Page "TTT-PR PageTestSelector";
                    locactPressed: Action;
                begin
                    locrecInt.SetRange(Number, 10, 20);
                    locpag.SetTableView(locrecInt);
                    locactPressed := locpag.RunModal();
                    Clear(locrecInt);
                    locpag.GetRecord(locrecInt);
                    locpag.SetSelectionFilter(locrecInt);
                    ShowRecordInfo(locrecInt, locactPressed);
                end;
            }
            action("TTT-PR ShowModalLookupFiltersGetMarked")
            {
                Caption = 'Modal, Lookup, Filters, Marked';
                ToolTip = 'This will run Pagevar.RunModal() with filtered record and use SetSelectionFilter';
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    locrecInt: Record Integer;
                    locpag: Page "TTT-PR PageTestSelector";
                    locactPressed: Action;
                begin
                    locrecInt.SetRange(Number, 10, 20);
                    locpag.SetTableView(locrecInt);
                    locpag.LookupMode(true);
                    locactPressed := locpag.RunModal();
                    Clear(locrecInt);
                    locpag.GetRecord(locrecInt);
                    locpag.SetSelectionFilter(locrecInt);
                    ShowRecordInfo(locrecInt, locactPressed);
                end;
            }
        }
    }

    local procedure ShowRecordInfo(var parvarrecInt: Record Integer; paractPressed: Action)
    begin
        Message('Pressed: %1\Current rec: %2\Record count: %3\Record filters: %4',
            paractPressed, parvarrecInt.Number, parvarrecInt.Count(), parvarrecInt.GetFilters());
    end;
}