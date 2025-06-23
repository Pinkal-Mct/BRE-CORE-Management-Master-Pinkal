table 51251 "Equipment Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Equipment ID"; Code[20])
        {
            Caption = 'Equipment ID';
            DataClassification = ToBeClassified;
        }
        field(50101; "Equipment Name"; Text[100])
        {
            Caption = 'Equipment Name';
            DataClassification = ToBeClassified;
        }
        field(50102; "Equipment Description"; Text[250])
        {
            Caption = 'Equipment Description';
            DataClassification = ToBeClassified;
        }
        field(50108; "Sub Equipment"; Text[100])
        {
            Caption = 'Sub Equipment';
            DataClassification = ToBeClassified;
            TableRelation = "Sub-Equipment"."Sub-Equipment Name";
        }
        field(50103; "OEM ID"; Text[100])
        {
            Caption = 'OEM ID';
            DataClassification = ToBeClassified;
            TableRelation = "OEM Master"."OEM ID";

            trigger OnValidate()
            var
                OEMMaster: Record "OEM Master";
            begin
                OEMMaster.SetRange("OEM ID", "OEM ID");
                if OEMMaster.FindFirst() then begin
                    "OEM Name" := OEMMaster."OEM Name";
                    "Equipment Category" := OEMMaster."Equipment Category";
                end else begin
                    "Equipment Category" := '';
                    "OEM Name" := '';
                end;
                ;
            end;
        }
        field(50104; "OEM Name"; Text[100])
        {
            Caption = 'OEM Name';
            DataClassification = ToBeClassified;
            TableRelation = "OEM Master"."OEM Name";
        }
        field(50105; "Equipment Category"; Code[20])
        {
            Caption = 'Equipment Category';
            DataClassification = ToBeClassified;
            TableRelation = "OEM Master"."Equipment Category";
        }
        field(50106; "Unit of Measurement"; Integer)
        {
            Caption = 'Unit of Measurement';
            DataClassification = ToBeClassified;
            tableRelation = "Unit of Measure"."Code";
        }
        field(50107; "Default Warranty Period"; Integer)
        {
            Caption = 'Default Warranty Period (Months)';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Equipment Name")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
    begin
        if ("Equipment ID" = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('EQUID', 0D, true); // Use the number series code you created
            "Equipment ID" := NewNo;
        end;
    end;
}