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
            TableRelation = "Construction Project"."Project ID" where("Approval Status" = CONST(Approved));


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
                    Rec."Project Location" := constructionProject."Address Line 2";
                end;
            end;
        }
        field(53752; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
            Editable = false;
        }
        field(53753; "Project Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Location';
            Editable = false;
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
            TableRelation = "Vendor Contract"."Contract ID" where("Project ID" = field("Project ID"), "Vendor Approval Status" = CONST(Approved));

            trigger OnValidate()
            var
                vendorContract: Record "Vendor Contract";
            begin
                if not vendorContract.Get(Rec."Contract ID") then
                    Error('Contract with ID %1 does not exist.', Rec."Contract ID")
                else begin
                    Rec."Contract Date" := vendorContract."Contract Date";
                    // Rec."Payment Method" := vendor."Payment Terms";
                    // Rec."Task ID" := vendor."Task ID";
                    // Rec."Task Name" := vendor."Task Name";
                    // Rec."Task Start Date" := vendor."Task Start Date";
                    // Rec."Task End Date" := vendor."Task End Date";
                    // Rec."Task Description" := vendor."Task Description";
                    // Rec.Notes := vendor.Notes;
                    // Rec."Milestone ID" := vendor."Milestone ID";
                    // Rec."Vendor Contact" := vendor.contr;
                    // Rec."Vendor Email" := vendor."E-Mail";
                    Rec."Vendor/Subcontractor ID" := vendorContract."Vendor ID";
                    Rec."Vendor/Subcontractor Name" := vendorContract."Vendor Name";
                    // Rec."Vendor Contact" := vendorContract.;
                    Rec."Vendor Email" := vendorContract."Vendor Email";
                    Rec."Contract Status" := Format(vendorContract."Vendor Approval Status");
                    Rec."Total Contract Amount" := vendorContract."Total Contract Value (AED)";
                    Rec."Warranty Period" := Format(vendorContract."Warranty Period (Months)");
                    Rec."Payment Method" := Format(vendorContract."Payment Method");
                    Rec."UAE Regulatory Requirements" := Format(vendorContract."UAE Compliance Requirements");
                    Rec."Industry Standards" := Format(vendorContract."Industry Standards");
                    Rec."Governing Law & Dispute Rsln." := Format(vendorContract."Dispute Resolution");
                    Rec.Incoterms := Format(vendorContract.Incoterms);
                end;
            end;
            //TODO: Add TableRelation (after Vendor Contract table is created)
        }
        field(53761; "Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Date';
            Editable = false;
        }
        field(53762; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Type';
            OptionMembers = "Residential","Commercial";
        }
        field(53763; "Contract Status"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Status';
            Editable = false;
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
            Editable = false;
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
            Editable = false;
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
            Caption = 'Remark';
        }
        field(53778; "Delivery Schedule"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53779; "Work Specifications"; Text[250])
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
            Editable = false;

        }
        field(53782; "UAE Regulatory Requirements"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(53783; "Industry Standards"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(53784; "Warranty Period"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53785; "Governing Law & Dispute Rsln."; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }

        field(53786; "Task ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task ID';

        }
        field(53787; "Task Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Name';
            // TableRelation = "Project Milestone Task"."Task Name" where("Project ID" = field("Project ID"));
        }
        field(53788; "Task Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Start Date';
        }
        field(53789; "Task End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Task End Date';

        }
        field(53790; "Task Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Description';
        }
        field(53791; Notes; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notes';
        }
        field(53792; "Milestone ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone ID';

        }

        field(53793; "Vendor Assignment Status"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Assignment Status';
            OptionMembers = Draft,Active,Inactive,Approved,Rejected,"Pending Approval",Suspended,;

        }

        field(53794; "Remark"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remark';

        }

        field(53795; "Created By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
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
        rec."Created By" := UserId();
    end;


}