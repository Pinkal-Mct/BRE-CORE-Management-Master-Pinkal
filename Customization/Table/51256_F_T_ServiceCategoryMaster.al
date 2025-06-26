table 51256 "Service Category Master"
{
    DataClassification = ToBeClassified;
    Caption = 'FM Service Category Master';
    DataCaptionFields = "Service Category ID";

    fields
    {
        field(51251; "Service Category ID"; Code[20])
        {
            Caption = 'Service Category ID';
            DataClassification = ToBeClassified;
        }
        field(51252; "Service Category Name"; Text[100])
        {
            Caption = 'Service Category Name';
            DataClassification = ToBeClassified;
        }
        field(51253; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(51254; "SLA Days"; Integer)
        {
            Caption = 'SLA Days';
            MinValue = 0;
            DataClassification = ToBeClassified;
        }
        field(51255; "Priority Level"; Enum "Service Priority Level")
        {
            Caption = 'Priority Level';
            DataClassification = ToBeClassified;
        }
        field(51256; "Service Type"; Text[100])
        {
            Caption = 'Service Type';
            DataClassification = ToBeClassified;
        }
        field(51257; "Default Price"; Decimal)
        {
            Caption = 'Default Price';
            MinValue = 0;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Service Category ID")
        {
            Clustered = true;
        }
        key(Name; "Service Category Name")
        {
        }
        key(Priority; "Priority Level")
        {
        }
    }
    trigger OnInsert()
    var
        NoSeriesManagement: Codeunit "No. Series";
        NewNo: Code[20];
    begin
        if ("Service Category ID" = '') then begin
            NewNo := NoSeriesManagement.GetNextNo('SERCAID', 0D, true); // Use the number series code you created
            "Service Category ID" := NewNo;
        end;
    end;
}