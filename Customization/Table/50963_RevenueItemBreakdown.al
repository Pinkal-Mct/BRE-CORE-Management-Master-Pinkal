table 50963 "Revenue Item Breakdown"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "RI_No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            AutoIncrement = true;
        }

        field(50101; "Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Type';
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"), "Charges Status" = CONST("Regular Charges"));

            trigger OnValidate()
            var
                SecondaryItemRec: Record Item;
            begin
                // Check if a record with the selected Secondary Item Type exists
                SecondaryItemRec.SetRange("No.", Rec."Item Type");
                if SecondaryItemRec.FindFirst() then
                    "Item Type" := SecondaryItemRec.Description;
            end;
        }


    }

    keys
    {
        key(PK; "RI_No.") { Clustered = true; }
    }

    trigger OnDelete()
    var
    begin
        revenuebrekdown();
    end;

    procedure revenuebrekdown()
    var
        revenuebreakdowndetails: Record "Revenue Item Breakdown Details";

    begin
        revenuebreakdowndetails.SetRange("RI_No.", Rec."RI_No.");
        if revenuebreakdowndetails.FindSet() then begin
            revenuebreakdowndetails.DeleteAll();
        end
    end;
}

