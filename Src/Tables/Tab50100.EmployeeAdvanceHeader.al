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
        field(2; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(3; "Employee No."; Code[20])
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

        field(4; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5; Department; Text[50])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(6; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Request Date" > Today then
                    Error('Request Date cannot be a future date.');
            end;
        }

        field(7; Status; Enum "Advance Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(8; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            FieldClass = FlowField;

            CalcFormula = Sum("Employee Advance Line"."Line Amount"
                where("Request No." = field("Request No.")));
            Editable = false;
        }

        field(9; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Total Amount");

                if "Approved Amount" > "Total Amount" then
                    Error('Approved Amount cannot exceed Total Amount.');
            end;
        }

        field(10; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Request No.")
        {
            Clustered = true;
        }
    }

    // trigger OnInsert()
    // var
    //     AdvanceHeader: Record "Employee Advance Header";
    //     LastNo: Integer;
    //     NewNo: Code[20];
    // begin
    //     "Request Date" := Today;
    //     Status := Status::Open;

    //     if "Request No." = '' then begin

    //         LastNo := 0;

    //         if AdvanceHeader.FindLast() then begin
    //             Evaluate(LastNo,
    //                 DelStr(AdvanceHeader."Request No.", 1, 3));
    //         end;

    //         LastNo += 1;

    //         NewNo := 'ADV' + PadStr(Format(LastNo), 4, '0');

    //         "Request No." := NewNo;
    //     end;
    // end;

    trigger OnInsert()
    var
        salessetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "Request No." = '' then begin
            salessetup.Get();
            salessetup.TestField("Employee Advance Nos.");
            "Request No." := NoSeriesMgt.GetNextNo(salessetup."Employee Advance Nos.", Today(), true);
            "No. Series" := salessetup."Employee Advance Nos.";
        end;

    end;
}