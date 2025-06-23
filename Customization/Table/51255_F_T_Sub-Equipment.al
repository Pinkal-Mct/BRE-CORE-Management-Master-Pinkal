table 51255 "Sub-Equipment"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50100; "Sub-Equipment ID"; Code[20])
        {
            Caption = 'Sub-Equipment ID';
            DataClassification = ToBeClassified;
        }
        field(50101; "Sub-Equipment Name"; Text[100])
        {
            Caption = 'Sub-Equipment Name';
            DataClassification = ToBeClassified;
        }
        field(50102; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(50103; "Critical Component"; Boolean)
        {
            Caption = 'Critical Component';
            DataClassification = ToBeClassified;
        }
        field(50104; "Maintenance Frequency"; Text[50])
        {
            Caption = 'Maintenance Frequency';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Sub-Equipment ID", "Sub-Equipment Name")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
    begin
        if ("Sub-Equipment ID" = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('SUBEQID', 0D, true); // Use the number series code you created
            "Sub-Equipment ID" := NewNo;
        end;
    end;
}
