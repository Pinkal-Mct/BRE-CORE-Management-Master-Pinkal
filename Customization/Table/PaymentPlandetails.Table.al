table 52010 Paymentplandetails
{
    DataClassification = ToBeClassified;


    fields
    {
        field(52000; "Plan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan No';
            Editable = false;
        }
        field(52001; "Plan Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan Name';
        }
        field(52002; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(52003; "Status"; Option)
        {
            OptionMembers = " ","Activated","Deactivated";
            Caption = 'Status';
        }
        field(52004; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(52005; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';
        }
        field(52006; "Down Payment Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Down Payment Percentage';
        }
        field(52007; "Property No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property No.';
            TableRelation = "Property Registration"."Property ID";
            trigger OnValidate()
            var
                PropertyRegister: Record "Property Registration";
            begin
                PropertyRegister.SetRange("Property Id", Rec."Property No.");
                if PropertyRegister.FindFirst() then begin
                    "Property No." := PropertyRegister."Property Id";
                    "Property Name" := PropertyRegister."Property Name";
                end else
                    "Property No." := '';
                "Property Name" := ''
            end;

        }
        field(52008; "Property Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property Name';
            Editable = false;
        }
        field(52009; "Project No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project No.';
            TableRelation = "Construction Project"."Project ID";

            trigger OnValidate()
            var
                ConstructionProject: Record "Construction Project";
            begin
                ConstructionProject.SetRange("Project Id", Rec."Project No.");
                if ConstructionProject.FindFirst() then begin
                    "Project No." := ConstructionProject."Project Id";
                    "Project Name" := ConstructionProject."Project Name";
                end else
                    "Project No." := '';
                "Project Name" := ''
            end;
        }
        field(52010; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
            Editable = false;
        }
        field(52011; "Unit Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Unit Type';
            TableRelation = "Secondary Classification"."Property Type";
        }
        field(52012; "Default"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Default';


            trigger OnValidate()
            var
                OtherPlans: Record Paymentplandetails;
            begin
                if "Default" then begin
                    OtherPlans.Reset();
                    OtherPlans.SetRange("Default", true);

                    if OtherPlans.FindSet() then
                        repeat
                            // 🔹 Only proceed if other record has same Property or same Project
                            // 🔹 And make sure not to modify current record
                            if (OtherPlans."Plan No" <> "Plan No") then
                                if (("Property No." <> '') and (OtherPlans."Property No." = "Property No.")) or
                                   (("Project No." <> '') and (OtherPlans."Project No." = "Project No.")) then begin
                                    OtherPlans."Default" := false;
                                    OtherPlans.Modify();
                                end;
                        until OtherPlans.Next() = 0;
                end;
            end;
        }
        field(52013; "Property URL"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Property URL';
        }
    }

    keys
    {
        key(PK; "Plan No")
        {
            Clustered = true;
        }
    }
}