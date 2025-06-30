table 53752 "Vendor Assignment"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Assignment';
    fields
    {
        field(53750; "Assignment ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Assignment ID';
        }
        field(53751; "Project ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project ID';
            TableRelation = "Construction Project"."Project ID";

            trigger OnValidate()
            var
                constructionProject: Record "Construction Project";
            begin
                if not constructionProject.Get(Rec."Project ID") then
                    Error('Project with ID %1 does not exist.', Rec."Project ID")
                else begin
                    Rec."Project Name" := constructionProject."Project Name";
                    Rec."Project Start Date" := constructionProject."Planned start date";
                    Rec."Project End Date" := constructionProject."Planned end Date";
                end;
            end;
        }
        field(53752; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(53753; "Project Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Location';
        }
        field(53754; "Project Scope"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Scope';
        }
        field(53755; "Project Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Start Date';
        }
        field(53756; "Project End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Project End Date';
        }
        field(53757; "Vendor/Subcontractor ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor/Subcontractor ID';
            TableRelation = Vendor;
            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                if not vendor.Get(Rec."Vendor/Subcontractor ID") then
                    Error('Vendor/Subcontractor with ID %1 does not exist.', Rec."Vendor/Subcontractor ID")
                else begin
                    Rec."Vendor/Subcontractor Name" := vendor.Name;
                    Rec."Vendor Contact" := vendor."Phone No.";
                    Rec."Vendor Email" := vendor."E-Mail";
                end;
            end;
        }
        field(53758; "Vendor/Subcontractor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor/Subcontractor Name';
        }
        field(53759; "Vendor Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Contact';
        }
        field(53760; "Contract ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
            TableRelation = "Vendor Contract";

            trigger OnValidate()
            var
                vendor: Record "Vendor Contract";
            begin
                if not vendor.Get(Rec."Contract ID") then
                    Error('Contract with ID %1 does not exist.', Rec."Contract ID")
                else begin
                    Rec."Contract Date" := vendor."Contract Date";
                    Rec."Payment Method" := vendor."Payment Terms";
                    // Rec."Vendor Contact" := vendor.contr;
                    // Rec."Vendor Email" := vendor."E-Mail";
                end;
            end;
            //TODO: Add TableRelation (after Vendor Contract table is created)
        }
        field(53761; "Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Date';
        }
        field(53762; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Type';
            OptionMembers = "Residential","Commercial";
        }
        field(53763; "Contract Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            OptionMembers = Draft,Active,Inactive,Approved,Rejected,"Pending Approval",Suspended,;
        }
        field(53764; "Contract Template"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Template';
        }
        field(53765; "Contract File"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract File';
            InitValue = 'Upload File';
        }
        field(53766; "Contract Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Notes';
        }
        field(53767; "Total Contract Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Contract Amount';
        }
        field(53768; "Payment Schedule"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Schedule';
        }
        field(53769; "Payment Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Method';
        }
        field(53770; "Work Scope"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Scope';
        }
        field(53771; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(53772; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(53773; "Reviewed By"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Reviewed By';
        }
        field(53774; "Approved By"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved By';
        }
        field(53775; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Date';
        }
        field(53776; "Vendor Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Email';
        }

        field(53777; "Remark On Rejection"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remark On Rejection';
        }
        field(53778; "Delivery Schedule"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53779; "Work SPecifications"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53780; "Penalty Clauses"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53781; Incoterms; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Incoterms.Name;
        }
        field(53782; "UAE Regulatory Requirements"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "UAE Regulatory Requirements".Name;
        }
        field(53783; "Industry Standards"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Industry Standards".Name;
        }
        field(53784; "Warranty Period"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53785; "Governing Law & Dispute Rsln."; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = GoverningLawDisputeResolution.Name;
        }
    }

    keys
    {
        key(PK; "Assignment ID")
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
            Rec."Assignment ID" := noseries.GetNextNo(noSeriesSetup."Vendor Assignment Nos.");
        end else
            Error('No. Series Setup not found for Vendor Assignment Nos.');
    end;
}