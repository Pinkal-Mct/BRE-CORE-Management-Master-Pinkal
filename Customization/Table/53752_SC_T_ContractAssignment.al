table 53752 "Contract Assignment"
{
    DataClassification = ToBeClassified;
    Caption = 'Contract Assignment';
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
                    Rec."Project Location" := constructionProject."Project Location";
                    Rec."Project Scope" := constructionProject."Project Scope";
                    Rec."Project Start Date" := constructionProject."Project Start Date";
                    Rec."Project End Date" := constructionProject."Project End Date";
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
            OptionMembers = " ",Active,Inactive;
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
            Rec."Assignment ID" := noseries.GetNextNo(noSeriesSetup."Contract Assignment Nos.");
        end else
            Error('No. Series Setup not found for Contract Assignment Nos.');
    end;
}