tableextension 50511 CustLedgerEntryExt extends "Cust. Ledger Entry"

{
    fields
    {
        field(50000; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
            DataClassification = CustomerContent;
        }
    }
}
