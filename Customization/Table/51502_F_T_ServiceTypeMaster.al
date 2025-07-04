table 51502 "Service Type Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(51501; "Service Type ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            // NotBlank = true;
        }

        field(51502; "Service Type Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51503; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51504; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51505; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(51506; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Service Type ID")
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
            Rec."Service Type ID" := noseries.GetNextNo(noSeriesSetup."Service Type ID Nos.");
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