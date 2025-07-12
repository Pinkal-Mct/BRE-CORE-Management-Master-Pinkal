table 50967 "Request Credit Note"
{
    DataClassification = ToBeClassified;
    Caption = 'Request Credit Note';

    fields
    {
        field(50960; "Contract ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }

        field(50961; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
            Editable = false;
        }
        field(50962; "Tenant No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant No.';
            Editable = false;
        }

        field(50963; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Name';
            Editable = false;
        }
        field(50964; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request Date';
            Editable = false;
        }
        field(50965; "Credit Note Start Month"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note Start Month';
            Editable = false;
        }
        field(50966; "Credit Note End Month"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Note End Month';
            Editable = false;
        }
        field(50967; "Payment Frequency"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Frequency';
            Editable = false;
        }

        field(50968; "Monthly Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Monthly Reduction';
            Editable = false;

        }
        field(50969; "Reason"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reason';
            Editable = false;
        }
        field(50970; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Pending,Approved,Rejected;
            Caption = 'Status';
            Editable = false;
        }
        field(50971; "Request Source"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requsest Source';
            Editable = false;
        }
        field(50972; "Total Reduction"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Reduction';
            Editable = false;
        }



    }
}