//----------------------------------------------------------------------
// Labirint (prototipo)
//  Versao original BASIC MSX - Alessander P. Oliveira 26/08/1987-88
//  Nova adaptacao BorlandC   - Alessander P. Oliveira 10/03/1994
//----------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <graphics.h>
#include <ctype.h>
#include <dos.h>

#define TRUE 1
#define FALSE 0

void mapa(void);
void movimentacao(int);
void tresd(int xi,int yi,int xf,int yf,int rad,int prof,int cor);
void janela(int xi,int yi,int xf,int yf,int radius,int norte,int leste,int sul,int oeste,int cor);


//Variaveis globais ------------------------------------------------

static  int  DX[4];DY[4];
static  int  P=0,X=2,Y=2,D,I,J;
static char MAT[20][26];
static char DE,EE,FE;

//Bloco Principal --------------------------------------------------

void main (void)
{
 char stick=0;
  int ES,DI=0;
  int GraphDriver=DETECT,GraphMode;

 initgraph(&GraphDriver,&GraphMode,"");

 //Meu nome
 tresd(0,195,525,225,2,1,CYAN);
 tresd(5,198,258,222,2,0,CYAN);
 settextstyle(DEFAULT_FONT,HORIZ_DIR,1);
 setcolor(WHITE);outtextxy(10,207,"by ALESSANDER PIRES OLIVEIRA          P r o t o t i p o  !!!");
 setcolor(BLACK);outtextxy(9,206,"by ALESSANDER PIRES OLIVEIRA          P r o t o t i p o  !!!");

 //Janela do jogo
 janela(0,0,260,190,2,6,6,6,6,CYAN);
 //Janela do mapa
 janela(262,0,524,190,2,6,6,6,6,CYAN);


 DX[0]=1;    DX[1]=0;  DX[2]=-1;  DX[3]=0;
 DY[0]=0;   DY[1]=-1;  DY[2]=0 ;  DY[3]=1;

 //ESPECIAL > Labirinto pre-montado (apenas para teste)
 strcpy(MAT[ 0],"0000000000000000000000000");//Nao pode ser utilizada
 strcpy(MAT[ 1],"0101110011100111000111100");
 strcpy(MAT[ 2],"0101011010111101000100100");
 strcpy(MAT[ 3],"0111001110100001000100100");
 strcpy(MAT[ 4],"0000001000100111111111100");
 strcpy(MAT[ 5],"0111111111100100010000100");
 strcpy(MAT[ 6],"0101001000000100011111110");
 strcpy(MAT[ 7],"0101111111000100010000100");
 strcpy(MAT[ 8],"0100001001000111111000100");
 strcpy(MAT[ 9],"0111111111111101001111100");
 strcpy(MAT[10],"0101001000100101001000100");
 strcpy(MAT[11],"0101001111111101001011100");
 strcpy(MAT[12],"0101001000100101001010100");
 strcpy(MAT[13],"0101111000111111111011110");
 strcpy(MAT[14],"0101001000000100010000010");
 strcpy(MAT[15],"0111001001000100010000000");
 strcpy(MAT[16],"0001111111111111111111110");
 strcpy(MAT[17],"0000000000000000000000010");
 strcpy(MAT[18],"00000000000000000000000S0");//Nao e conveniente usar esta linha

 //Coordenadas iniciais do jogador (x,y)
 X=1;Y=1;
 //Lado para o qual ele saira' virado
 D=3;//0-LESTE 1-NORTE 2-OESTE 3-SUL

 while (stick!=27)
 {
  //Limpa a area do labirinto
  setfillstyle(SOLID_FILL,BLACK);bar(8,7,252,182);

  ES=(D+1)%4;
  DI=D-1;
  if (DI<0) DI=3;

  for (I=0;I<4;I++)
  {
   EE = MAT[Y+I*DY[D]+DY[ES]][X+I*DX[D]+DX[ES]];
   DE = MAT[Y+I*DY[D]+DY[DI]][X+I*DX[D]+DX[DI]];
   FE = MAT[Y+(1+I)*DY[D]][X+(1+I)*DX[D]];
   movimentacao(I+1);
   if (FE!='1') break;
  }
  stick=getch();if(stick==0)stick=getch();

  if (stick==77) { D=D-1; if(D<0) D=3; }
  if (stick==75) { D=D+1; if(D==4) D=0; }
  if ((stick==72)&&(MAT[Y+DY[D]][X+DX[D]]=='1')) { X=X+DX[D]; Y=Y+DY[D]; }
  if (stick=='i') { setlinestyle(DOTTED_LINE,1,1); }
  if (stick=='v') { setlinestyle(SOLID_LINE,1,1); }
  mapa();
 }

 closegraph();exit(0);
}

void movimentacao(int x)
{
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
	     { setcolor(WHITE); outtextxy(126,86,"?"); }
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
	      settextstyle(SMALL_FONT,HORIZ_DIR,1);
	      setcolor(WHITE);outtextxy(126,86,"?");
	      settextstyle(DEFAULT_FONT,HORIZ_DIR,1);
	     }
	  return;
  }
}

void mapa()
{
 char straux[2];
 int x=290,y=10;

 setfillstyle(SOLID_FILL,BLACK);
 bar(282,15,504,160);

 for (register int a=0 ;a<=19;a++)
  {
   for (register int b=0;b<26;b++)
    {
     if (MAT[a][b]=='0') straux[0]='Û';
     if (MAT[a][b]=='1') straux[0]=' ';
     if ((b==X)&&(a==Y))
      {//0-LESTE 1-NORTE 2-OESTE 3-SUL
       switch(D)
	{
	 case 1: straux[0]='';break;
	 case 0: straux[0]='>';break;
	 case 3: straux[0]='';break;
	 case 2: straux[0]='<';break;
	}
       }
     if (MAT[a][b]=='S') straux[0]='S';

     straux[1]='\0';
     if (straux[0]=='*') setcolor(WHITE);
     else setcolor(DARKGRAY);
     outtextxy(x,y,straux);
     x+=8;
    }
   y+=8;
   x=290;
  }
 setcolor(WHITE);
}

//Funcoes para Desenho de plataformas ------------------------------

void janela(int xi,int yi,int xf,int yf,int radius,int norte,int leste,int sul,int oeste,int cor)
{
  int aux;

  setfillstyle(SOLID_FILL,cor);
  bar(xi,yi,xf,yf);

  setcolor(WHITE);
  for(aux=0;aux<radius;aux++) line(xi+aux,yi+aux,xf-aux,yi+aux);
  for(aux=0;aux<radius;aux++) line(xi+aux,yi+aux,xi+aux,yf-aux);
  setcolor(DARKGRAY);
   for(aux=0;aux<radius;aux++) line(xi+aux,yf-aux,xf-aux,yf-aux);
   for(aux=0;aux<radius;aux++) line(xf-aux,yi+aux,xf-aux,yf-aux);

  setfillstyle(SOLID_FILL,BLACK);
  bar(xi+oeste,yi+(norte-1),xf-leste,yf-(sul-1));

  setcolor(DARKGRAY);
   for(aux=0;aux<radius;aux++)
    line((xi+oeste)+aux,(yi+(norte-1))+aux,(xf-leste)-aux,(yi+(norte-1))+aux);
   for(aux=0;aux<radius;aux++)
    line((xi+oeste)+aux,(yi+(norte-1))+aux,(xi+oeste)+aux,(yf-(sul-1))-aux);

  setcolor(WHITE);
   for(aux=0;aux<radius;aux++)
    line((xi+oeste)+aux,(yf-(sul-1))-aux,(xf-leste)-aux,(yf-(sul-1))-aux);
   for(aux=0;aux<radius;aux++)
    line((xf-leste)-aux,(yi+(norte-1))+aux,(xf-leste)-aux,(yf-(sul-1))-aux);
}

void tresd(int xi,int yi,int xf,int yf,int rad,int prof,int cor)
{
  int aux,color1,color2;

  setfillstyle(SOLID_FILL,cor);
  bar(xi,yi,xf,yf);

  if (prof==1) { color1=WHITE;color2=DARKGRAY; }
    else { color1=DARKGRAY;color2=WHITE; }

  setcolor(color1);
  for(aux=0;aux<rad;aux++)
    line(xi+aux,yi+aux,xf-aux,yi+aux);
  setcolor(color1);
  for(aux=0;aux<rad;aux++)
    line(xi+aux,yi+aux,xi+aux,yf-aux);
  setcolor(color2);
  for(aux=0;aux<rad;aux++)
    line(xi+aux,yf-aux,xf-aux,yf-aux);
  setcolor(color2);
  for(aux=0;aux<rad;aux++)
    line(xf-aux,yi+aux,xf-aux,yf-aux);
}