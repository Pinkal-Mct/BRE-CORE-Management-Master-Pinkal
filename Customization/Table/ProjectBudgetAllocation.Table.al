table 51261 "Project Budget Allocation"
{
    Caption = 'Project Budget Allocation';
    DataClassification = ToBeClassified;

    fields
    {
        field(51251; "Project Budget ID"; Code[20])
        {
            Caption = 'Project ID';
            DataClassification = ToBeClassified;
        }

        field(51252; "Budget Category"; Code[50])
        {
            Caption = 'Budget Category';
            DataClassification = ToBeClassified;
            NotBlank = true;
            trigger OnValidate()
            begin
                if "Budget Category" = '' then
                    Error('Budget Category cannot be blank.');
            end;
        }

        field(51253; "Allocated Amount"; Decimal)
        {
            Caption = 'Allocated Amount';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                if "Allocated Amount" < 0 then
                    Error('Allocated Amount must be greater than or equal to 0.');
            end;
        }

        field(51254; "Committed Amount"; Decimal)
        {
            Caption = 'Committed Amount';
            DataClassification = ToBeClassified;
        }

        field(51255; "Consumed Amount"; Decimal)
        {
            Caption = 'Consumed Amount';
            DataClassification = ToBeClassified;
        }

        field(51256; "Remaining Amount"; Decimal)
        {
            Caption = 'Remaining Amount';
            DataClassification = ToBeClassified;
        }

        field(51257; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(51258; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }

        field(51259; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(51260; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
    }

    keys
    {
        key(PK; "Project Budget ID", "Budget Category")
        {
            Clustered = true;
        }
    }

    // trigger OnInsert()
    // var
    //     noSeriesSetup: Record "No. Series Setup";
    //     noseries: Codeunit "No. Series";
    // begin
    //     if noSeriesSetup.Get() then
    //         Rec."Project Budget ID" := noseries.GetNextNo(noSeriesSetup."Project Budget ID Nos.")
    //     else
    //         Error('No. Series Setup not found for Construction Project Nos.');

    //     "Created Date" := Today;
    //     "Created By" := CopyStr(UserId(), 1, StrLen(UserId()));
    // end;

    trigger OnModify()
    begin
        "Modified Date" := Today;
        "Modified By" := CopyStr(UserId(), 1, StrLen(UserId()));
    end;

    trigger OnDelete()
    var
        // Confirm deletion of budget allocation
        ConfirmMsg: Label 'Are you sure you want to delete the budget allocation for Project %1, Category %2?';
    begin
        if not Confirm(ConfirmMsg, false, "Project Budget ID", "Budget Category") then
            Error('');
    end;
}