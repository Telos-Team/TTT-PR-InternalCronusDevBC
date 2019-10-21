codeunit 50000 "TTT-PR EventTest"
{
    Description = '';
    SingleInstance = true;
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Quantity', false, false)]
    local procedure HandleSalesLineQuantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        HandleSalesLineQuantityChange(Rec, xRec, CurrFieldNo);
        HandleWhsShipmentFromSalesLineQuantity(Rec, xRec, CurrFieldNo);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Validate Source Line", 'OnBeforeVerifyFieldNotChanged', '', false, false)]
    local procedure HandleVerifyFieldNotChange(NewRecRef: RecordRef; OldRecRef: RecordRef; FieldNumber: Integer; VAR IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
        xSalesLine: Record "Sales Line";
    begin
        if NewRecRef.IsTemporary() then
            exit;
        if IsHandled = true then
            exit;
        Case FieldNumber of
            SalesLine.FieldNo("Quantity"):
                begin
                    NewRecRef.SetTable(SalesLine);
                    OldRecRef.SetTable(xSalesLine);
                    IsHandled := AllowChangeSalesLineQuantity(SalesLine, xSalesLine, FieldNumber);
                end;
        end;
    end;


    local procedure HandleSalesLineQuantityChange(Rec: Record "Sales Line"; xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
    begin
    end;

    local procedure HandleWhsShipmentFromSalesLineQuantity(Rec: Record "Sales Line"; xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
    end;

    local procedure AllowChangeSalesLineQuantity(Rec: Record "Sales Line"; xRec: Record "Sales Line"; CurrFieldNo: Integer): Boolean
    begin
    end;
}