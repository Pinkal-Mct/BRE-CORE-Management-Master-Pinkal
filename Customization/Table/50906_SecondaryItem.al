table 50906 "Secondary Item"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {


        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Primary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Item';
            TableRelation = "Primary Item"."Primary Item Type";
            Editable = false; // Make it read-only for the user


        }
        field(50102; "Category Types"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            TableRelation = "Category Type"."Category Types";

            trigger OnValidate()
            var
                CategoryRec: Record "Category type"; // This is a placeholder, replace with the actual category-related table
                PrimaryRec: Record "Primary Item";
            begin
                CategoryRec.SetRange("Category Types", Rec."Category Types");

                if CategoryRec.FindFirst() then begin
                    "Primary Item Type" := CategoryRec."Primary Item Type";
                end else begin

                    "Primary Item Type" := '';
                end;
            end;


        }

        field(50103; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item';

        }

        field(50104; "VAT Type"; Option)
        {
            Caption = 'VAT Type';
            OptionMembers = "Zero-0%","Standard-5%"; // Update this based on the data's classification

            trigger OnValidate()
            begin
                case "VAT Type" of
                    0:
                        "VAT %" := 0; // Zero-0%
                    1:
                        "VAT %" := 1; // Standard-5%
                    else
                        "VAT %" := 0; // Default to Zero-0% if no match
                end;
            end;
        }


        field(50105; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;

        }

        field(50106; "Charges Status"; Option)
        {
            OptionMembers = " ","Regular Charges","Additional Charges";
            Caption = 'Charges Status';

        }

    }

    keys
    {
        key(PK; "ID", "Primary Item Type", "VAT Type", "VAT %", "Category Types", "Secondary Item Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Secondary Item Type", "VAT %", "VAT Type", "Category Types", "Primary Item Type", ID)
        {

        }
    }
}
