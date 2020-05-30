unit Edicao;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, ExtCtrls, Menus,Tipos, StdCtrls;

type
  TFormEdit = class(TForm)
    MainMenu1: TMainMenu;
    xzcfvbzcv1: TMenuItem;
    Panel1: TPanel;
    Novo1: TMenuItem;
    Abre1: TMenuItem;
    Salva1: TMenuItem;
    N1: TMenuItem;
    Fechar1: TMenuItem;
    About1: TMenuItem;
    Info1: TMenuItem;
    Edit1: TMenuItem;
    MapGridStr: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure MapGridStrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Fechar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEdit: TFormEdit;

implementation

{$R *.DFM}

procedure TFormEdit.FormShow(Sender: TObject);
var LL,CC:integer;
begin
 for CC:=0 to 24 do
  for LL:=0 to 17 do
   begin
    if (MAT[ll,cc]='1') then MapGridStr.Cells[cc,ll]:='Z';
    if (MAT[ll,cc]='0') then MapGridStr.Cells[cc,ll]:='';
    if (MAT[ll,cc]='S') then MapGridStr.Cells[cc,ll]:='S';
   end;
end;

procedure TFormEdit.MapGridStrMouseDown(Sender:TObject;Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
var
  Column, Row: Longint;
begin
  MapGridStr.MouseToCell(X, Y, Column, Row);

 if Button=mbLeft then MapGridStr.Cells[Column, Row]:='Z';
 if Button=mbRight then MapGridStr.Cells[Column, Row]:='';
end;

procedure TFormEdit.Fechar1Click(Sender: TObject);
var LL,CC:integer;
begin
 {for col:=0 to 25 do  MAT[Nlinha,Col]:=Strlinha[Col+1];}

 for CC:=0 to 25 do
  for LL:=0 to 17 do
   begin
    if MapGridStr.Cells[cc,ll]='Z' then Mat[ll,cc]:='1';
    if MapGridStr.Cells[cc,ll]=''  then Mat[ll,cc]:='0';
    if MapGridStr.Cells[cc,ll]='S' then Mat[ll,cc]:='S';
   end;
 Close;
end;

end.
