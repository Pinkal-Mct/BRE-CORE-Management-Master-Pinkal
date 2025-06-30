table 51008 "FM Service Request"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request ID"; Code[20]) { DataClassification = CustomerContent; }
        // field(2; "Request Status"; Enum "FM Request Status") { }
        field(3; "Submission Date"; Date) { }
        field(4; "Requested Date"; Date) { }
        field(5; "Submitted By"; Code[50]) { }
        // field(6; "Approval Status"; Enum "FM Approval Status") { }
        field(7; "Work Order ID"; Code[20]) { }
        // field(8; "Urgency Level"; Enum "FM Urgency Level") { }
        // field(9; "Property Code"; Code[20]) { TableRelation = "FM Property"; }
        // field(10; "Service Category"; Code[20]) { TableRelation = "FM Service Category"; }
        field(11; "Submission Source"; Option) { OptionMembers = Manual,Portal,MobileApp; }
        field(12; "Unit/Flat"; Code[20]) { }
        field(13; "Contact Name"; Text[100]) { }
        field(14; "Phone"; Text[20]) { }
        field(15; "Email"; Text[100]) { }
        // field(16; "Service Sub-Type"; Code[20]) { TableRelation = "FM Service Subtype"; }
        field(17; "Problem Description"; Text[250]) { }
        field(18; "Preferred Date"; Date) { }
        field(19; "Preferred Time"; Time) { }
        field(20; "Approved By"; Code[50]) { }
        field(21; "Approved Date"; Date) { }
        field(22; "Created Date"; DateTime) { Editable = false; }
        field(23; "Created By"; Code[50]) { Editable = false; }
        field(24; "Last Modified"; DateTime) { Editable = false; }
        field(25; "Last Modified By"; Code[50]) { Editable = false; }
    }

    keys
    {
        key(PK; "Request ID") { Clustered = true; }
    }

    trigger OnInsert()
    begin
        "Created Date" := CurrentDateTime;
        "Created By" := UserId;
    end;

    trigger OnModify()
    begin
        "Last Modified" := CurrentDateTime;
        "Last Modified By" := UserId;
    end;
}