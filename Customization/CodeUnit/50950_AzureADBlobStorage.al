codeunit 50950 "Azure AD Blob Storage"
{

    procedure ValidateDocument(var pUploadResult: Text; pFolderName: Text): Text
    var
        inStream: InStream;
        fileName: Text;
        sasUrlBase: Text;
        sasUrlWithFileName: Text;
        uploadResult: Text;
        tempBlob: Codeunit "Temp Blob";
        validFormats: List of [Text];
        fileExtension: Text[10];
        fileSize: Decimal;
        azureConfig: Record AzureConfiguration;
        azureBlobUploaderNew: Codeunit "Azure AD Blob Storage";
    begin
        // Validate and retrieve the SAS URL from the configuration table
        if not azureConfig.FindFirst() then
            Error('Azure configuration is missing. Please set up the SAS URL in the Azure Configuration table.');

        validFormats.Add('.pdf');
        validFormats.Add('.docx');
        validFormats.Add('.jpg');
        validFormats.Add('.jpeg');

        // Load the file to be uploaded into an InStream
        if UploadIntoStream('Select a Document', '', '(*.pdf, *.docx,*.jpeg, *.jpg)|*.pdf;*.docx;*.jpeg;*.jpg', fileName, inStream) then begin

            fileExtension := LowerCase(CopyStr(fileName, StrPos(fileName, '.'), StrLen(fileName) - StrPos(fileName, '.') + 1));
            if not validFormats.Contains(fileExtension) then
                Error('Unsupported file format. Please upload PDF, DOCX, JPEG or JPG.');

            fileSize := inStream.Length / 1024 / 1024; // Convert to MB
            if fileSize > 5 then
                Error('File is too large. Maximum size allowed is 5MB.');

            // Call the upload to blob function
            pUploadResult := UploadDocumentToBlob(inStream, fileName, pFolderName);

            // Message('Document uploaded successfully: %1', fileName);
            exit(fileName);
        end else
            Message('No document was selected to upload.');
    end;

    procedure UploadDocumentToBlob(var InStream: InStream; FileName: Text; FolderName: Text): Text
    var
        AccessToken: Text;
        BlobUrl: Text;
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        HttpHeaders: HttpHeaders;
        Content: HttpContent;
        Response: HttpResponseMessage;
        StorageAccount: Text;
        ContainerName: Text;
        ResponseText: Text;
        ConfigRecord: Record "AzureConfiguration";
        ContentType: Text;
        FullBlobPath: Text;
        EmptyContent: HttpContent;
        BlobContainerUrl: Text;
    begin
        // Get configuration
        // if not ConfigRecord.FindFirst() then
        //     Error('Azure configuration is missing. Please set up the configuration.');

        // Get storage account from configuration
        StorageAccount := ConfigRecord."Storage Account Name";

        // Get container name from configuration
        ContainerName := ConfigRecord."Default Container";

        // Check for required values
        if StorageAccount = '' then
            Error('Storage Account Name is missing in Azure configuration.');

        if ContainerName = '' then
            Error('Container name cannot be empty.');

        if FileName = '' then
            Error('File name cannot be empty.');

        // Get OAuth token with proper audience
        AccessToken := GetAzureADToken();
        if AccessToken = '' then
            Error('Failed to obtain Azure AD token.');

        // Process folder path if provided
        if FolderName <> '' then begin
            // Ensure folder name ends with a slash
            if not FolderName.EndsWith('/') then
                FolderName := FolderName + '/';

            // Construct the blob container URL
            BlobContainerUrl := StrSubstNo('https://%1.blob.core.windows.net/%2',
                                    StorageAccount,
                                    ContainerName);

            // Check if folder exists by trying to list blobs with the folder prefix
            if not CheckFolderExists(BlobContainerUrl, FolderName) then begin
                // Folder doesn't exist, create it
                Message('Folder does not exist, creating: %1', FolderName);

                // Create a folder marker (empty blob with folder name ending in /)
                HttpRequest.Method := 'PUT';
                HttpRequest.SetRequestUri(StrSubstNo('https://%1.blob.core.windows.net/%2/%3_$folder$',
                                        StorageAccount,
                                        ContainerName,
                                        FolderName.TrimEnd('/'))); // Remove trailing slash for marker

                HttpRequest.GetHeaders(HttpHeaders);
                HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
                HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
                HttpHeaders.Add('x-ms-version', '2020-08-04');
                HttpHeaders.Add('x-ms-date', GetRFC1123FormattedDateTime());

                // Set up empty content for folder marker
                EmptyContent.WriteFrom('');
                HttpRequest.Content(EmptyContent);

                // Send the request to create folder marker
                if HttpClient.Send(HttpRequest, Response) then begin
                    if not Response.IsSuccessStatusCode() then begin
                        Response.Content().ReadAs(ResponseText);
                        Message('Warning: Failed to create folder marker. Status: %1. Response: %2',
                               Response.HttpStatusCode(), ResponseText);
                        // Continue anyway as we'll try to upload the blob
                    end;
                end;

                // Clear objects for the actual upload
                Clear(HttpClient);
                Clear(HttpRequest);
                Clear(Response);
                Clear(HttpHeaders);
            end;

            // Construct the full blob path including folder
            FullBlobPath := FolderName + FileName;
        end else
            FullBlobPath := FileName;

        // Construct the Blob URL - FIXED: Now using FullBlobPath instead of just FileName
        BlobUrl := StrSubstNo('https://%1.blob.core.windows.net/%2/%3',
                             StorageAccount,
                             ContainerName,
                             FullBlobPath);

        Message('Uploading to URL: %1', BlobUrl);

        // Create new HTTP request
        HttpRequest.Method := 'PUT';
        HttpRequest.SetRequestUri(BlobUrl);
        HttpRequest.GetHeaders(HttpHeaders);

        // Set auth header - Make sure there's no extra space in "Bearer "
        HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);

        // Add required Azure Blob Storage headers
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('x-ms-version', '2020-08-04');
        HttpHeaders.Add('x-ms-date', GetRFC1123FormattedDateTime());

        // ADDED: Determine content type
        ContentType := GetMimeTypeFromFileName(FileName);

        // ADDED: Set content disposition for browser handling
        HttpHeaders.Add('x-ms-blob-content-disposition', StrSubstNo('inline; filename="%1"', FileName));

        // ADDED: Set the content type as a blob property
        HttpHeaders.Add('x-ms-blob-content-type', ContentType);

        // ADDED: Cache control for better browser caching
        HttpHeaders.Add('x-ms-blob-cache-control', 'public, max-age=86400');

        // Prepare content
        Content.WriteFrom(InStream);
        HttpRequest.Content(Content);

        // Set content type based on file extension
        Content.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', ContentType);

        // Send the request
        if HttpClient.Send(HttpRequest, Response) then begin
            if Response.IsSuccessStatusCode() then begin
                // Generate a URL that can be used to access the file - FIXED: Return URL with folder path
                exit(StrSubstNo('https://%1.blob.core.windows.net/%2/%3',
                                StorageAccount,
                                ContainerName,
                                FullBlobPath));
            end else begin
                Response.Content().ReadAs(ResponseText);
                Error('Failed to upload file. Status: %1. Response: %2',
                      Response.HttpStatusCode(), ResponseText);
            end;
        end else
            Error('Failed to send HTTP request.');
    end;
    // Helper procedure to check if a folder exists
    procedure CheckFolderExists(BlobContainerUrl: Text; FolderPrefix: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpRequest: HttpRequestMessage;
        Response: HttpResponseMessage;
        ResponseText: Text;
        ListBlobsUrl: Text;
    begin
        // Format URL to list blobs with the folder prefix
        // We'll use the Azure Storage REST API ?prefix parameter
        ListBlobsUrl := StrSubstNo('%1?prefix=%2&restype=container&comp=list&maxresults=1',
                                  BlobContainerUrl, FolderPrefix);

        HttpRequest.Method := 'GET';
        HttpRequest.SetRequestUri(ListBlobsUrl);

        if HttpClient.Send(HttpRequest, Response) then begin
            if Response.IsSuccessStatusCode() then begin
                Response.Content().ReadAs(ResponseText);
                // If the response contains EnumerationResults/Blobs/Blob, then blobs exist with this prefix
                exit(ResponseText.Contains('Blob>') or ResponseText.Contains('<Blob'));
            end;
        end;

        exit(false);
    end;

    // NEW PROCEDURE: Get Formatted DateTime
    procedure GetRFC1123FormattedDateTime(): Text
    var
        CurrentDT: DateTime;
        DayOfWeekInt: Integer;
        DayOfWeek: Text;
        Day: Integer;
        Month: Integer;
        MonthName: Text;
        Year: Integer;
        Hour: Integer;
        Minute: Integer;
        Second: Integer;
        TempDate: Date;
        TempTime: Time;
        DayNames: array[7] of Text;
        MonthNames: array[12] of Text;
    begin
        // Initialize day names (1=Monday in Business Central)
        DayNames[1] := 'Mon';
        DayNames[2] := 'Tue';
        DayNames[3] := 'Wed';
        DayNames[4] := 'Thu';
        DayNames[5] := 'Fri';
        DayNames[6] := 'Sat';
        DayNames[7] := 'Sun';

        // Initialize month names
        MonthNames[1] := 'Jan';
        MonthNames[2] := 'Feb';
        MonthNames[3] := 'Mar';
        MonthNames[4] := 'Apr';
        MonthNames[5] := 'May';
        MonthNames[6] := 'Jun';
        MonthNames[7] := 'Jul';
        MonthNames[8] := 'Aug';
        MonthNames[9] := 'Sep';
        MonthNames[10] := 'Oct';
        MonthNames[11] := 'Nov';
        MonthNames[12] := 'Dec';

        // Get current UTC date and time
        CurrentDT := CurrentDateTime();
        TempDate := DT2Date(CurrentDT);
        TempTime := DT2Time(CurrentDT);

        // Extract date components
        Day := Date2DMY(TempDate, 1);
        Month := Date2DMY(TempDate, 2);
        Year := Date2DMY(TempDate, 3);
        DayOfWeekInt := Date2DWY(TempDate, 1); // 1=Monday, 7=Sunday

        // Determine day name
        DayOfWeek := DayNames[DayOfWeekInt];
        MonthName := MonthNames[Month];

        // Extract time components
        Evaluate(Hour, Format(TempTime, 0, '<Hours24,2>'));
        Evaluate(Minute, Format(TempTime, 0, '<Minutes,2>'));
        Evaluate(Second, Format(TempTime, 0, '<Seconds,2>'));

        // Format according to RFC 1123: "Wed, 01 May 2025 11:13:10 GMT"
        exit(StrSubstNo('%1, %2 %3 %4 %5:%6:%7 GMT',
                        DayOfWeek,
                        Format(Day, 0, '<Integer,2>'),
                        MonthName,
                        Format(Year),
                        Format(Hour, 0, '<Integer,2>'),
                        Format(Minute, 0, '<Integer,2>'),
                        Format(Second, 0, '<Integer,2>')));
    end;

    //NEW PROCEDURE: Get Azure AD Token
    local procedure GetAzureADToken(): Text
    var
        HttpClient: HttpClient;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        RequestBody: Text;
        ResponseText: Text;
        JsonToken: JsonToken;
        JsonObject: JsonObject;
        ConfigRecord: Record "AzureConfiguration";
        TokenEndpoint: Text;
    begin
        // Get configuration
        if not ConfigRecord.FindFirst() then
            Error('Azure configuration is missing. Please set up the configuration.');

        // Build token endpoint URL
        TokenEndpoint := StrSubstNo('https://login.microsoftonline.com/%1/oauth2/v2.0/token', ConfigRecord."Tenant ID");

        // CRITICAL FIX: Use the correct resource identifier for Azure Storage
        // The audience must be exactly "https://storage.azure.com" for Azure Blob Storage

        // Build token request with the proper resource identifier
        RequestBody := StrSubstNo('grant_type=client_credentials&client_id=%1&client_secret=%2&scope=%3',
                                 ConfigRecord."Client ID",
                                 ConfigRecord."Client Secret",
                                 'https://storage.azure.com/.default');

        // Log request information for debugging
        Message('Token request URL: %1', TokenEndpoint);
        Message('Using scope: https://storage.azure.com/.default');

        // Create request content
        RequestContent.WriteFrom(RequestBody);
        RequestContent.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/x-www-form-urlencoded');

        // Make token request
        if not HttpClient.Post(TokenEndpoint, RequestContent, ResponseMessage) then
            Error('Failed to send token request.');

        // Process response
        if not ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(ResponseText);
            Error('Token request failed. Status: %1. Response: %2',
                  ResponseMessage.HttpStatusCode(), ResponseText);
        end;

        // Parse response to get token
        ResponseMessage.Content().ReadAs(ResponseText);
        if not JsonObject.ReadFrom(ResponseText) then
            Error('Failed to parse token response.');

        if not JsonObject.Get('access_token', JsonToken) then
            Error('No access token in response.');

        exit(JsonToken.AsValue().AsText());
    end;

    //NEW PROCEDURE: Get MimeType from Filename
    procedure GetMimeTypeFromFileName(FileName: Text): Text
    var
        FileExtension: Text;
        ExtensionPos: Integer;
    begin
        // Extract the file extension from the file name
        ExtensionPos := StrPos(FileName, '.');
        if ExtensionPos > 0 then begin
            FileExtension := LowerCase(CopyStr(FileName, ExtensionPos));
        end
        else
            FileExtension := '';

        case FileExtension of
            '.pdf':
                exit('application/pdf');
            '.jpg', '.jpeg':
                exit('image/jpeg');
            '.png':
                exit('image/png');
            '.gif':
                exit('image/gif');
            '.txt':
                exit('text/plain');
            '.doc':
                exit('application/msword');
            '.docx':
                exit('application/vnd.openxmlformats-officedocument.wordprocessingml.document');
            '.xls':
                exit('application/vnd.ms-excel');
            '.xlsx':
                exit('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            '.ppt':
                exit('application/vnd.ms-powerpoint');
            '.pptx':
                exit('application/vnd.openxmlformats-officedocument.presentationml.presentation');
            '.zip':
                exit('application/zip');
            '.rar':
                exit('application/x-rar-compressed');
            '.csv':
                exit('text/csv');
            '.json':
                exit('application/json');
            '.xml':
                exit('application/xml');
            '.html', '.htm':
                exit('text/html');
            else
                exit('application/octet-stream'); // Default MIME type for unknown files
        end;
    end;
}