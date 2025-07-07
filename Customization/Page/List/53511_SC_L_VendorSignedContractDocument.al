page 53511 "Vendor Signed ContractDocument"
{
    PageType = ListPart;
    SourceTable = vendorSignedContractDocument;
    Caption = 'Vendor Signed Contract Document';
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document ID"; Rec."Document ID")
                {
                    ApplicationArea = All;
                    Caption = 'Document ID';
                }
                field("Vendor Profile ID"; Rec."Vendor Profile ID")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Profile ID';
                    Editable = false;
                }

                field("Contract ID"; Rec."Contract ID")
                {
                    ApplicationArea = All;
                    Caption = 'Contract ID';
                    TableRelation = "Vendor Contract"."Contract ID" where("Vendor ID" = field("Vendor Profile ID"));

                    trigger OnValidate()
                    var
                        vendorContract: Record "Vendor Contract";

                    begin
                        vendorContract.SetRange("Contract ID", Rec."Contract ID");
                        if vendorContract.FindFirst() then begin
                            Rec."Project ID" := vendorContract."Project ID";
                            Rec."Project Name" := vendorContract."Project Name";
                            Rec."Service Provided" := vendorContract."Service Type";
                            // Rec.Milestone := vendorContract."Milestone ID";
                            // Rec."Task ID" := vendorContract."Task ID";

                        end else
                            Error('No contract found for the selected Contract ID.');
                    end;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                    Caption = 'Project Name';
                    Editable = false;
                }
                field(Milestone; Rec.Milestone)
                {
                    ApplicationArea = All;
                    Caption = 'Milestone Details';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        projectMilestoneTask: Record "Project Milestone Task";
                        projectMilestoneTaskPage: Page "Project Milestone Tasks";
                    begin
                        projectMilestoneTask.SetRange("Project ID", Rec."Project ID");
                        projectMilestoneTask.SetRange("Contract ID", Rec."Contract ID");

                        projectMilestoneTaskPage.SetTableView(projectMilestoneTask);
                        projectMilestoneTaskPage.RunModal();
                    end;
                }
                field("Service Provided"; Rec."Service Provided")
                {
                    ApplicationArea = All;
                    Caption = 'Service Provided';
                    Editable = false;
                }
                field("Signed Upload Document"; Rec."Signed Upload Document")
                {
                    ApplicationArea = All;
                    Caption = 'Signed Upload Document';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        folderName: Text;
                        uploadResult: Text;
                    begin
                        folderName := 'VendorSignedContractDocuments';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Signed Upload Document" := fileName;
                            Rec."Document URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;
                }
                field("View/Download"; Rec."View/Download")
                {
                    ApplicationArea = All;
                    Caption = 'View/Download';
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
        Rec."Vendor Profile ID" := profileid;
    end;

    var
        profileid: Code[20];

    procedure SetProfileID(pProfileID: Code[20])
    begin
        profileid := pProfileID;
    end;
}