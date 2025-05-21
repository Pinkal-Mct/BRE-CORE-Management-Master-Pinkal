tableextension 50505 "PostedSalesInvoiceLine" extends "Sales Invoice Line"
{
    fields
    {
        field(50101; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(50102; "FC ID"; Integer)
        {
            Caption = 'FC ID';
            DataClassification = ToBeClassified;

        }
    }
}