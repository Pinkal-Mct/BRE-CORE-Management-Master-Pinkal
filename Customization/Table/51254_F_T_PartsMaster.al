table 51254 "Parts Master"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Part ID";

    fields
    {
        field(51251; "Part ID"; Code[20])
        {
            Caption = 'Part ID';
            DataClassification = ToBeClassified;
        }
        field(51252; "Part Name"; Text[100])
        {
            Caption = 'Part Name';
            DataClassification = ToBeClassified;
        }
        field(51253; "Part Type"; Enum "Part Type Enum")
        {
            Caption = 'Part Type';
            DataClassification = ToBeClassified;
        }
        field(51254; "Part Description"; Text[250])
        {
            Caption = 'Part Description';
            DataClassification = ToBeClassified;
        }
        field(51255; "Parts Group"; Text[100])
        {
            Caption = 'Parts Group';
            DataClassification = ToBeClassified;
        }
        field(51256; "Equipment Description"; Text[100])
        {
            Caption = 'Equipment Description';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."Equipment Name";
        }
        field(51257; "Unit Price"; Integer)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(51258; "VAT %"; Integer)
        {
            Caption = 'VAT %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
        }
        field(51259; "Opening Quantity"; Integer)
        {
            Caption = 'Opening Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(51260; "Store Description"; Text[100])
        {
            Caption = 'Store Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Part ID")
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
            Rec."Part ID" := noseries.GetNextNo(noSeriesSetup."Part ID Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;
}