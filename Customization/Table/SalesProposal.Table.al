table 51505 "Sales Proposal"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51501; "Proposal No."; Code[20])
        {

            Caption = 'Proposal No.';
            Editable = false;
        }
        field(51502; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            TableRelation = Opportunity."No.";
        }
        field(51503; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(51504; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser"."Code";
        }
        field(51505; "Proposal Date"; Date)
        {
            Caption = 'Proposal Date';

        }
        field(51506; "Delivery Date"; Date)
        {

            Caption = 'Delivery Date';
        }
        field(51507; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = " ",Open,Released,Accepted,Rejected;
        }
        field(51508; "Unit Price"; Decimal)
        {
            caption = 'Unit Price';
        }
        field(51509; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
        }
        field(51510; "Net Price"; Decimal)
        {
            Caption = 'Net Price';
            Editable = false;
        }
        field(51511; "Taxes"; Decimal)
        {
            Caption = 'Taxes';
        }
        field(51512; "Fees"; Decimal)
        {
            Caption = 'Fees';
        }
        field(51513; "Payment Plan"; Text[100])
        {
            Caption = 'Payment Plan';
        }
        field(51514; "Reservation Fee"; Decimal)
        {
            Caption = 'Reservation Fee';
        }
        field(51515; "Penalty/Cancellation Summary"; Text[250])
        {
            Caption = 'Penalty/Cancellation Summary';
        }
        field(51516; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionMembers = " ",NotSubmitted,Submitted,Approved,Rejected;
        }
        field(51517; Units; Integer)
        {
            Caption = 'Units';
        }
        field(51518; "Reason for Rejection"; Text[500])
        {
            Caption = 'Reason for Rejection';
            Editable = false;
        }
        field(51519; "Internal Remark"; Text[250])
        {
            Caption = 'Internal Remark';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Proposal No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."Proposal No." := noseries.GetNextNo(noSeriesSetup."Sales Proposal ID Nos.")
        else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}