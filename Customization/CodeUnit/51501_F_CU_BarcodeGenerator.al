codeunit 51501 "QR-Code Generator"
{
    procedure GenerateQR_CodeID(var Asset: Record "Fixed Asset")
    var
        BarcodeText: Text[50];
        InStream: InStream;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        BarcodeTypeText: Text[10];
        TempAsset: Record "Fixed Asset";
        BarcodePrefix: Text[10];
    begin
        BarcodePrefix := 'FMAM'; // Can make configurable
        Asset."QR-Code ID" := Asset."No.";
        Asset."QR-Code Generated?" := true;
        // if Asset."Barcode ID" = '' then
        //     Asset."Barcode ID" := 'Asset-' + Asset."No.";

        // case Asset."Barcode Type" of
        //     Asset."Barcode Type"::Code128:
        //         BarcodeTypeText := 'Code128';
        //     Asset."Barcode Type"::"QR Code":
        //         BarcodeTypeText := 'QR Code';
        // end;
        // // Simulated barcode image generation (use external integration in real case)
        // Clear(TempBlob);
        // TempBlob.CreateOutStream(OutStream);
        // OutStream.WriteText('Simulated barcode for ' + Asset."Barcode ID");
        // TempBlob.CreateInStream(InStream);

        // // Use ImportStream to load into the Media field
        // Asset.CalcFields("Barcode Image");
        // Asset."Barcode Image".ImportStream(InStream, 'AssetBarcode_' + Asset."No.");

        // Asset."Barcode Generated?" := true;
        // Asset.Modify(true);

        // // Asset.Validate("Barcode Image", MediaID);
        // // Asset.Validate("Barcode Generated?", true);
        // // Asset.Modify(true);
    end;

    procedure GenerateQR_CodeImage(AssetNo: Code[20]; var fixedAsset: Record "Fixed Asset")
    var
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
        TempBlob: Codeunit "Temp Blob";
    begin

        if UploadIntoStream('Upload Barcode Image', '', 'Image Files (*.png, *.jpg)|*.png;*.jpg', FileName, InStr) then begin
            fixedAsset."QR-Code ID" := AssetNo;
            fixedAsset."QR-Code Image".ImportStream(InStr, FileName);
        end;
    end;
}