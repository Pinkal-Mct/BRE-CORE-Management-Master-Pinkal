pageextension 51252 ItemTemplate extends "Item Templ. Card"
{
    layout
    {
        addafter("No. Series")
        {
            field("Item Type"; Rec."Module Type")
            {
                ApplicationArea = All;
            }
            field(Types; Rec.Types)
            {
                ApplicationArea = All;
            }
            field("Item type template"; Rec."Item type template")
            {
                ApplicationArea = All;
            }
        }
    }
}