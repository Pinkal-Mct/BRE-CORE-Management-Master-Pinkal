codeunit 50950 "Azure AD Blob Storage"
{
    procedure ValidateDocument(var pUploadResult: Text; pFolderName: Text): Text
    var
        inStream: InStream;
        fileName: Text;
        validFormats: List of [Text];
        fileExtension: Text[10];
        fileSize: Decimal;
        azureConfig: Record AzureConfiguration;
    begin
        if not azureConfig.FindFirst() then
            Error('Azure configuration is missing. Please set up the configuration.');

        validFormats.Add('.pdf');
        validFormats.Add('.docx');
        validFormats.Add('.jpg');
        validFormats.Add('.jpeg');

        if UploadIntoStream('Select a Document', '', '(*.pdf, *.docx,*.jpeg, *.jpg)|*.pdf;*.docx;*.jpeg;*.jpg', fileName, inStream) then begin
            fileExtension := LowerCase(CopyStr(fileName, StrPos(fileName, '.'), StrLen(fileName) - StrPos(fileName, '.') + 1));
            if not validFormats.Contains(fileExtension) then
                Error('Unsupported file format. Please upload PDF, DOCX, JPEG or JPG.');

            fileSize := inStream.Length / 1024 / 1024;
            if fileSize > 5 then
                Error('File is too large. Maximum size allowed is 5MB.');

            pUploadResult := UploadDocumentToBlob(inStream, fileName, pFolderName);
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
    begin
        if not ConfigRecord.FindFirst() then
            Error('Azure configuration is missing. Please set up the configuration.');

        StorageAccount := ConfigRecord."Storage Account Name";
        ContainerName := ConfigRecord."Default Container";

        if StorageAccount = '' then Error('Storage Account Name is missing in Azure configuration.');
        if ContainerName = '' then Error('Container name cannot be empty.');
        if FileName = '' then Error('File name cannot be empty.');

        AccessToken := GetAzureADToken();
        if AccessToken = '' then Error('Failed to obtain Azure AD token.');

        if FolderName <> '' then begin
            if not FolderName.EndsWith('/') then
                FolderName := FolderName + '/';
            FullBlobPath := FolderName + FileName;
        end else
            FullBlobPath := FileName;

        BlobUrl := StrSubstNo('https://%1.blob.core.windows.net/%2/%3', StorageAccount, ContainerName, FullBlobPath);
        // Message('Uploading to URL: %1', BlobUrl);

        HttpRequest.Method := 'PUT';
        HttpRequest.SetRequestUri(BlobUrl);
        HttpRequest.GetHeaders(HttpHeaders);

        HttpHeaders.Add('Authorization', 'Bearer ' + AccessToken);
        HttpHeaders.Add('x-ms-blob-type', 'BlockBlob');
        HttpHeaders.Add('x-ms-version', '2020-08-04');
        HttpHeaders.Add('x-ms-date', GetRFC1123FormattedDateTime());

        ContentType := GetMimeTypeFromFileName(FileName);
        HttpHeaders.Add('x-ms-blob-content-disposition', StrSubstNo('inline; filename="%1"', FileName));
        HttpHeaders.Add('x-ms-blob-content-type', ContentType);
        HttpHeaders.Add('x-ms-blob-cache-control', 'public, max-age=86400');

        Content.WriteFrom(InStream);
        HttpRequest.Content(Content);

        Content.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', ContentType);

        if HttpClient.Send(HttpRequest, Response) then begin
            if Response.IsSuccessStatusCode() then
                exit(StrSubstNo('https://%1.blob.core.windows.net/%2/%3', StorageAccount, ContainerName, FullBlobPath))
            else begin
                Response.Content().ReadAs(ResponseText);
                Error('Failed to upload file. Status: %1. Response: %2', Response.HttpStatusCode(), ResponseText);
            end;
        end else
            Error('Failed to send HTTP request.');
    end;

    procedure GetRFC1123FormattedDateTime(): Text
    var
        CurrentDT: DateTime;
        FormattedDate: Text;
        DayOfWeek: Text;
        Month: Text;
        WeekDayNumber: Integer;
        MonthNumber: Integer;
    begin
        CurrentDT := CurrentDateTime();

        // Convert to UTC if needed
        CurrentDT := CurrentDT; // Assume system is already in UTC or adjust accordingly

        // Get day of week (1=Monday, 7=Sunday, but RFC1123 uses Sun=0, Mon=1...)
        WeekDayNumber := Date2DWY(DT2Date(CurrentDT), 1);
        case WeekDayNumber of
            1:
                DayOfWeek := 'Mon';
            2:
                DayOfWeek := 'Tue';
            3:
                DayOfWeek := 'Wed';
            4:
                DayOfWeek := 'Thu';
            5:
                DayOfWeek := 'Fri';
            6:
                DayOfWeek := 'Sat';
            7:
                DayOfWeek := 'Sun';
        end;

        // Get month
        MonthNumber := Date2DMY(DT2Date(CurrentDT), 2);
        case MonthNumber of
            1:
                Month := 'Jan';
            2:
                Month := 'Feb';
            3:
                Month := 'Mar';
            4:
                Month := 'Apr';
            5:
                Month := 'May';
            6:
                Month := 'Jun';
            7:
                Month := 'Jul';
            8:
                Month := 'Aug';
            9:
                Month := 'Sep';
            10:
                Month := 'Oct';
            11:
                Month := 'Nov';
            12:
                Month := 'Dec';
        end;

        // Format: "Wed, 02 Jul 2025 12:30:45 GMT"
        FormattedDate := StrSubstNo('%1, %2 %3 %4 %5:%6:%7 GMT',
            DayOfWeek,
            Format(Date2DMY(DT2Date(CurrentDT), 1), 2, '<Integer,2><Filler Character,0>'),
            Month,
            Format(Date2DMY(DT2Date(CurrentDT), 3)),
            Format(DT2Time(CurrentDT), 0, '<Hours24,2>'),
            Format(DT2Time(CurrentDT), 0, '<Minutes,2>'),
            Format(DT2Time(CurrentDT), 0, '<Seconds,2>')
        );

        exit(FormattedDate);
    end;

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
        TestAzureADConnectivity();
        if not ConfigRecord.FindFirst() then
            Error('Azure configuration is missing. Please set up the configuration.');

        TokenEndpoint := StrSubstNo('https://login.microsoftonline.com/%1/oauth2/v2.0/token', ConfigRecord."Tenant ID");
        // Message('Token request body: %1', TokenEndpoint);
        RequestBody :=
            'grant_type=client_credentials' +
            '&client_id=' + ManualUrlEncode(ConfigRecord."Client ID") +
            '&client_secret=' + ManualUrlEncode(ConfigRecord."Client Secret") +
            '&scope=' + ManualUrlEncode('https://storage.azure.com/.default');

        // Message('Token request body: %1', RequestBody);
        RequestContent.WriteFrom(RequestBody);

        RequestContent.GetHeaders(Headers);
        Headers.Clear();
        Headers.Add('Content-Type', 'application/x-www-form-urlencoded');

        if not HttpClient.Post(TokenEndpoint, RequestContent, ResponseMessage) then
            Error('Failed to send token request.');

        if not ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(ResponseText);
            Error('Token request failed. Status: %1. Response: %2',
                  ResponseMessage.HttpStatusCode(), ResponseText);
        end;

        ResponseMessage.Content().ReadAs(ResponseText);
        if not JsonObject.ReadFrom(ResponseText) then
            Error('Failed to parse token response.');

        if not JsonObject.Get('access_token', JsonToken) then
            Error('No access token in response.');

        exit(JsonToken.AsValue().AsText());
    end;

    procedure ManualUrlEncode(Value: Text): Text
    begin
        Value := Value.Replace('%', '%25');
        Value := Value.Replace('=', '%3D');
        Value := Value.Replace('+', '%2B');
        Value := Value.Replace(' ', '%20');
        exit(Value);
    end;

    procedure TestAzureADConnectivity()
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        if not Client.Get('https://login.microsoftonline.com', Response) then
            Error('❌ Failed to send GET request to Azure AD.');

        // Message('✅ Azure AD reachable. Status code: %1', Response.HttpStatusCode());
    end;

    procedure GetMimeTypeFromFileName(FileName: Text): Text
    var
        FileExtension: Text;
        ExtensionPos: Integer;
    begin
        ExtensionPos := StrPos(FileName, '.');
        if ExtensionPos > 0 then
            FileExtension := LowerCase(CopyStr(FileName, ExtensionPos))
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
            '.csv':
                exit('text/csv');
            '.json':
                exit('application/json');
            '.xml':
                exit('application/xml');
            '.html', '.htm':
                exit('text/html');
            else
                exit('application/octet-stream');
        end;
    end;
}