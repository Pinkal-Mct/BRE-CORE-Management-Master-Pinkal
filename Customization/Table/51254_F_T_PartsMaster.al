table 51254 "Parts Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Part ID"; Code[20])
        {
            Caption = 'Part ID';
            DataClassification = ToBeClassified;
        }
        field(50101; "Part Name"; Text[100])
        {
            Caption = 'Part Name';
            DataClassification = ToBeClassified;
        }
        field(50102; "Part Type"; Enum "Part Type Enum")
        {
            Caption = 'Part Type';
            DataClassification = ToBeClassified;
        }
        field(50103; "Part Description"; Text[250])
        {
            Caption = 'Part Description';
            DataClassification = ToBeClassified;
        }
        field(50104; "Parts Group"; Text[100])
        {
            Caption = 'Parts Group';
            DataClassification = ToBeClassified;
        }
        field(50105; "Equipment Description"; Text[100])
        {
            Caption = 'Equipment Description';
            DataClassification = ToBeClassified;
            TableRelation = "Equipment Master"."Equipment Name";
        }
        field(50106; "Unit Price"; Integer)
        {
            Caption = 'Unit Price';
            DataClassification = ToBeClassified;
        }
        field(50107; "VAT %"; Integer)
        {
            Caption = 'VAT %';
            DataClassification = ToBeClassified;
            MinValue = 0;
            MaxValue = 100;
        }
        field(50108; "Opening Quantity"; Integer)
        {
            Caption = 'Opening Quantity';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(50109; "Store Description"; Text[100])
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
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
    begin
        if ("Part ID" = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('PARTID', 0D, true); // Use the number series code you created
            "Part ID" := NewNo;
        end;
    end;
}