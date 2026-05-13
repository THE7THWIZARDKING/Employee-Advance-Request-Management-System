pageextension 50100 "Customer Card Extension" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            group("Employee Information")
            {
                field("Is Internal Employee"; Rec."Is Internal Employee")
                {
                    ApplicationArea = All;
                }

                field("Employee Reference No."; Rec."Employee Reference No.")
                {
                    ApplicationArea = All;
                    Visible = Rec."Is Internal Employee";
                }

                field("Employee Department"; Rec."Employee Department")
                {
                    ApplicationArea = All;
                    Visible = Rec."Is Internal Employee";
                }
            }
        }
    }
}