tableextension 51251 ItemTemplate extends "Item Templ."
{
    fields
    {
        field(50140; "Module Type"; Enum "Item Type Enum")
        {
            Caption = 'Module Type';
            DataClassification = ToBeClassified;
        }
        field(50142; "Types"; Enum "Item Template Enum")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
    }
}