page 53252 "Vendor Document Upload Grid"
{
    PageType = ListPart;
    SourceTable = "Vendor Document Upload";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(UploadGrid)
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
                field("Document Category"; rec."Document Category")
                {
                    ApplicationArea = All;
                }
                field("Document Name"; rec."Document Name")
                {
                    ApplicationArea = All;
                }
                field("Issuing Authority"; Rec."Issuing Authority")
                {
                    ApplicationArea = All;
                }
                field("Upload Document"; Rec."Upload Document")
                {
                    ApplicationArea = All;
                    Caption = 'Upload Document';
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
                field("View/Download"; rec."Document URL")
                {
                    ApplicationArea = All;
                    Caption = 'View/Download';
                    trigger OnDrillDown()
                    begin
                        if rec."Document URL" = '' then
                            Error('No document uploaded.')
                        else
                            Hyperlink(Rec."Document URL");
                    end;
                }
            }
        }
    }

    var
        VendorId: Code[20];

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Vendor ID" := VendorId;
    end;

    procedure SetVendorId(pVendorId: Code[20])
    begin
        VendorId := pVendorId;
    end;
}
