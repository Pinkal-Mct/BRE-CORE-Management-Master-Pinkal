table 50971 "OverDuePaymentmode"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }

        field(50101; "Status"; Enum "Approval Status Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(50102; "Tenant Id"; Code[20])
        {
            Caption = 'Tenant Id';
        }

        field(50103; "Contract ID"; Integer)
        {
            Caption = 'Contract ID';
        }

        field(50104; "Payment Series"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Series';

        }
        field(50105; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Due Date';
        }

        field(50106; "Payment Status"; Enum "Payment Status")
        {
            Caption = 'Payment Status';
        }

        field(50107; "Tenant Name"; Text[100])
        {
            Caption = 'Tenant Name';
        }
    }

    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }

    }

    trigger OnInsert()
    var
        overduepaymentapproval: Codeunit OverduePaymentReq;
    begin
        overduepaymentapproval.SendApprovalrequest(Rec);
    end;
}