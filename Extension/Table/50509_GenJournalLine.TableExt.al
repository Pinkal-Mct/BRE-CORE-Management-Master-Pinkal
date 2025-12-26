tableextension 50509 GenJournalLineExt extends "Gen. Journal Line"

{
    fields
    {
        field(50000; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
        field(50001; "Item Description"; Enum "Deposit Type")
        {
            Caption = 'Item Description';
            DataClassification = CustomerContent;
        }
        field(50002; "Transaction Type"; Option)
        {
            Caption = 'Transaction Type';
            DataClassification = CustomerContent;
            OptionMembers = " ",Refund,Adjustment;
        }
    }
}
