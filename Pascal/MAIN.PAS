{--------------------------------------------------------------------------}
{ Labirint (prototipo)                                                     }
{  Versao original BASIC MSX    - Alessander P. Oliveira 26/08/1987-88     }
{  Nova adaptacao BorlandC(DOS) - Alessander P. Oliveira 10/03/1994        }
{  Nova adaptacao BorlandC(WIN) - Alessander P. Oliveira 22/08/1994        }
{  Nova adaptacao Delphi 1.0    - Alessander P. Oliveira 01/12/1995        }
{  Nova adaptacao Delphi 2.0                                               }
{   colocação de bitmap's como paredaes- Alessander P. Oliveira 01/11/1996 }
{--------------------------------------------------------------------------}

unit Main;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Menus, {Keyboard}
  Edicao,Tipos;

const
  CORFUNDO = clBlack;
  CORN1 = clWhite;
  CORN2 = clRed;
  CORN3 = clYellow;
  CORN4 = clGreen;
  CORN5 = clBlue;
  QuadroTamW = 252;
  QuadroTamH = 185;

type
  TForm1 = class(TForm)
    Desk: TImage;
    Bevel1: TBevel;
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Reiniciar: TMenuItem;
    N1: TMenuItem;
    Fechar1: TMenuItem;
    Panel2: TPanel;
    Edit1: TMenuItem;
    About1: TMenuItem;
    EditarLab1: TMenuItem;
    Info1: TMenuItem;
    Labirinto: TMenuItem;
    Edit2: TEdit;
    PanelTampa: TPanel;
    boxInv: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Inicializacao;
    procedure Movimentacao(sentido: Integer);
    procedure Executa(Stick: byte);
    procedure LinhaMat(Nlinha: Integer; StrLinha: string);

    procedure DrawLine(x1,y1,x2,y2:integer; cor:TColor);
    procedure DrawText(x,y:integer; str:string; cor:TColor);
    procedure DrawRectangle(x1,y1,x2,y2:integer; cor:TColor);
    procedure DrawMap;
    procedure ButRightClick(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure BoxINVClick(Sender: TObject);
    procedure ReiniciarClick(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Info1Click(Sender: TObject);
    procedure EditarLab1Click(Sender: TObject);
    procedure PanelTampaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    private
     DX, DY: array[0..3]of integer;
     P,X,Y,D,I,J: integer;
     DE,EE,FE: char;
     ES,DI: integer;

     AuxBmp_LD, AuxBmp_LR, AuxBmp_RD, AuxBmp_RR, AuxBMP,
     AuxBmp_Fim,AuxBmp_autor:TBitMap;
    public

  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
var auxstr:string;
begin
 AuxBMP:=nil; AuxBMP_LD:=nil; AuxBMP_LR:=nil; AuxBMP_RR:=nil; AuxBMP_RD:=nil; AuxBMP_fim:=nil; AuxBMP_Autor:=nil;

 AuxBMP:=TBitMap.Create;
 AuxBMP.width  := QuadroTamW;
 AuxBMP.height := QuadroTamH;
 AuxStr:='parede.bmp'; if FileExists(auxstr) then AuxBMP.LoadFromFile(auxstr);

 AuxBmp_LD:=TBitMap.Create;
 AuxBMP_LD.width:=36;  AuxBMP_LD.height:=126;
 AuxStr:='ld1.bmp'; if FileExists(auxstr) then AuxBMP_LD.LoadFromFile(auxstr);

 AuxBmp_LR:=TBitMap.Create;
 AuxBMP_LR.width:=36; AuxBMP_LR.height:=126;
 AuxStr:='lr1.bmp';if FileExists(auxstr) then AuxBMP_lr.LoadFromFile(auxstr);

 AuxBmp_RD:=TBitMap.Create;
 AuxBMP_RD.width:=36;  AuxBMP_RD.height:=126;
 AuxStr:='rd1.bmp'; if FileExists(auxstr) then AuxBMP_rd.LoadFromFile(auxstr);

 AuxBmp_RR:=TBitMap.Create;
 AuxBMP_RR.width:=36;  AuxBMP_RR.height:=126;
 AuxStr:='rr1.bmp';if FileExists(auxstr) then AuxBMP_rr.LoadFromFile(auxstr);

 AuxBmp_Fim:=TBitMap.Create;
 AuxBMP_fim.width:=QuadroTamW;  AuxBMP_fim.height:=QuadroTamW;
 AuxStr:='fim.bmp'; if FileExists(auxstr) then AuxBMP_fim.LoadFromFile(auxstr);

 AuxBmp_autor:=TBitMap.Create;
 AuxBMP_autor.width:=QuadroTamW;  AuxBMP_autor.height:=QuadroTamW;
 AuxStr:='autor.bmp';if FileExists(auxstr) then AuxBMP_autor.LoadFromFile(auxstr);

 Inicializacao;
 { ESPECIAL > Labirinto pre-montado (apenas para teste) }
 LinhaMat(0, '0000000000000000000000000');
 LinhaMat(1, '0111111111111111000111100');
 LinhaMat(2, '0000001000000001000100100');
 LinhaMat(3, '0000001000000001000100100');
 LinhaMat(4, '0000001111100111111111100');
 LinhaMat(5, '0111111000000100000000100');
 LinhaMat(6, '0101001000000100011111110');
 LinhaMat(7, '0101111111000100010000100');
 LinhaMat(8, '0100001001000111111000100');
 LinhaMat(9, '0111111111111101001111100');
 LinhaMat(10,'0101001000100101001000100');
 LinhaMat(11,'0101001111111101001011100');
 LinhaMat(12,'0101001000100101001010100');
 LinhaMat(13,'0101111000111111111011110');
 LinhaMat(14,'0101001000000100010000010');
 LinhaMat(15,'0101001001000100010000000');
 LinhaMat(16,'0111111111111111111111100');
 LinhaMat(17,'0000000000000000000000100');
 LinhaMat(18,'0000000000000000000000S00'); { Não é conveniente usar esta linha }

end;

procedure TForm1.Inicializacao;
begin
 ES:=0; DI:=0;
 P:=0;
 DX[0]:=1;   DX[1]:=0;   DX[2]:=-1;  DX[3]:=0;
 DY[0]:=0;   DY[1]:=-1;  DY[2]:=0 ;  DY[3]:=1;
 { Coordenadas iniciais do jogador (x,y) }
 X:=1; Y:=1;
 { Lado para o qual ele sairá virado }
 D:=2; { 0-LESTE 1-NORTE 2-OESTE 3-SUL }
 Desk.Canvas.Brush.Color:=CORFUNDO;
 Desk.Canvas.FillRect(Desk.Canvas.ClipRect);
end;

procedure TForm1.LinhaMat(Nlinha: integer; StrLinha: string);
var col:integer;
begin
 for col:=0 to 25 do  MAT[Nlinha,Col]:=Strlinha[Col+1];
end;

procedure TForm1.DrawRectangle(x1,y1,x2,y2:integer; cor:TColor);
begin
 Desk.Canvas.Brush.Color:=CORFUNDO;
 Desk.Canvas.Pen.Color:=cor;
 Desk.Canvas.Rectangle(x1,y1,x2,y2);
end;

procedure TForm1.DrawLine(x1,y1,x2,y2:integer; cor:TColor);
begin
 Desk.Canvas.Brush.Color:=CORFUNDO;
 Desk.Canvas.Pen.Color:=cor;
 Desk.Canvas.MoveTo(x1,y1);
 Desk.Canvas.LineTo(x2,y2);
end;

procedure TForm1.DrawText(x,y:integer; str:string; cor:TColor);
begin
 Desk.Canvas.Brush.Color:=CORFUNDO;
 Desk.Canvas.Pen.Color:=cor;
 Desk.Canvas.TextOut(x,y, str);
end;

procedure TForm1.Movimentacao(sentido : integer);
var I:Integer;
begin
  case (sentido) of
      1:begin
          if (EE<>'0') then
            begin
              {DrawLine (10,153,46,153,CORN1);
              DrawLine (46,153,46,27,CORN1);
              DrawLine (46,27,10,27,CORN1);}
              Desk.Canvas.CopyRect(Rect(0,0,46,195),
                                   AuxBMP_LR.Canvas,
                                   Rect(0,0,AuxBMP_LR.Width,AuxBMP_LR.height));
            end
          else
            begin
              {DrawLine (10,180,46,153,CORN1);
              DrawLine (46,153,46,27,CORN1);
              DrawLine (46,27,10,7,CORN1);}
              Desk.Canvas.CopyRect(Rect(0,0,46,195),
                                   AuxBMP_LD.Canvas,
                                   Rect(0,0,AuxBMP_LD.Width,AuxBMP_LD.height));

            end;

          if (DE<>'0') then
            begin
              {DrawLine (246,153,210,153,CORN1);
              DrawLine (210,153,210,27,CORN1);
              DrawLine (210,27,246,27,CORN1);}
              Desk.Canvas.CopyRect(Rect(210,0,256,195),
                                   AuxBMP_RR.Canvas,
                                   Rect(0,0,AuxBMP_RR.Width,AuxBMP_RR.height));
            end
          else
            begin
              {DrawLine (246,180,210,153,CORN1);
              DrawLine (210,153,210,27,CORN1);
              DrawLine (210,27,246,7,CORN1);}
              Desk.Canvas.CopyRect(Rect(210,0,256,195),
                                   AuxBMP_RD.Canvas,
                                   Rect(0,0,AuxBMP_RD.Width,AuxBMP_RD.height));
            end;

          if (FE='0') then
           begin
            {DrawRectangle(46,27, 210,154,CORN1);
            DrawRectangle(66,47, 190,134,CORN1)}
            { quadro };
            Desk.Canvas.CopyRect(Rect(46,39, 210,153),
                                  AuxBMp.Canvas,
                                  Rect(0,0,QuadroTAMW,QuadroTamH));
           end
          else
           if (FE='S') then
            begin
             {DrawRectangle(46,27,210,154,CORN1);
             Desk.Canvas.Ellipse(46,27,210,154);}
             Desk.Canvas.CopyRect(Rect(46,39, 210,153),
                                  AuxBMP_fim.Canvas,
                                  Rect(0,0,QuadroTAMW,QuadroTamH));
             {if FileExists('Saida.bmp') then Desk.Picture.LoadFromFile('Saida.bmp');}
            end
        end;

      2:begin
          if (EE<>'0') then
            begin
              {DrawLine (46,130,76,130,CORN2);
              DrawLine (76,130,76,50,CORN2);
              DrawLine (76,50,46,50,CORN2);}
              Desk.Canvas.CopyRect(Rect(46,36,76,155),
                                   AuxBMP_LR.Canvas,
                                   Rect(0,0,AuxBMP_LR.Width,AuxBMP_LR.height));
            end
          else
            begin
              {DrawLine (46,153,76,130,CORN2);
              DrawLine (76,130,76,50,CORN2);
              DrawLine (76,50,46,27,CORN2);}
              Desk.Canvas.CopyRect(Rect(46,36,76,155),
                                   AuxBMP_LD.Canvas,
                                   Rect(0,0,AuxBMP_LD.Width,AuxBMP_LD.height));
            end;

          if (DE<>'0') then
            begin
              {DrawLine (210,130,180,130,CORN2);
              DrawLine (180,130,180,50,CORN2);
              DrawLine (180,50,210,50,CORN2);}
              Desk.Canvas.CopyRect(Rect(180,36,210,155),
                                   AuxBMP_RR.Canvas,
                                   Rect(0,0,AuxBMP_RR.Width,AuxBMP_RR.height));
            end
          else
            begin
              {DrawLine (210,153,180,130,CORN2);
              DrawLine (180,130,180,50,CORN2);
              DrawLine (180,50,210,27,CORN2);}
              Desk.Canvas.CopyRect(Rect(180,36,210,155),
                                   AuxBMP_RD.Canvas,
                                   Rect(0,0,AuxBMP_RD.Width,AuxBMP_RD.height));
            end;

          if (FE='0') then
           begin
            {DrawRectangle(76,50, 180,131,CORN2);
            DrawRectangle(86,60, 170,121,CORN2)}
            { quadro };
            Desk.Canvas.CopyRect(Rect(76,59, 180,129),
                                  AuxBMp.Canvas,
                                  Rect(0,0,QuadroTAMW,QuadroTamH));
           end
          else
           if (FE='S') then
            begin
             {DrawRectangle(76,50, 180,131,CORN2);
             Desk.Canvas.Ellipse(76,50, 180,131);}
             Desk.Canvas.CopyRect(Rect(76,59, 180,129),
                                  AuxBMp_fim.Canvas,
                                  Rect(0,0,QuadroTAMW,QuadroTamH));

             {Desk.Picture.LoadFromFile('Saida.bmp');}
            end
        end;

      3:begin
          if (EE<>'0') then
            begin
              {DrawLine (76,114,96,114,CORN3);
              DrawLine (96,114,96,66,CORN3);
              DrawLine (96,66,76,66,CORN3);}
              Desk.Canvas.CopyRect(Rect(76,58,96,131),
                                   AuxBMP_LR.Canvas,
                                   Rect(0,0,AuxBMP_LR.Width,AuxBMP_LR.height));
            end
          else
            begin
              {DrawLine (76,130,96,114,CORN3);
              DrawLine (96,114,96,66,CORN3);
              DrawLine (96,66,76,50,CORN3);}
              Desk.Canvas.CopyRect(Rect(76,58,96,131),
                                   AuxBMP_LD.Canvas,
                                   Rect(0,0,AuxBMP_LD.Width,AuxBMP_LD.height));
            end;

          if (DE<>'0') then
            begin
              {DrawLine (180,114,160,114,CORN3);
              DrawLine (160,114,160,66,CORN3);
              DrawLine (160,66,180,66,CORN3);}
              Desk.Canvas.CopyRect(Rect(160,58,180,131),
                                   AuxBMP_RR.Canvas,
                                   Rect(0,0,AuxBMP_RR.Width,AuxBMP_RR.height));
            end
          else
            begin
              {DrawLine (180,130,160,114,CORN3);
              DrawLine (160,114,160,66,CORN3);
              DrawLine (160,66,180,50,CORN3); }
              Desk.Canvas.CopyRect(Rect(160,58,180,131),
                                   AuxBMP_RD.Canvas,
                                   Rect(0,0,AuxBMP_RD.Width,AuxBMP_RD.height));
            end;

          if (FE='0') then
           begin
            {DrawRectangle(96, 66,160,115,CORN3);
            DrawRectangle(101,71,155,110,CORN3);}
            { quadro }
            Desk.Canvas.CopyRect(Rect(96,72,160,115),
                                  AuxBMp.Canvas,
                                  Rect(0,0,QuadroTAMW,QuadroTamH));
           end
          else
           if (FE='S') then
            begin
             DrawRectangle(96,66,160,115,CORN3);
             Desk.Canvas.Ellipse(96,66,160,115);
             {Desk.Picture.LoadFromFile('Saida.bmp');}
            end
          end;

      4:begin
          if (EE<>'0') then
            begin
              {DrawLine (96,107,106,107,CORN4);
              DrawLine (106,107,106,75,CORN4);
              DrawLine (106,75,96,75,CORN4); }
              Desk.Canvas.CopyRect(Rect(96,71,106,116),
                                   AuxBMP_LR.Canvas,
                                   Rect(0,0,AuxBMP_LR.Width,AuxBMP_LR.height));
            end
          else
            begin
              {DrawLine (96,114,106,107,CORN4);
              DrawLine (106,107,106,75,CORN4);
              DrawLine (106,75,96,66,CORN4);}
              Desk.Canvas.CopyRect(Rect(96,71,106,116),
                                   AuxBMP_LD.Canvas,
                                   Rect(0,0,AuxBMP_LD.Width,AuxBMP_LD.height));
            end;

          if (DE<>'0') then
            begin
              {DrawLine (160,107,150,107,CORN4);
              DrawLine (150,107,150,75,CORN4);
              DrawLine (150,75,160,75,CORN4);}
              Desk.Canvas.CopyRect(Rect(150,71,160,116),
                                   AuxBMP_RR.Canvas,
                                   Rect(0,0,AuxBMP_RR.Width,AuxBMP_RR.height));
            end
          else
            begin
              {DrawLine (160,114,150,107,CORN4);
              DrawLine (150,107,150,75,CORN4);
              DrawLine (150,75,160,66,CORN4);}
              Desk.Canvas.CopyRect(Rect(150,71,160,116),
                                   AuxBMP_RD.Canvas,
                                   Rect(0,0,AuxBMP_RD.Width,AuxBMP_RD.height));
            end;

          if (FE='0') then
           begin
             {DrawRectangle(106,75,150,108,CORN4);
             DrawRectangle(109,78,147,105,CORN4);}
             { quadro }
             Desk.Canvas.CopyRect(Rect(106,80,150,103),
                                  AuxBMp.Canvas,
                                  Rect(0,0,QuadroTAMW,QuadroTamH));
           end
          else
           if (FE='S') then
            begin
             DrawRectangle(106,75,150,108,CORN4);
             Desk.Canvas.Ellipse(106,75,150,108);
             {Desk.Picture.LoadFromFile('Saida.bmp');}
            end
           else
            DrawText(126,86,'?',CORN4);
        end;

      5:begin
          if (EE<>'0') then
            begin
              DrawRectangle(106,103,111,104,CORN5);
              DrawLine (111,103,111,80,CORN5);
              DrawLine (111,80,106,80,CORN5);
            end
          else
            begin
              DrawRectangle(106,107,111,104,CORN5);
              DrawLine (111,103,111,80,CORN5);
              DrawLine (111,80,106,75,CORN5);
            end;

          if (DE<>'0') then
            begin
              DrawLine (150,103,145,103,CORN5);
              DrawLine (145,103,145,80,CORN5);
              DrawLine (145,80,150,80,CORN5);
            end
          else
            begin
              DrawLine (150,107,145,103,CORN5);
              DrawLine (145,103,145,80,CORN5);
              DrawLine (145,80,150,75,CORN5);
            end;

          if (FE='0') then
           begin
            DrawRectangle(111,80,145,104,CORN5);
            DrawRectangle(136,100,125,84,CORN3){ quadro };
           end
          else
           if (FE='S') then
            begin
             DrawRectangle(111,80,145,104,CORN5);
             Desk.Canvas.Ellipse(111,80,145,104);
             {Desk.Picture.LoadFromFile('Saida.bmp');}
            end
           else
            { DrawText(126,86,'?'); }
        end;
  end;
 Desk.Refresh;
end;

procedure TForm1.Edit2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if key=37 then
  begin Executa(TURN_LEFT); Edit2.Text:='L' end
 else
  if key=39 then
   begin Executa(TURN_RIGHT); Edit2.Text:='R' end
  else
   if key=38 then
    begin Executa(TURN_GO); Edit2.Text:='F' end
   else
    if key=40 then
      begin end
    else
      begin Executa(DONT_TURN); Edit2.Text:=''; end;
end;

procedure TForm1.BoxINVClick(Sender: TObject);
begin
 if (BoxINV.Checked) then Desk.Canvas.Pen.Style:=psDot
 else Desk.Canvas.Pen.Style:=psSolid;
 Executa(DONT_TURN);
 Edit2.SetFocus;
end;

procedure TForm1.ReiniciarClick(Sender: TObject);
begin
 PanelTampa.Visible:=False;
 Inicializacao;
 DrawRectangle(8,7,252,183,CORFUNDO);{ Limpa a area do labirinto }
 Executa(DONT_TURN);
end;

procedure TForm1.PanelTampaClick(Sender: TObject);
begin
 ReiniciarClick(Sender);
end;

procedure TForm1.Fechar1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm1.ButRightClick(Sender: TObject);
begin
 DrawRectangle(8,7,252,183,CORFUNDO);{ Limpa a area do labirinto }
 Executa(TURN_RIGHT);
end;

procedure TForm1.Executa(Stick:byte);
var I:integer;
begin
  Desk.Canvas.Brush.Color:=CORFUNDO;
  Desk.Canvas.FillRect(Desk.Canvas.ClipRect); { Limpa todo o canvas }
  DrawRectangle(8,7,252,183,CORFUNDO);{ Limpa a area do labirinto }

  if (stick = TURN_RIGHT) then  begin  D:=D-1; if (D<0) then D:=3; end;
  if (stick = TURN_LEFT)  then  begin  D:=D+1; if (D=4) then D:=0; end;
  if ((stick=TURN_GO)and(MAT[Y+DY[D]][X+DX[D]]='1')) then begin X:=X+DX[D]; Y:=Y+DY[D]; end;
  ES := (D+1) mod 4;
  DI := D-1;
  if (DI<0) then DI:=3;
  for I:=0 to 3 do
  begin
   EE := MAT[Y+I*DY[D]+DY[ES]][X+I*DX[D]+DX[ES]];
   DE := MAT[Y+I*DY[D]+DY[DI]][X+I*DX[D]+DX[DI]];
   FE := MAT[Y+(1+I)*DY[D]][X+(1+I)*DX[D]];
   Movimentacao(I+1);
   if (FE<>'1') then  break;
  end;
end;


procedure TForm1.DrawMap;
var
 straux:char;
 xx,yy,a,b: integer;
begin
{ DeskMap.Canvas.Brush.Color:=CORFUNDO;
 DeskMap.Canvas.Pen.Color:=clBlack;
 DeskMap.Canvas.Rectangle(282,15,504,161); }

 xx:=10;
 yy:=10;
 for a:=0 to 19 do
  begin
   for b:=0 to 26 do
    begin
     if (MAT[a][b]='0') then straux:='Û';
     if (MAT[a][b]='1') then straux:=' ';
     if (b=xx)and(a=yy) then
      begin
       { 0-LESTE 1-NORTE 2-OESTE 3-SUL }
       case D of
       	 0: straux:='>';
	 1: straux:='^';
         2: straux:='<';
	 3: straux:='|';
	end;
      end;
     if (MAT[a,b]='S') then straux:='S';
     { if (straux='*') then DeskMap.Canvas.Pen.Color:=clBlue
       else DeskMap.Canvas.Pen.Color:=clBlack;
       DeskMap.Canvas.Font.Size:=8;
       DeskMap.Canvas.TextOut(xx,yy,straux); }
     xx:=xx+8;
    end;
   yy:=yy+14;
   xx:=10;
  end;
 { DeskMap.Refresh; }
end;

procedure TForm1.Info1Click(Sender: TObject);
begin
 MessageDlg('LABIRINT - Protótipo by Alessander Pires Oliveira.',
             mtInformation, [mbOk] , 0);
end;

procedure TForm1.EditarLab1Click(Sender: TObject);
begin
 FormEdit.ShowModal;
 ReiniciarClick(Sender);
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if auxbmp<>nil then auxbmp.free;
 if auxbmp_lr<>nil then auxbmp_lr.free;
 if auxbmp_ld<>nil then auxbmp_ld.free;
 if auxbmp_rr<>nil then auxbmp_rr.free;
 if auxbmp_rd<>nil then auxbmp_rd.free;
 if auxbmp_fim<>nil then auxbmp_fim.free;
 if auxbmp_autor<>nil then auxbmp_autor.free;
end;

end.


