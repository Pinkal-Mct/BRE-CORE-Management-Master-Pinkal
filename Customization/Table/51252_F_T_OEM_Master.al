table 51252 "OEM Master"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "OEM ID";

    fields
    {
        field(51251; "OEM ID"; Code[20])
        {
            Caption = 'OEM ID';
            DataClassification = ToBeClassified;
        }
        field(51252; "OEM Name"; Text[100])
        {
            Caption = 'OEM Name';
            DataClassification = ToBeClassified;
        }

        field(51253; "OEM Description"; Text[250])
        {
            Caption = 'OEM Description';
            DataClassification = ToBeClassified;
        }

        field(51254; "Equipment Category"; Text[50])
        {
            Caption = 'Equipment Category';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Category"."Equipment Type";
        }

        field(51255; "Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
            DataClassification = ToBeClassified;
        }

        field(51256; Email; Text[100])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Email <> '' then
                    if not Email.Contains('@') then
                        Error('Please enter a valid email address.');
            end;
        }

        field(51257; Phone; Text[30])
        {
            Caption = 'Phone';
            ExtendedDatatype = PhoneNo;
            DataClassification = ToBeClassified;
        }

        field(51258; Website; Text[100])
        {
            Caption = 'Website';
            ExtendedDatatype = URL;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "OEM ID", "OEM Name", "Equipment Category")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Primary; "OEM ID", "OEM Name", "Equipment Category")
        {
            Caption = 'Primary';
        }
    }

    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."OEM ID" := noseries.GetNextNo(noSeriesSetup."OEM ID Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;
}