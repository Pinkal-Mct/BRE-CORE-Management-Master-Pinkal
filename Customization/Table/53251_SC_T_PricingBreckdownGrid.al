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

        field(53101; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';

        }

        field(53102; "Line No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }

        field(53103; "Item Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Description';
        }

        field(53104; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Quantity';
        }

        field(53105; "Unit"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit';
        }

        field(53106; "Price Per Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Price Per Unit';
        }

        field(53107; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Cost';

        }

        field(53108; "Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile ID';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Profile ID")
        {
            Clustered = true;
        }
    }


}
