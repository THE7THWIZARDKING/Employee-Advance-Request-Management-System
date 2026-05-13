table 50100 "Employee Advance Header"
{
    Caption = 'Employee Advance Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            DataClassification = CustomerContent;
        }

        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                if EmployeeRec.Get("Employee No.") then begin
                    "Employee Name" := EmployeeRec.FullName();
                    Department := EmployeeRec."Global Dimension 1 Code";
                end;
            end;
        }

        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(4; Department; Text[50])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }

        field(6; Status; Enum "Advance Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(8; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Approved Amount" > "Total Amount" then
                    Error('Approved Amount cannot exceed Total Amount.');
            end;
        }

        field(9; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }

        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Request No.")
        {
            Clustered = true;
        }
    }

    local procedure GetNoSeriesCode(): Code[20]
    begin
        exit('TEST-01');
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        "Request Date" := Today;
        Status := Status::Open;

        if "Request No." = '' then
            NoSeriesMgt.InitSeries(
                'TEST-01',
                xRec."No. Series",
                WorkDate(),
                "Request No.",
                "No. Series");
    end;
}