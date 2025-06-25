table 53105 "Vendor Proposal"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Proposal';
    fields
    {
        field(53100; "Proposal ID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
        }
        field(53101; "Project ID"; code[20])
        {
            TableRelation = "Construction Project"."Project ID";
            DataClassification = ToBeClassified;
            Caption = 'Project ID';
        }
        field(53102; "Vendor ID"; code[20])
        {
            TableRelation = "Vendor Profile"."Vendor ID";
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
        }
        field(53103; "Proposal Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Proposal Date';
        }
        field(53104; "Work Scope"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Scope';
        }
        field(53105; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                if ("End Date" <> 0D) and ("Start Date" > "End Date") then
                    Error('Start Date cannot be after End Date.');
            end;
        }
        field(53106; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
            trigger OnValidate()
            begin
                if ("Start Date" <> 0D) and ("End Date" < "Start Date") then
                    Error('End Date cannot be before Start Date.');
            end;
        }
        field(53107; "Quoted Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = '';
        }
        field(53108; "Payment Terms"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Terms';
        }
        field(53109; "Compliance Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Compliance Required';
        }
        field(53110; "Internal Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Internal Remarks';
        }
        field(53111; "Vendor Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Remarks';
        }
        field(53112; "Internal Approval Status"; Option)
        {
            OptionCaption = ' ,Draft,Pending,Approved,Rejected';
            OptionMembers = " ",Draft,Pending,Approved,Rejected;
            DataClassification = ToBeClassified;
            Caption = 'Internal Approval Status';
        }
        field(53113; "Vendor Approval Status"; Option)
        {
            OptionCaption = ' ,Draft,Pending,Approved,Rejected';
            OptionMembers = " ",Draft,Pending,Approved,Rejected;
            DataClassification = ToBeClassified;
            Caption = 'Vendor Approval Status';
        }
        field(53114; "Created By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }
        field(53115; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Created DateTime';
        }
    }

    keys
    {
        key(PK; "Proposal ID", "Project ID", "Vendor ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."Proposal ID" := noseries.GetNextNo(noSeriesSetup."Vendor Proposal Nos.");
        end else
            Error('No. Series Setup not found for Vendor Proposal Nos.');
    end;
}