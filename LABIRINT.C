//-----------------------------------------------------------------
// Labirint (prototipo)
//  Versao original BASIC MSX - Alessander P. Oliveira 26/08/1988
//  Nova adaptacao BorlandC   - Alessander P. Oliveira 10/03/1994
//-----------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <graphics.h>
#include <ctype.h>
#include <dos.h>
#include "labirint.h"

#define TRUE 1
#define FALSE 0

char MAT[20][26];
char DE,EE,FE;
int  DX[4];DY[4];
int  P=0,X=2,Y=2,D,I,J;

void movimentacao(int);
void mapa(void);
void ajuda(void);
void refresh(void);
void draw_textura(int x,int y,int a,int b);

void main (void)
{
 char c,resp;
 int GraphDriver,error=0,GraphMode,ES,DI=0,fim=FALSE;

 DX[0]=1;    DX[1]=0;  DX[2]=-1;  DX[3]=0;
 DY[0]=0;   DY[1]=-1;  DY[2]=0 ;  DY[3]=1;

 //ESPECIAL > Labirinto pre-montado (apenas para teste)

 strcpy(MAT[ 0],"0000000000000000000000000");//Nao pode ser utilizada
 strcpy(MAT[ 1],"0011111111111111111111100");
 strcpy(MAT[ 2],"0000001000100101000100100");
 strcpy(MAT[ 3],"0001111000100101000100100");
 strcpy(MAT[ 4],"0000001000100111111111100");
 strcpy(MAT[ 5],"0111111111111100010000100");
 strcpy(MAT[ 6],"0100001000000100010000100");
 strcpy(MAT[ 7],"0111111111000100010000100");
 strcpy(MAT[ 8],"0100001000000111111000100");
 strcpy(MAT[ 9],"0111111111111100001111100");
 strcpy(MAT[10],"0001001000100100001000100");
 strcpy(MAT[11],"0001001000100100001000100");
 strcpy(MAT[12],"0001001000100100001000100");
 strcpy(MAT[13],"0001111111111111111111110");
 strcpy(MAT[14],"0001000000000100010000010");
 strcpy(MAT[15],"0001001001000100010000010");
 strcpy(MAT[16],"0001111111111111111111110");
 strcpy(MAT[17],"0001000100000100010000010");
 strcpy(MAT[18],"00000000000000000000000S0");//Nao e conveniente usar esta linha

 X=2;
 Y=2;
 D=3;

 GraphDriver = DETECT;
 initgraph(&GraphDriver,&GraphMode,"");
 error = graphresult();
 if (error!=grOk)
   { printf("\n Erro ! Sistema grafico"); exit(0); }

 //Meu nome
 settextstyle(DEFAULT_FONT,HORIZ_DIR,1);
 tresd(0,195,635,225,2,1,CYAN);
 tresd(5,198,258,222,2,0,CYAN);
 putstring(10,207,"by ALESSANDER PIRES OLIVEIRA");

 //Menu lateral
 tresd(525,0,635,190,2,1,CYAN);putstring(530,7,"MENU:");

 //Janela do jogo
 janela(0,0,260,190,2,6,6,6,6,CYAN);

 while(fim!=TRUE)
 {
  refresh();

  resp=barra_vertical(533,23,627,42,20,3);

  switch(resp)
   {
    case 0 :
	    tresd(535,25,625,40,1,0,CYAN);putstring(540,28,"Play");
	    while (c!='x')
	    {
	     setfillstyle(SOLID_FILL,BLACK);
	     bar(8,7,252,182);
	     ES=(D+1)%4; DI=D-1;
	     if (DI<0) DI=3;
	     for (I=0;I<4;I++)
	     {
	      EE = MAT[Y+I*DY[D]+DY[ES]][X+I*DX[D]+DX[ES]];
	      DE = MAT[Y+I*DY[D]+DY[DI]][X+I*DX[D]+DX[DI]];
	      FE = MAT[Y+(1+I)*DY[D]][X+(1+I)*DX[D]];
	      movimentacao(I+1);
	      if (FE!='1') break;
	    }
	    c=getch();
	    if (c==0) c=getch();

	    if (c==77) { D=D-1; if(D<0) D=3; }
	    if (c==75) { D=D+1; if(D==4) D=0; }
	    if ((c==72)&&(MAT[Y+DY[D]][X+DX[D]]=='1')) { X=X+DX[D];Y=Y+DY[D];c=75; }
	    if (tolower(c)=='s') mapa();
	    if (c==27)
	      {//Janela do jogo
		janela(0,0,260,190,2,6,6,6,6,CYAN);
		break ; }
	   }
	   break;
   case 1 :
	    tresd(535,45,625,60,1,0,CYAN);putstring(540,48,"Edit");
	    delay(500);
	    tresd(535,45,625,60,1,1,CYAN);putstring(540,48,"Edit");
	    break;
   case 2 : tresd(535,65,625,80,1,0,CYAN);putstring(540,68,"Help");
	    ajuda();
	    break;
   case 3 : tresd(535,85,625,100,1,0,CYAN);putstring(540,88,"Abort");
	    fim=TRUE;
	    delay(1000);
	    break;
   }
 }
 closegraph();exit(0);
}

void movimentacao(int x)
{
 float yaux=10,xaux=15;

 setfillstyle(SOLID_FILL,WHITE);
 switch (x)
  {
   case 1:
	  if (EE!='0')
	   {line (10,153,46,153);line (46,153,46,27);line (46,27,10,27); }
	  else
	   {line (10,180,46,153);line (46,153,46,27);line (46,27,10,7); }

	  if (DE!='0')
	   {line (246,153,210,153);line (210,153,210,27);line (210,27,246,27); }
	  else
	   {line (246,180,210,153);line (210,153,210,27);line (210,27,246,7); }

	  if (FE=='0')
	   rectangle (46,27,210,153);
	  else
	   if (FE=='S') bar (46,27,210,153);

	  return;

   case 2:
	  if (EE!='0')
	   {line (46,130,76,130);line (76,130,76,50);line (76,50,46,50); }
	  else
	   {line (46,153,76,130);line (76,130,76,50);line (76,50,46,27); }

	  if (DE!='0')
	   {line (210,130,180,130);line (180,130,180,50);line (180,50,210,50); }
	  else
	   {line (210,153,180,130);line (180,130,180,50);line (180,50,210,27); }

	  if (FE=='0')
	   rectangle (76,50,180,130);
	  else
	   if (FE=='S') bar (76,50,180,130);

	  return;

   case 3:
	  if (EE!='0')
	   {line (76,114,96,114);line (96,114,96,66);line (96,66,76,66); }
	  else
	   {line (76,130,96,114);line (96,114,96,66);line (96,66,76,50); }

	  if (DE!='0')
	   {line (180,114,160,114);line (160,114,160,66);line (160,66,180,66); }
	  else
	   {line (180,130,160,114);line (160,114,160,66);line (160,66,180,50); }

	  if (FE=='0')
	   rectangle (96,66,160,114);
	  else
	   if (FE=='S') bar (96,66,160,114);

	  return;

   case 4:
	  if (EE!='0')
	   {line (96,107,106,107);line (106,107,106,75);line (106,75,96,75); }
	  else
	   {line (96,114,106,107);line (106,107,106,75);line (106,75,96,66); }

	  if (DE!='0')
	   {line (160,107,150,107);line (150,107,150,75);line (150,75,160,75); }
	  else
	   {line (160,114,150,107);line (150,107,150,75);line (150,75,160,66); }

	  if (FE=='0')
	   rectangle (106,75,150,107);
	  else
	   if (FE=='S') bar (106,75,150,107);
	    else
	     {
	      setcolor(WHITE);
	      outtextxy(126,86,"?");
	     }

	  return;

   case 5:
	  if (EE!='0')
	   {line (106,103,111,103);line (111,103,111,80);line (111,80,106,80); }
	  else
	   {line (106,107,111,103);line (111,103,111,80);line (111,80,106,75); }

	  if (DE!='0')
	   {line (150,103,145,103);line (145,103,145,80);line (145,80,150,80); }
	  else
	   {line (150,107,145,103);line (145,103,145,80);line (145,80,150,75); }

	  if (FE=='0')
	   rectangle (111,80,145,103);
	  else
	   if (FE=='S') bar (111,80,145,103);
	    else
	     {
	      setcolor(WHITE);
	      settextstyle(SMALL_FONT,HORIZ_DIR,1);
	      outtextxy(126,86,"?");
	      settextstyle(DEFAULT_FONT,HORIZ_DIR,1);
	     }
	  return;
  }
}

void mapa()
{
  char straux[2];
  int a=0,b=0,x=290,y=10;

  janela(262,0,524,190,2,6,6,6,6,CYAN);

  for (a=0 ;a<=19;a++)
   {
    for (b=0;b<26;b++)
     {
      if (MAT[a][b]=='0') straux[0]='Û';
      if (MAT[a][b]=='1') straux[0]=' ';
      if ((b==X)&&(a==Y)) straux[0]='o';
      if (MAT[a][b]=='S') straux[0]='S';

      straux[1]='\0';
      outtextxy(x,y,straux);
      x+=8;
     }
    y+=8;
    x=290;
   }
 getch();
 setfillstyle(SOLID_FILL,BLACK);
 bar(262,0,524,190);

 refresh();
}

void ajuda()
{
 setcolor(WHITE);
 janela(262,0,524,190,2,6,6,6,6,CYAN);

 settextstyle(TRIPLEX_FONT,HORIZ_DIR,3);
 outtextxy(270,15," HELP !");
 outtextxy(270,60, " ARROWS TO :");
 outtextxy(270,85, "   MOVE");
 outtextxy(270,110," PRESS [S] TO: ");
 outtextxy(270,130,"   MAP");
 settextstyle(DEFAULT_FONT,HORIZ_DIR,1);

 getch();
 setfillstyle(SOLID_FILL,BLACK);
 bar(262,0,524,190);
}

void refresh()
{
 drawcheck(440,85,GREEN);
 drawcheck(434,87,RED);
 drawcheck(428,89,YELLOW);

 setlinestyle(SOLID_LINE,0,2);

 settextstyle(BOLD_FONT,HORIZ_DIR,3);
 putstring(270,25,"LABIRINT");
 settextstyle(DEFAULT_FONT,HORIZ_DIR,1);

 tresd(530,20,630,180,1,0,CYAN);
 tresd(535,105,625,175,2,0,CYAN);
 //Botoes (simulados)
 tresd(535,25,625,40,1,1,CYAN);putstring(540,28,"Play");
 tresd(535,45,625,60,1,1,CYAN);putstring(540,48,"Edit");
 tresd(535,65,625,80,1,1,CYAN);putstring(540,68,"Help");
 tresd(535,85,625,100,1,1,CYAN);putstring(540,88,"Abort");
}

void draw_textura(int parxi,int paryi,int xf,int yf)
{
 int a=126,b=80,xi,yi; // a & b controlam o centro do efeito
 setcolor(DARKGRAY);
 for (xi=parxi;xi<xf;xi+=5)
  for (yi=paryi;yi<yf;yi+=5)
   line (xi,yi,a,b);
}