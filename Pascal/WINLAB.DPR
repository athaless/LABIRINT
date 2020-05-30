program Winlab;

uses
  Forms,
  Main in 'MAIN.PAS' {Form1},
  Edicao in 'EDICAO.PAS' {FormEdit},
  Tipos in 'TIPOS.PAS';

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormEdit, FormEdit);
  Application.Run;
end.
