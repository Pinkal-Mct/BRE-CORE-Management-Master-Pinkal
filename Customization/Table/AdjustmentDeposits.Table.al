table 50119 "Adjustment Deposits"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(50101; "Item Description"; Enum "Deposit Type")
        {
        }

        field(50102; "Transaction Type"; Option)
        {
            OptionMembers = " ",Refund,Adjustment;
        }

        field(50104; "Amount"; Decimal)
        {
        }

        field(50105; "Narration"; Text[250])
        {
        }

        field(50106; "Posted"; Boolean)
        {
        }

        field(50107; "Posting Date"; Date)
        {
        }
        field(50108; "Contract Id"; Integer)
        {
        }
        field(50109; "Adjusted"; Boolean)
        {
        }
    }

    keys
    {
        key(PK; "Entry No.", "Contract Id")
        {
            Clustered = true;
        }
    }
}
