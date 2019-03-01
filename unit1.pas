unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Spin,
  StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Convertir: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ConvertirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  comptB : integer;
  bi : string;

implementation

{$R *.lfm}

{ TForm1 }

function DtoB (n : integer) : string;
var
  temp : string;
begin
  temp:='';
  repeat
  If n mod 2 = 1 then temp:='1'+temp else temp:='0'+temp;
    n := n div 2;
  until n=0;
  case length(temp) of
       1 : temp := '0000000'+temp;
       2 : temp := '000000'+temp;
       3 : temp := '00000'+temp;
       4 : temp := '0000'+temp;
       5 : temp := '000'+temp;
       6 : temp := '00'+temp;
       7 : temp := '0'+temp;
  end;
  DtoB := temp;
end;

function BtoH (val : string): string;
VAR
  separateur :array[1..2] of string;
  separateurint :array[1..2] of integer;
  temp : string;
  i,j,sto : integer;
begin
  separateur[2] := Copy(val,1,4);
  separateur[1] := Copy(val,5,4);
  for i:=1 to 2 do
  begin
      sto := 0;
      for j:=1 to 4 do
      begin
          if separateur[i][j] = '1' then
            case j of
                 1 : sto := sto + 8;
                 2 : sto := sto + 4;
                 3 : sto := sto + 2;
                 4 : sto := sto + 1;
            end;
      end;
      separateurint[i]:=sto;
  end;
  for i:=1 to 2 do
  begin
      case separateurint[i] of
           0 : temp := '0'+temp;
           1 : temp := '1'+temp;
           2 : temp := '2'+temp;
           3 : temp := '3'+temp;
           4 : temp := '4'+temp;
           5 : temp := '5'+temp;
           6 : temp := '6'+temp;
           7 : temp := '7'+temp;
           8 : temp := '8'+temp;
           9 : temp := '9'+temp;
           10 : temp := 'A'+temp;
           11 : temp := 'B'+temp;
           12 : temp := 'C'+temp;
           13 : temp := 'D'+temp;
           14 : temp := 'E'+temp;
           15 : temp := 'F'+temp;
      end;
  end;
  BtoH := temp;
end;

function BtoD (val : string) : integer;
var
 temp,i : integer;
begin
 temp := 0;
 for i:=1 to 8 do
 begin
     if val[i] = '1' then
       case i of
        1 : temp := temp + 128;
        2 : temp := temp + 64;
        3 : temp := temp + 32;
        4 : temp := temp + 16;
        5 : temp := temp + 8;
        6 : temp := temp + 4;
        7 : temp := temp + 2;
        8 : temp := temp + 1;
       end;
 end;
 BtoD := temp;
end;

function HtoB (val : string) : string;
VAR
 temp : string;
 i : integer;
begin
 temp:='';
 val := uppercase(val);
 for i:=1 to 2 do
     case val[i] of
          '0' : temp := '0000'+temp;
          '1' : temp := '0001'+temp;
          '2' : temp := '0010'+temp;
          '3' : temp := '0011'+temp;
          '4' : temp := '0100'+temp;
          '5' : temp := '0101'+temp;
          '6' : temp := '0110'+temp;
          '7' : temp := '0111'+temp;
          '8' : temp := '1000'+temp;
          '9' : temp := '1001'+temp;
          'A' : temp := '1010'+temp;
          'B' : temp := '1011'+temp;
          'C' : temp := '1100'+temp;
          'D' : temp := '1101'+temp;
          'E' : temp := '1110'+temp;
          'F' : temp := '1111'+temp;
     end;
     if val.Length = 1 then
       temp := '0000' + temp;
     HtoB := temp;
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  bi := '--------';
  Label1.Caption := bi;
  label2.Caption := '--';
  SpinEdit1.Value := 1;
  Edit1.Text:= '';
  Edit1.Enabled:=False;
  Button1.Enabled := False;
  Button2.Enabled := False;
  Button3.Enabled := False;

end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  comptB := 8;
  bi := '--------';
  Label1.Caption := bi;
  label2.Caption := '--';
  SpinEdit1.Value := 1;
  Edit1.Text:= '';
  Edit1.Enabled:=False;
  Button1.Enabled := True;
  Button2.Enabled := True;
  Button3.Enabled := True;
end;

procedure TForm1.RadioButton3Change(Sender: TObject);
begin
  bi := '--------';
  Label1.Caption := bi;
  label2.Caption := '--';
  SpinEdit1.Value := 1;
  Edit1.Text:= '';
  Edit1.Enabled:=True;
  Button1.Enabled := False;
  Button2.Enabled := False;
  Button3.Enabled := False;

end;

procedure TForm1.ConvertirClick(Sender: TObject);
begin
  if RadioButton1.Checked = true then
  begin
    Label1.caption := DtoB(SpinEdit1.value);
    Label2.Caption := BtoH(Label1.Caption);
  end;
  if RadioButton2.Checked = true then
  begin
    Label2.Caption := BtoH(Label1.Caption);
    SpinEdit1.Value := BtoD(Label1.Caption);
  end;
  if RadioButton3.Checked = true then
  begin
    Label1.Caption := HtoB(Edit1.Text);
    SpinEdit1.Value := BtoD(Label1.Caption);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  comptB := 8;
  bi := '--------';
  Label1.Caption := bi;
  Button1.Enabled := true;
  Button2.Enabled := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  bi[comptB] := '1';
  Label1.Caption := bi;
  comptB := comptB - 1;
  if comptB = 0 then
  begin
     Button1.Enabled := false;
     Button2.Enabled := false;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  bi[comptB] := '0';
  Label1.Caption := bi;
  comptB := comptB - 1;
  if comptB = 0 then
  begin
     Button2.Enabled := false;
     Button1.Enabled := false;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  bi := '--------';
  Edit1.Enabled:=False;
  Button1.Enabled := False;
  Button2.Enabled := False;
  Button3.Enabled := False;
  comptB := 8;
end;


end.

