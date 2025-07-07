table 53105 "Vendor Proposal"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Proposal ID";

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
            TableRelation = "Construction Project"."Project ID" where("Approval Status" = CONST(Approved));
            DataClassification = ToBeClassified;
            Caption = 'Project ID';
        }
        field(53102; "Vendor ID"; code[20])
        {
            TableRelation = "Facility Vendor Profiles"."Profile ID";
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
            // OptionMembers = " ",Monthly,Quarterly,"Half-Yearly",Yearly;
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
        field(53115; "Created DateTime"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Created Date';
        }
        field(53116; "Vendor Email"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Email';
        }
        field(53117; "Vendor Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Name';
        }
        field(53118; "Vendor Designation"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Designation';
        }
        field(53119; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(53120; "Duration"; Text[50])
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
            Caption = 'Total Contract Value (AED)';
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
        field(53132; "UAE Compliance Requirements"; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'UAE Compliance Requirements';
        }
        field(53133; "Industry Standards"; Text[500])
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
        field(50136; Incoterms; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'Incoterms';
        }
        field(50137; "Service Type"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type';
        }

    }

    keys
    {
        key(PK; "Proposal ID")
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
        Rec."Created By" := UserId();
        Rec."Created DateTime" := Today;
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
        Vendorprofiledocumentgrid.SetRange("Vendor Proposal ID", Rec."Proposal ID");
        if Vendorprofiledocumentgrid.FindSet() then begin
            Vendorprofiledocumentgrid.DeleteAll();
        end
    end;


}