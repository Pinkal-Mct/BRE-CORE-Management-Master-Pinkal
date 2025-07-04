table 51503 "Service Sub-Type Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51501; "Service type ID"; Code[20])
        {
            TableRelation = "Service Type Master"."Service Type ID";
            NotBlank = true;
        }
        field(51502; "Service Sub-Type ID"; Code[20])
        {
            // NotBlank = true;
            Editable = false;
        }
        field(51503; "Service Sub-Type Name"; text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(51504; "Description"; text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51505; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51506; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51507; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "Service type ID", "Service Sub-Type ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."Service Sub-Type ID" := noseries.GetNextNo(noSeriesSetup."Service Sub-Type ID Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');
        Rec."Created DateTime" := CurrentDateTime();
        Rec."Created By" := UserId();
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