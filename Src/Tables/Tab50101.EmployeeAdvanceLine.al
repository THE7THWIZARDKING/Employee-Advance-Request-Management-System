table 50101 "Employee Advance Line"
{
    Caption = 'Employee Advance Line';
    DataClassification = ToBeClassified;
    
    fields
    {
       field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            DataClassification = CustomerContent;
            TableRelation = "Employee Advance Header"."Request No.";
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

        field(3; "Expense Type"; Enum "Expense Type")
        {
            Caption = 'Expense Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateExpenseRules();
            end;
        }

        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidateExpenseRules();
            end;
        }

        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                if Quantity <= 0 then
                    Error('Quantity must be greater than zero.');

                CalculateLineAmount();
            end;
        }

        field(6; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                if "Unit Cost" < 0 then
                    Error('Unit Cost cannot be negative.');

                CalculateLineAmount();
            end;
        }

        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
            Editable = false;
            DecimalPlaces = 0 : 2;
        }

        field(8; "Is Urgent"; Boolean)
        {
            Caption = 'Is Urgent';
            DataClassification = CustomerContent;
        }
    }
  
   keys
    {
        key(PK; "Request No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        UpdateHeaderTotal();
    end;

    trigger OnModify()
    begin
        UpdateHeaderTotal();
    end;

    trigger OnDelete()
    begin
        UpdateHeaderTotal();
    end;

    local procedure CalculateLineAmount()
    begin
        "Line Amount" := Quantity * "Unit Cost";

        UpdateHeaderTotal();
    end;

    local procedure ValidateExpenseRules()
    begin
        if ("Expense Type" = "Expense Type"::Travel) and
           (Description = '') then
            Error('Description is mandatory for Travel expenses.');
    end;

    local procedure UpdateHeaderTotal()
    var
        AdvanceLine: Record "Employee Advance Line";
        AdvanceHeader: Record "Employee Advance Header";
        TotalAmount: Decimal;
    begin
        TotalAmount := 0;

        AdvanceLine.SetRange("Request No.", "Request No.");

        if AdvanceLine.FindSet() then
            repeat
                TotalAmount += AdvanceLine."Line Amount";
            until AdvanceLine.Next() = 0;

        if AdvanceHeader.Get("Request No.") then begin
            AdvanceHeader."Total Amount" := TotalAmount;
            AdvanceHeader.Modify();
        end;
    end;
}
