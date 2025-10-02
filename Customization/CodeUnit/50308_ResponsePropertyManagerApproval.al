codeunit 50308 "Contract Status Synchronizer"
{
    procedure SyncToTenancyContract(ContractStatusRec: Record "Approval Contract Status")
    var
        TenancyContract: Record "Tenancy Contract";
    begin
        // Find Tenancy Contract by Contract ID
        TenancyContract.Reset();
        TenancyContract.SetRange("Contract ID", ContractStatusRec."Contract ID");

        if not TenancyContract.FindFirst() then begin
            Message('No Tenancy Contract found for Contract ID %1', ContractStatusRec."Contract ID");
            exit;
        end;

        // Handle Approved
        if ContractStatusRec.Status = 'Approved' then begin
            case ContractStatusRec."Tenancy Contract Status" of
                'Activation':
                    begin
                        TenancyContract."Previous Status" := Format(TenancyContract."Tenant Contract Status");
                        TenancyContract.Validate("Tenant Contract Status", TenancyContract."Tenant Contract Status"::Active);
                    end;
                'Termination':
                    begin
                        TenancyContract."Previous Status" := Format(TenancyContract."Tenant Contract Status");
                        TenancyContract.Validate("Tenant Contract Status", TenancyContract."Tenant Contract Status"::Terminated);
                    end;
                'Suspension':
                    begin
                        TenancyContract."Previous Status" := Format(TenancyContract."Tenant Contract Status");
                        TenancyContract.Validate("Tenant Contract Status", TenancyContract."Tenant Contract Status"::Suspended);
                    end;
                'Under Suspension-Unit Release':
                    begin
                        TenancyContract."Previous Status" := Format(TenancyContract."Tenant Contract Status");
                        TenancyContract.Validate("Tenant Contract Status", TenancyContract."Tenant Contract Status"::"Under Suspension-Unit Released");
                    end;
                else
                    Message('Unsupported Tenancy Contract Status: %1', ContractStatusRec."Tenancy Contract Status");
            end;

            TenancyContract."Update Contract Status" := TenancyContract."Update Contract Status"::" ";
            TenancyContract.Modify();
        end;

        // Handle Rejected
        if ContractStatusRec.Status = 'Declined' then begin
            TenancyContract."Update Contract Status" := TenancyContract."Update Contract Status"::" ";
            TenancyContract.Modify();
        end;
    end;
}
