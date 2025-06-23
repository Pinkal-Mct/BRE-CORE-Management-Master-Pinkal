table 51252 "OEM Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "OEM ID"; Code[20])
        {
            Caption = 'OEM ID';
            DataClassification = ToBeClassified;
        }
        field(50101; "OEM Name"; Text[100])
        {
            Caption = 'OEM Name';
            DataClassification = ToBeClassified;
        }

        field(50102; "OEM Description"; Text[250])
        {
            Caption = 'OEM Description';
            DataClassification = ToBeClassified;
        }

        field(50103; "Equipment Category"; Text[50])
        {
            Caption = 'Equipment Category';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Category"."Equipment Type";
        }

        field(50104; "Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
            DataClassification = ToBeClassified;
        }

        field(50105; Email; Text[100])
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

        field(50106; Phone; Text[30])
        {
            Caption = 'Phone';
            ExtendedDatatype = PhoneNo;
            DataClassification = ToBeClassified;
        }

        field(50107; Website; Text[100])
        {
            Caption = 'Website';
            ExtendedDatatype = URL;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "OEM ID", "Equipment Category")
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
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
    begin
        if ("OEM ID" = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('OEMID', 0D, true); // Use the number series code you created
            "OEM ID" := NewNo;
        end;
    end;
}