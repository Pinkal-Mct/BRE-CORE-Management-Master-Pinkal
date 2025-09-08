page 53768 "Item API"
{
    APIGroup = 'emails';
    APIPublisher = 'yourpub';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'Item';
    DelayedInsert = true;
    EntityName = 'Item';
    EntitySetName = 'Items';
    PageType = API;
    SourceTable = Item;
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'System Id';
                }
                field("Item_No"; Rec."No.")
                {
                    Caption = 'Item No.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Unit_Size"; Rec."Unit Size")
                {
                    Caption = 'Unit Size';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field("Market_Rate"; Rec."Market Rate per Sq. Ft.")
                {

                }
                field("Unit_Address"; Rec."Unit Address")
                {
                    Caption = 'Unit Address';
                }
                field("Usage_Type"; Rec."Usage Type")
                {
                    Caption = 'Usage Type';
                }
                field("Unit_Type"; Rec."Unit Type")
                {
                    Caption = 'Unit Type';
                }
                field(Community; Rec.Community)
                {
                    Caption = 'Community';
                }
                field("Emirate_Name"; Rec."Emirate Name")
                {
                    Caption = 'Emirate Name';
                }
            }
        }
    }
}
