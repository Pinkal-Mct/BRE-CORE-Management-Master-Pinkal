codeunit 51251 "Item Temaplate Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Templ. Mgt.", OnBeforeSelectItemTemplate, '', false, false)]
    local procedure OnBeforeSelectItemTemplate(ItemTempl: Record "Item Templ."; var IsHandled: Boolean; var Result: Boolean)
    var
        itemDialogBox: Page "Item Dialog Box";
        itemCategory: Enum "Item Template Enum";
        itemTemplPage: Page "Item Templ. List";
    begin

        if itemDialogBox.RunModal() = Action::OK then begin
            itemCategory := itemDialogBox.GetItemCategory();
        end;

        ItemTempl.SetRange(Types, itemCategory);
        if ItemTempl.Count = 1 then begin
            ItemTempl.FindFirst();
            IsHandled := true;
            Result := true;
            exit;
        end;

        itemTemplPage.SetTableView(ItemTempl);
        itemTemplPage.LookupMode(true);
        if itemTemplPage.RunModal() = Action::LookupOK then begin
            itemTemplPage.GetRecord(ItemTempl);
            IsHandled := true;
            Result := true;
        end else begin
            IsHandled := true;
            Result := false;
        end;

        IsHandled := true; // Prevent default behavior
        // Message('Hello world');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Templ. Mgt.", OnBeforeOpenBlankCardConfirmed, '', false, false)]
    local procedure OnBeforeOpenBlankCardConfirmed(var IsHandled: Boolean)
    begin
        IsHandled := true;// Prevent default behavior
    end;
}