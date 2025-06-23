table 51253 "Equipment Category"
{
    Caption = 'Equipment Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(3; "Equipment Type"; Text[50])
        {
            Caption = 'Equipment Type';
            DataClassification = ToBeClassified;
        }

        field(10; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; ID, "Equipment Type")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
    begin
        if (ID = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('EQCAID', 0D, true); // Use the number series code you created
            ID := NewNo;
        end;
    end;
}