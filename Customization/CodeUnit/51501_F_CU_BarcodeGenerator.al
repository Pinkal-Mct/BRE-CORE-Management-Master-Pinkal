codeunit 51501 "Barcode Generator"
{
    procedure GenerateBarcodeID(var Asset: Record "Fixed Asset")
    var
        BarcodeText: Text[50];
        InStream: InStream;
        OutStream: OutStream;
        TempBlob: Codeunit "Temp Blob";
        BarcodeTypeText: Text[10];
        TempAsset: Record "Fixed Asset";
        BarcodePrefix: Text[10];
    begin
        BarcodePrefix := 'AST_'; // Can make configurable
        Asset."Barcode ID" := BarcodePrefix + Format(Asset."No.");
        Asset."Barcode Generated?" := true;
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
}