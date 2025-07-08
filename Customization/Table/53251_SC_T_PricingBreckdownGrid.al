table 53251 "Pricing Breakdown"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(53100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(53101; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Description';
        }

        field(53102; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
        }

        field(53103; "Unit"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit';
            TableRelation = "Unit of Measure".Code;
        }
        field(53104; "Price Per Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Price Per Unit';
        }
        field(53105; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Cost';
        }
        field(53106; "Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile ID';
        }
        field(53107; "Vendor Proposal ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Proposal ID';
        }
        field(53108; "Vendor Contract ID"; Code[20])

        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Contract ID';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Vendor Proposal ID")
        {
            Clustered = true;
        }
    }


}
