table 53108 "Project BoQ Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "BoQID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50101; "Project Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Id';
            TableRelation = "Construction Project"."Project ID" where("Approval Status" = CONST(Approved));

            trigger OnValidate()
            var
                constructionProject: Record "Construction Project";
            begin
                constructionProject.SetRange("Project ID", Rec."Project Id");
                if constructionProject.FindFirst() then
                    Rec."Project Name" := constructionProject."Project Name"
                else
                    Error('Project with ID %1 does not exist.', Rec."Project Id");
            end;
        }
        field(50102; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
    }

    keys
    {
        key(PK; "BoQID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."BoQID" := noseries.GetNextNo(noSeriesSetup."Project Budget ID Nos.")
        else
            Error('No. Series Setup not found for Vendor Proposal Nos.');
    end;
}