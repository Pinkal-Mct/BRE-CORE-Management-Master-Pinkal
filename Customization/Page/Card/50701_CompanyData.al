page 50701 "Company Data"
{
    PageType = Card;
    SourceTable = "testData";
    ApplicationArea = All;
    Caption = 'Company Data';

    layout
    {
        area(content)
        {
            group("Company Information")
            {
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    Caption = 'Company Name';
                }

                field("Company Logo"; Rec."Company Logo")
                {
                    ApplicationArea = All;
                    Editable = false;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        azureBlobUploader: Codeunit "Azure AD Blob Storage";
                        fileName: Text;
                        uploadResult: Text;
                        folderName: Text;
                    begin

                        folderName := 'CompanyLogos';
                        fileName := azureBlobUploader.ValidateDocument(uploadResult, folderName);
                        if fileName <> '' then begin
                            Rec."Company Logo" := fileName;
                            Rec."Logo URL" := uploadResult;
                            Rec.Modify();
                            Message('File uploaded successfully: %1', fileName);
                        end;
                    end;


                }

                field("Azure Blob URL"; Rec."Logo URL")
                {

                    ApplicationArea = All;
                    Editable = true;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        FileURL: Text;
                    begin
                        // Get the URL of the uploaded document
                        FileURL := Rec."View Document URL";

                        // Check if the file URL is not empty
                        if FileURL = '' then
                            Error('No document is available to view.');

                        // Open the file URL in the browser (new tab)
                        OpenFileInBrowser(FileURL);
                    end;
                }

                field("Tenant id"; Rec."Tenant id")
                {
                    ApplicationArea = All;
                    Caption = 'Tenant Id';
                }
                field("Environment Name"; Rec."Environment Name")
                {
                    ApplicationArea = All;
                    Caption = 'Environment Name';
                }
                field("API URL"; Rec."API URL")
                {
                    ApplicationArea = All;
                    Caption = 'API URL';
                    ToolTip = 'This is the API URL of portal';
                }
                field("Revenue Methods"; Rec."Revenue Methods")
                {
                    ApplicationArea = All;
                    Caption = 'Revenue Methods';
                }
            }

            group("WorkflowFrequency")
            {
                part("Workflow Frequency"; "Workflow Frequency Card")
                {
                    SubPageLink = "Company ID" = FIELD("Company ID"); // Link to filter attachments for this owner only
                    ApplicationArea = All;
                    // Visible = isVisible;
                }



            }
            field("Access Validity"; Rec."Access Validity")
            {
                ApplicationArea = All;
                Caption = 'Access Validity (Days)';
            }
        }
    }
    procedure OpenFileInBrowser(URL: Text)
    begin
        // Use the Hyperlink method to open the file in the browser
        if URL <> '' then
            Hyperlink(URL)
        else
            Error('The file URL is invalid.');
    end;



    trigger OnNewRecord(BelowxRec: Boolean)
    var
        CompanyInfo: Record "Company Information";
    begin
        if CompanyInfo.Get() then
            Rec."Company Name" := CompanyInfo.Name;
    end;
}
