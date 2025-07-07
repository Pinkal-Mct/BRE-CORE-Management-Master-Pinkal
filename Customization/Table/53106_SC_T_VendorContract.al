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

        field(53121; "Project Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Location';
        }
        field(53122; "Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(53123; "Delivery Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Delivery Location';
        }

        field(53124; "Delivery Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Delivery Date';
        }
        field(53125; "Late Delivery Penalty %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Late Delivery Penalty %';
        }
        field(53126; "Total Contract Value (AED)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(53127; "VAT %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT %';
        }

        field(53128; "Advance Payment (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Advance Payment (%)';
        }

        field(53129; "Interim Payment (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Interim Payment (%)';
        }

        field(53130; "Final Payment (%)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Payment (%)';
        }
        field(53131; "Payment Method"; Option)
        {
            OptionCaption = 'Bank Transfer,Cash,Cheque';
            OptionMembers = "Bank Transfer",Cash,Cheque;
            DataClassification = ToBeClassified;
            Caption = 'Payment Method';
        }
        field(53132; "UAE Compliance Requirements"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'UAE Compliance Requirements';
        }
        field(53133; "Industry Standards"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Industry Standards';
        }
        field(53134; "Warranty Period (Months)"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Period (Months)';
        }
        field(53135; "Dispute Resolution"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dispute Resolution';
        }
        field(50136; Incoterms; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Incoterms';
        }
        field(50137; "Service Type"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type';
        }
        // field(53128; "Task ID"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Task ID';

        // }
        // field(53129; "Task Name"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Task Name';
        //     // TableRelation = "Project Milestone Task"."Task Name" where("Project ID" = field("Project ID"));
        // }
        // field(53130; "Task Start Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Task Start Date';
        // }
        // field(53131; "Task End Date"; Date)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Task End Date';

        // }
        // field(53132; "Task Description"; Text[1000])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Task Description';
        // }
        // field(53133; Notes; Text[1000])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Notes';
        // }
        // field(53134; "Milestone ID"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Milestone ID';

        // }
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
        Rec."Contract Date" := Today;
        UpdatePricingBreakdownGrid(Rec."Proposal ID", Rec."Contract ID");
    end;

    procedure UpdatePricingBreakdownGrid(pProposalID: Code[20]; pContractID: Code[20])
    var
        pricingBreakDown: Record "Pricing Breakdown";
    begin
        pricingBreakDown.SetRange("Vendor Proposal ID", pProposalID);
        if pricingBreakDown.FindSet() then
            repeat
                pricingBreakDown.ModifyAll("Vendor Contract ID", pContractID);
            until pricingBreakDown.Next() = 0;
    end;

    trigger OnDelete()
    var
    begin
        DeletePricingBreakdowngrid();
    end;

    procedure DeletePricingBreakdowngrid()
    var
        Vendorprofiledocumentgrid: Record "Pricing Breakdown";
    begin
        Vendorprofiledocumentgrid.SetRange("Vendor Contract ID", Rec."Contract ID");
        if Vendorprofiledocumentgrid.FindSet() then begin
            Vendorprofiledocumentgrid.DeleteAll();
        end
    end;
}