table 53106 "Vendor Contract"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Contract ID";

    Caption = 'Vendor Contract';
    fields
    {
        field(53100; "Contract ID"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(53101; "Proposal ID"; code[20])
        {


            DataClassification = ToBeClassified;
            Caption = 'Proposal ID';
            TableRelation = "Vendor Proposal"."Proposal ID" WHERE("Internal Approval Status" = CONST(Approved), "Vendor Approval Status" = CONST(Approved));

        }
        field(53102; "Project ID"; code[20])
        {

            DataClassification = ToBeClassified;
            Caption = 'Project ID';
            Editable = false;
        }
        field(53103; "Vendor ID"; code[20])
        {
            // TableRelation = "Facility Vendor Profiles"."Vendor ID";
            DataClassification = ToBeClassified;
            Caption = 'Vendor ID';
        }
        field(53104; "Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Date';
        }
        field(53105; "Work Scope"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Scope';
        }
        field(53106; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Start Date';

            trigger OnValidate()
            begin
                if ("Contract End Date" <> 0D) and ("Contract Start Date" > "Contract End Date") then
                    Error('Start Date cannot be after End Date.');
            end;
        }
        field(53107; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract End Date';
            trigger OnValidate()
            begin
                if ("Contract Start Date" <> 0D) and ("Contract End Date" < "Contract Start Date") then
                    Error('End Date cannot be before Start Date.');
            end;
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
            OptionCaption = 'Draft,Pending,Approved,Rejected';
            OptionMembers = Draft,Pending,Approved,Rejected;
            DataClassification = ToBeClassified;
            Caption = 'Internal Approval Status';
        }
        field(53113; "Vendor Approval Status"; Option)
        {
            OptionCaption = 'Draft,Pending,Approved,Rejected';
            OptionMembers = Draft,Pending,Approved,Rejected;
            DataClassification = ToBeClassified;
            Caption = 'Vendor Approval Status';
        }
        field(53114; "Created By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }
        field(53115; "Vendor Email"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Email';
        }
        field(53116; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
        }
        field(53117; "Vendor Designation"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Designation';
        }
        field(53118; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(53119; "Duration"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Duration';
        }
        field(53120; "Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Amount';
        }

    }

    keys
    {
        key(PK; "Contract ID")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Contract ID", "Proposal ID", "Project ID", "Vendor ID")
        {

        }

    }

    trigger OnInsert()

    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."Contract ID" := noseries.GetNextNo(noSeriesSetup."Vendor Contract Nos.");
        end else
            Error('No. Series Setup not found for Vendor Contract Nos.');
        rec."Created By" := UserId();
    end;
}