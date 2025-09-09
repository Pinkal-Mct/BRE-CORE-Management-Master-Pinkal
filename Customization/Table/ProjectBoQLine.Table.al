table 53109 "Project BoQ Line"
{
    DataClassification = ToBeClassified;
    Caption = 'BoQ Line';

    fields
    {
        field(50100; "BoQ Line ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Project ID"; Code[20])
        {
            Caption = 'Project ID';
            TableRelation = Job."No.";
            NotBlank = true;

            trigger OnValidate()
            var
                JobRec: Record Job;
            begin
                if not JobRec.Get("Project ID") then
                    Error('Project ID %1 does not exist.', "Project ID");
            end;
        }

        field(50102; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No." WHERE(Blocked = CONST(false));

            trigger OnValidate()
            var
                ItemRec: Record Item;
            begin
                if "Item No." <> '' then
                    if ItemRec.Get("Item No.") then begin
                        Description := ItemRec.Description;
                        "Unit of Measure" := ItemRec."Base Unit of Measure";
                    end;
            end;
        }

        field(50103; Description; Text[100])
        {
            Caption = 'Description';
        }

        field(50104; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure';
        }

        field(50105; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';

            trigger OnValidate()
            begin
                if "Planned Quantity" <= 0 then
                    Error('Planned Quantity must be greater than 0.');

                "Total Cost" := CalcTotalCost();
            end;
        }

        field(50106; "Unit Price (LCY)"; Decimal)
        {
            Caption = 'Unit Price (LCY)';

            trigger OnValidate()
            begin
                if "Unit Price (LCY)" < 0 then
                    Error('Unit Price cannot be negative.');

                "Total Cost" := CalcTotalCost();
            end;
        }

        field(50107; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            //FieldClass = FlowField;
            //CalcFormula = Sum("Planned Quantity" * "Unit Price (LCY)");
            Editable = false;
        }

        field(50108; "Cost Category"; Enum "BoQ Cost Category")
        {
            Caption = 'Cost Category';
        }

        field(50109; "Budget Category"; Code[20])
        {
            Caption = 'Budget Category';
            TableRelation = "Project Budget Category";

            trigger OnValidate()
            begin
                if "Budget Category" = '' then
                    Error('Budget Category is required.');
            end;
        }

        field(50110; "Procured Quantity"; Decimal)
        {
            Caption = 'Procured Quantity';
        }

        field(50111; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            //FieldClass = FlowField;
            //CalcFormula = "Planned Quantity" - "Procured Quantity";
            Editable = false;
            trigger OnValidate()
            begin
                "Remaining Quantity" := CalcRemainingQty();
            end;
        }

        field(50112; "Created By"; Code[50])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(50113; "Created On"; DateTime)
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(50114; "Modified By"; Code[50])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }

        field(50115; "Modified On"; DateTime)
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(50116; "BOQ ID"; Code[20])
        {
            Caption = 'BOQ ID';
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; "BoQ Line ID", "BOQ ID")
        {
            Clustered = true;
        }
    }

    // trigger OnInsert()
    // begin
    //     if "Budget Category" = '' then
    //         Error('Budget Category is required.');

    //     "Created By" := CopyStr(UserId, 1, StrLen(UserId));
    //     "Created On" := CurrentDateTime;
    // end;

    trigger OnModify()
    begin
        // if "Budget Category" = '' then
        //     Error('Budget Category is required.');

        // if CalcRemainingQty() < 0 then
        //     Error('Remaining Quantity cannot be less than 0.');

        "Modified By" := CopyStr(UserId, 1, StrLen(UserId));
        "Modified On" := CurrentDateTime;
    end;

    local procedure CalcRemainingQty(): Decimal
    begin
        exit("Planned Quantity" - "Procured Quantity");
    end;

    local procedure CalcTotalCost(): Decimal
    begin
        exit("Planned Quantity" * "Unit Price (LCY)");
    end;
}