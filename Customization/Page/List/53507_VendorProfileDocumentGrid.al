page 53507 "Vendor Profile Document Grid"
{
    PageType = ListPart;
    SourceTable = "Vendor Profile Document Grid";
    Caption = 'Vendor Profile Document Grid';
    // ApplicationArea = All;
    // UsageCategory = Lists;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                }
                field("Profile ID"; Rec."Profile ID")
                {
                    ApplicationArea = All;
                    Caption = 'Profile ID';
                }
                field("Vendor Document Name"; Rec."Vendor Document Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Document Name';
                    TableRelation = "Vendor Documents"."Vendor Document Name";
                }
                field("Upload Document"; Rec."Upload Document")
                {
                    ApplicationArea = All;
                    Caption = 'Upload Document';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        folderName: Text;
                        uploadResult: Text;
                    begin
                        folderName := 'ConstructionContracts';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Upload Document" := fileName;
                            Rec."Document URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }
                field("View & Download"; Rec."View & Download")
                {
                    ApplicationArea = All;
                    Caption = 'View & Download';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        // Check if the file URL is not empty
                        if Rec."Document URL" = '' then
                            Error('No document is available to view.')
                        else
                            Hyperlink(Rec."Document URL");
                    end;
                }
                field("Document URL"; Rec."Document URL")
                {
                    ApplicationArea = All;
                    Caption = 'Document URL';
                    Editable = false;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Profile ID" := profileid;
    end;

    var
        profileid: Code[20];

    procedure SetProfileID(pProfileID: Code[20])
    begin
        profileid := pProfileID;
    end;
}