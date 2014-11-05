{$E+,N+}
{


+-------------------------------------------------------------------------+
¦   TOOL.PAS                                                              ¦
¦-------------------------------------------------------------------------¦
¦   Beinhaltet einige nützliche Funktionen und Prozeduren, die aufgrund   ¦
¦   ihrer Allgemeingültigkeit nicht irgend einer anderen Unit zugerechnet ¦
¦   werden können.                                                        ¦
¦   Viele dieser Funktionen kommen aus dem Clipper-Sprachumfang.          ¦
Ã-------------------------------------------------------------------------Â
¦   History: 24.02.92  Aeg  Verfassen des Moduls                          ¦
¦            03.02.93  Aeg  Pad-Funktionen zugefügt                       ¦
¦            03.02.93  Aeg  Num2Str-Fkt.   zugefügt                       ¦
¦            08.09.93  Aeg  WinDel zugefügt                               ¦
¦            12.01.94  Aeg  ByteLongInt-Fkt.   zugefügt                   ¦
¦            25.11.96  Naz  Bedeutungslos0Loeschen ()                     ¦
¦            21.03.97  JO   Num2DMStr                                     ¦
¦            15.06.09  SH   Konvertierung in Delphi                       ¦
¦            11.11.11  SH   Unix-Timestamp-Konvertierung                  ¦
¦            30.11.11  SH   Unix-Timestamp gibt es in DateUtils!!!        ¦
¦            10.12.12  SH   Funktion PfadZipErmitteln zugefügt            ¦
¦            04.03.14  SH   Funktion explode hinzugefügt                  ¦
+-------------------------------------------------------------------------+
}
Unit Tool;

{
   +-------------------------------------------------------------------+
+-------------------------------------------------------------------------+
¦                            INTERFACE                                    ¦
+-------------------------------------------------------------------------+
   +-------------------------------------------------------------------+
}
Interface
Uses  Windows, dialogs, StrUtils;
{
+-------------------------------------------------------------------------+
¦  Interface                  TYPEN                                       ¦
+-------------------------------------------------------------------------+
}
type ArrCh256 = Array [1..256] of Char;
type TSTringdynarray = array of String;

{
+-------------------------------------------------------------------------+
¦  Interface            PROZEDUREN UND FUNKTIONEN                         ¦
+-------------------------------------------------------------------------+
}
(*
function GetConInputHandle : THandle;
function GetConOutputHandle : THandle;
procedure GotoXY(X, Y : Word);
*)
{
 +------------------------------------------------------------------------+
 ¦ Procedure rpsort(var a: array of String)                               ¦
 ¦                                                                        ¦
 ¦ sortiert Archivdokumente absteigend nach Datum                         ¦
 +------------------------------------------------------------------------+
}
Procedure rpsort(var a: array of String);

{
 +------------------------------------------------------------------------+
 ¦ Procedure CustomWriteLN(S: String)                                     ¦
 ¦                                                                        ¦
 ¦ wandelt alle ANSI-Strings in ASCII um                                  ¦
 +------------------------------------------------------------------------+
}
//Procedure CustomWriteLN(S: String);
{
 +------------------------------------------------------------------------+
 ¦ Procedure fSplit(var PathNam,DirNam,FilNam,ExtNam:String)              ¦
 ¦                                                                        ¦
 ¦ (alte Pascal-Prozedur)                                                 ¦
 ¦ zerlegt einen vollständigen Dateinamen in seine drei Komponenten       ¦
 +------------------------------------------------------------------------+
}

Procedure fSplit(var PathNam,DirNam,FilNam,ExtNam:ShortString);

Function PfadErmitteln (AnlNam: string) : string;
function PfadZipErmitteln(const AnlNam: String): String;

{
 +------------------------------------------------------------------------+
 ¦ Function ByteLongInt (Ein: Byte)                                       ¦
 ¦                                                                        ¦
 ¦ Rückgabe: LongInt                                                      ¦
 +------------------------------------------------------------------------+
}
Function  ByteLongInt (Ein: Byte): LongInt;

{
 +------------------------------------------------------------------------+
 ¦ Function Real_Int (Rl: Real): Integer                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Real als Integer codiert, indem nach Punktentfernung         ¦
 ¦           der String in Integer umgewandelt wurde.                     ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
Function  Real_Int (Rl: Real): Integer;
Function  Real_Long (Rl: Real): longInt;
{
 +------------------------------------------------------------------------+
 ¦ Function Comp_LongInt (Rl: Comp): LongInt                              ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Cpmp als LongInt codiert, indem nach Punktentfernung         ¦
 ¦           der String in Integer umgewandelt wurde.                     ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
Function  Comp_LongInt (Rl: Comp): LongInt;
Function  ZeichErsetzen (Ein: String; ZeichEin, ZeichAus: char): String;


{
 +------------------------------------------------------------------------+
 ¦ Function AllTrim (Ein: String)                                         ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String von führende und nachfolg. Leerstellen befreien.  ¦
 +------------------------------------------------------------------------+
}
Function  AllTrim (Ein: String): String;

{
 +------------------------------------------------------------------------+
 ¦ Function RTrim (Ein: String)                                           ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String von nachfolgenden Leerstellen befreien.           ¦
 +------------------------------------------------------------------------+
}
Function  RTrim (Ein: String): String;

{
 +------------------------------------------------------------------------+
 ¦ Function PadC (Ein: String; Breite: Word; Zeichen: Char)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String, links und rechts gleichmäßig mit 'Zeichen' auf   ¦
 ¦           die 'Breite' aufgefüllt.                                     ¦
 ¦           Ist der Eingabestring Länger als 'Breite', wird er rechts    ¦
 ¦           auf 'Breite' gekürzt.                                        ¦
 ¦ Bsp:      PadC ('abc', 7, '-')        -> '--abc--'                     ¦
 ¦           PadC ('abcdefghi', 6, '-')  -> 'abcdef'                      ¦
 +------------------------------------------------------------------------+
}
Function  PadC (Ein: String; Breite: Word; Zeichen: Char): String;

{
 +------------------------------------------------------------------------+
 ¦ Function PadR (Ein: String; Breite: Word; Zeichen: Char)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String, rechts mit 'Zeichen' auf die 'Breite' aufgefüllt.¦
 ¦           Ist der Eingabestring Länger als 'Breite', wird er rechts    ¦
 ¦           auf 'Breite' gekürzt.                                        ¦
 ¦ Bsp:      PadR ('abc', 6, '-')        -> 'abc---'                      ¦
 ¦           PadR ('abcdefghi', 6, '-')  -> 'abcdef'                      ¦
 +------------------------------------------------------------------------+
}
Function  PadR (Ein: String; Breite: Word; Zeichen: Char): String;

{
 +------------------------------------------------------------------------+
 ¦ Function PadL (Ein: String; Breite: Word; Zeichen: Char)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String, links mit 'Zeichen' auf die 'Breite' aufgefüllt. ¦
 ¦           Ist der Eingabestring Länger als 'Breite', wird er rechts    ¦
 ¦           auf 'Breite' gekürzt.                                        ¦
 ¦ Bsp:      PadL ('abc', 6, '-')        -> '---abc'                      ¦
 ¦           PadL ('abcdefghi', 6, '-')  -> 'abcdef'                      ¦
 +------------------------------------------------------------------------+
}
Function  PadL (Ein: String; Breite: Word; Zeichen: Char): String;

{
 +------------------------------------------------------------------------+
 ¦ Function Empty (var Ein)                                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn String leer bzw nur mit Blanks.                   ¦
 +------------------------------------------------------------------------+
}

Function  Empty (Ein: string): Boolean;
{
 +------------------------------------------------------------------------+
 ¦ Function  Space (Anzahl: Byte):  String;                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: 'Anzahl' Leerzeichen in einem String.                        ¦
 +------------------------------------------------------------------------+
}
Function  Space (Anzahl: Byte):  String;

{
 +------------------------------------------------------------------------+
 ¦ Function  Str2Num (Ein: String): longint                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Das, was VAL zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  Str2Num (Ein: String): longint;
{
 +------------------------------------------------------------------------+
 ¦ Function  Str3Num (Ein: String): integer                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Das, was VAL zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  Str3Num (Ein: String): integer;

{
 +------------------------------------------------------------------------+
 ¦ Function  W2ZeroStr (Ein: Word; Stellen: Byte): String;                    ¦
 ¦           'Word nach String'                                           ¦
 ¦ Rückgabe: Das, was STR zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  W2ZeroStr (Ein: Word; Stellen: Byte):  String;

{
 +------------------------------------------------------------------------+
 ¦ Function  W2Str (Ein: Word; Stellen: Byte): String;                    ¦
 ¦           'Word nach String'                                           ¦
 ¦ Rückgabe: Das, was STR zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  W2Str (Ein: Word; Stellen: Byte):  String;

{
 +------------------------------------------------------------------------+
 ¦ Function  Num2Str (Num:Comp; VKS, NKS: Byte):String                    ¦
 ¦           'Numerisch nach String'                                      ¦
 ¦ Rückgabe: Das Integer als String mit Dezimalpunkt, 'VKS' Vorkomma-     ¦
 ¦           und 'NKS' Nachkommastellen.                                  ¦
 ¦ Bsp:      Num2Str (12345, 5, 2)  -->  '  123.45'                       ¦
 +------------------------------------------------------------------------+
}
Function  Num2Str (Num:Comp; VKS, NKS: Byte):String;
{
 +------------------------------------------------------------------------+
 ¦ Function  Num2KommaStr (Num:Comp; VKS, NKS: Byte):String                    ¦
 ¦           'Numerisch nach String'                                      ¦
 ¦ Rückgabe: Das Integer als String mit Dezimalpunkt, 'VKS' Vorkomma-     ¦
 ¦           und 'NKS' Nachkommastellen.                                  ¦
 ¦ Bsp:      Num2Str (12345, 5, 2)  -->  '  123,45'                       ¦
 +------------------------------------------------------------------------+
}
Function  Num2KommaStr (Num:Comp; VKS, NKS: Byte):String;

Function  Num2DMStr (Num:Comp   ; VKS, NKS: Byte):String;

{
 +------------------------------------------------------------------------+
 ¦ Function  Num2ZeroStr (Num:Comp; Breite: Byte):String                  ¦
 ¦           Numerisch nach String mit '0' statt vorausgehenden ' '       ¦
 ¦ Rückgabe: Das Integer als String mit führenden '0' in der Breite       ¦
 ¦           'Breite'                                                     ¦
 ¦ Bsp:      Num2ZeroStr (12345, 10)  -->  '0000012345'                   ¦
 +------------------------------------------------------------------------+
}
Function  Num2ZeroStr (Num:Comp; Breite: Byte):String;

{
 +------------------------------------------------------------------------+
 ¦ Function ToUpper (Ein: String)                                         ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String in Großbuchstaben.                                ¦
 +------------------------------------------------------------------------+
}
Function ToUpper (Ein: String): String;

{
 +------------------------------------------------------------------------+
 ¦ Function Center  (Ein: String; AnzStellen: Byte)                       ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String zentriert in einem AnzStellen langen String.      ¦
 +------------------------------------------------------------------------+
}
Function Center (Ein: String; AnzStellen: Byte): String;

{
 +------------------------------------------------------------------------+
 ¦ Function Rep  (Ein: char; Anzahl:integer): String;                      ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Ein Anzahl mal wiederholt als String.                        ¦
 ¦ Bsp:      Rep  ('*', 6)  -> '******'                                   ¦
 +------------------------------------------------------------------------+
}
Function  Rep (Ein: char; Anzahl: integer): String;

{
 +------------------------------------------------------------------------+
 ¦ Function Min (A, B: Word)                                              ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Minimum von A und B                                          ¦
 +------------------------------------------------------------------------+
}
Function  Min (A,B: Word): Word;

{
 +------------------------------------------------------------------------+
 ¦ Function Max (A, B: Word)                                              ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Maximum von A und B                                          ¦
 +------------------------------------------------------------------------+
}
Function  Max (A,B: Word): Word;

{
 +------------------------------------------------------------------------+
 ¦ Procedure NormalText                                                   ¦
 ¦                                                                        ¦
 ¦ Normale Textausgabe, d.h. Hintergrd Schwarz, Vordergrd weiß.           ¦
 +------------------------------------------------------------------------+
}
//Procedure NormalText;

{
 +------------------------------------------------------------------------+
 ¦ Procedure InversText                                                   ¦
 ¦                                                                        ¦
 ¦ Invertiert die Textausgabe, d.h. Hintergrd hellgrau, Vordergrd schwarz.¦
 +------------------------------------------------------------------------+
}
//Procedure InversText;

{
 +------------------------------------------------------------------------+
 ¦ Procedure Linie (l,o,r,u: Byte; Einfach: Boolean);                     ¦
 ¦                                                                        ¦
 ¦ Gibt im aktuellen Fenster eine Linie aus, horizontal oder Vertikal,    ¦
 ¦ im Textmodus. 'Einfach' bestimmt, ob einfache (true) oder doppelte     ¦
 ¦ Linien gezeichnet werden.                                              ¦
 +------------------------------------------------------------------------+
}
//Procedure Linie (l,o,r,u: Byte; Einfach: Boolean);

{
 +------------------------------------------------------------------------+
 ¦ Procedure Box (l,o,r,u: Byte; Einfach: Boolean);                       ¦
 ¦                                                                        ¦
 ¦ Gibt im aktuellen Fenster eine Box aus, im Textmodus.                  ¦
 ¦ Einfach bestimmt, ob die Linien einfach oder doppelt gezogen werden.   ¦
 +------------------------------------------------------------------------+
}
//Procedure Box (l,o,r,u: Byte; Einfach: Boolean);

{
 +------------------------------------------------------------------------+
 ¦ Function GetHeuteDat                                                   ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Aktuelles Datum im Format 'TTMMJJ'                           ¦
 +------------------------------------------------------------------------+
}
Function  GetHeuteDat: LongInt;

function datumHeute: String;
{
 +------------------------------------------------------------------------+
 ¦ Function  DatStr                                                       ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Aktuelles Datum im Format 'TT/MM/JJ'                         ¦
 +------------------------------------------------------------------------+
}
Function  DatStr: String;

{
 +------------------------------------------------------------------------+
 ¦ Function  DatString()                                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Datum im Format 'TT.MM.JJ'                                   ¦
 +------------------------------------------------------------------------+
}
Function  DatString(Dat: string): String;
Function  DatBlank(Dat: string): String;
{
 +------------------------------------------------------------------------+
 ¦ Function  DatString()                                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Datum im Format 'TT/MM/JJ'                                   ¦
 +------------------------------------------------------------------------+
}

Function  DatStrStrich(Dat: string): String;
Function  DatStringMonat(Dat: string): String;

{
 +------------------------------------------------------------------------+
 ¦ Function  TimeStr                                                      ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Aktuelle Zeit im Format 'SS:MM'                              ¦
 +------------------------------------------------------------------------+
}
Function  TimeStr: String;

{
 +------------------------------------------------------------------------+
 ¦ Function DatVorhanden (DosName: String)                                ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn das File mit dem übergebenen Namen vorhanden ist. ¦
 +------------------------------------------------------------------------+
}
Function  DatVorhanden (DosName: String): Boolean;

{
 +------------------------------------------------------------------------+
 ¦ Function MyRound  (XVar: Extended): LongInt                            ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Gerundeter Wert. Bei .5 wird auf höheren Absolutwert         ¦
 ¦           gerundet.                                                    ¦
 +------------------------------------------------------------------------+
}
Function  MyRound ( XVar: Extended): LongInt;

{
 +------------------------------------------------------------------------+
 ¦ Function MyRound2Comp (XVar: Extended): Comp                           ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Gerundeter Wert. Bei .5 wird auf höheren Absolutwert         ¦
 ¦           gerundet. Rückgabewert ist Comp (!!)                         ¦
 +------------------------------------------------------------------------+
}
Function  MyRound2Comp ( XVar: Extended): Comp;

{
 +------------------------------------------------------------------------+
 ¦ Function CharArray2Str (var FirstChar: Char; Len : Word)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Die Zeichen aus CharArray in einem String, der Len Bytes (+1)¦
 ¦           lang ist.                                                    ¦
 +------------------------------------------------------------------------+
}
Function  CharArray2Str (var FirstChar: Char; Len : Word): String;

{
 +------------------------------------------------------------------------+
 ¦ Procedure Wait (sec: Word);                                            ¦
 ¦                                                                        ¦
 ¦ Wartet sec Sekunden lang.                                              ¦
 +------------------------------------------------------------------------+
}
Procedure Wait (sec:Word);

{
 +------------------------------------------------------------------------+
 ¦ Function IsNum (Ein: char): boolean                                    ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn Ein ein Numerisches-Zeichen ist ['0'-'9']         ¦
 +------------------------------------------------------------------------+
}
Function isNum (ein:char): boolean;

{
 +------------------------------------------------------------------------+
 ¦ Function IsAlpha (Ein: char): boolean                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn Ein ein Alpha-Zeichen ist [A-Z, a-z, ÄÖÜ, äöü, ß] ¦
 +------------------------------------------------------------------------+
}
Function IsAlpha (ein:char): boolean;

{
 +------------------------------------------------------------------------+
 ¦ Procedure Beep                                                         ¦
 ¦                                                                        ¦
 ¦ Gibt einen Beep aus. Benutzt  write (chr (7))                          ¦
 +------------------------------------------------------------------------+
}
Procedure Beep;

{
 +------------------------------------------------------------------------+
 ¦ Procedure WinDel                                                       ¦
 ¦                                                                        ¦
 ¦ Löscht einen Fensterausschnitt. Koordinaten auf 1,1,80,25 bezogen.     ¦
 +------------------------------------------------------------------------+
}
//Procedure WinDel (x1, y1, x2, y2: Byte);

{
 +------------------------------------------------------------------------+
 ¦ Procedure Int2ArrayChar (var Ein1,Ein2);                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Die Zeichen aus String in einem ArrayChar                    ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
Procedure Int2ArrayChar (var Ein1,Ein2);

{Bedeutungslose 0 loescht, die nach Komma stehen : 12.100 > 12.1 }
Function Bedeutungslos0Loeschen (Stand: string): string;
Procedure AnlAusdrSuchen (Pfad: string;var AnlExt: string);
Function Ansi2DosStr (var Ein): string;
Function Dos2AnsiStr (var Ein): string;
procedure AsciiToAnsi(var S: string);
procedure AnsiToAscii(var S: string);
function Ascii2Ansi(S : String) : String;
function Ansi2Ascii(S : String) : String;
function Utf8ToAscii(S: String): String;
Procedure LeseStrTrenn  (var Woher; var Poss: Word; var Wohin; var Tren:char);
//Procedure InStr(var Ein;Str2:string; AbStelle:byte);
Function  DatumKl (Anf, Ende : LongInt) : boolean;
function isNumeric(Ein : String):Boolean;

{
 +------------------------------------------------------------------------+
 ¦ Function validAnlnum(LNR : String)                                     ¦
 ¦                                                                        ¦
 ¦ Rückgabe: True, wenn es eine gültige Liegenschaftsnummer ist           ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
function validAnlnum(LNR : String): Boolean;


{
 +------------------------------------------------------------------------+
 ¦ Function DateTimeToUnix(ConvDate: TDateTime): Longint;                 ¦
 ¦                                                                        ¦
 ¦ Datum in Unix-Timestamp umwandeln                                      ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
//function DateTimeToUnix(ConvDate: TDateTime): Longint;

{
 +------------------------------------------------------------------------+
 ¦ Function UnixToDateTime(USec: Longint): TDateTime;                     ¦
 ¦                                                                        ¦
 ¦ Unix-Timestamp in Datum umwandeln                                      ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
//function UnixToDateTime(USec: Longint): TDateTime;

// zählt die Anzahl der Vorkommen des Buchstabens aChar in aString
function CountCharOccurrences(const aChar: Char; const aString: String): Integer;

// Format Byte Size to String
function FormatByteSize(const bytes: Longint): string;

{
 +------------------------------------------------------------------------+
 ¦ Function germanStrToDate(Datum: String): TDateTime;                    ¦
 ¦                                                                        ¦
 ¦ Deutsches Datumsformat (TT.MM.YY) in TDateTime umwandeln               ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
function germanStrToDate(Datum: String): TDateTime;
function germanStrToDateTime(Datum: String): TDateTime;

function Explode(const Separator, S: string; Limit: Integer = 0): TSTringdynarray;

{
   +-------------------------------------------------------------------+
+-------------------------------------------------------------------------+
¦                           IMPLEMENTATION                                ¦
+-------------------------------------------------------------------------+
   +-------------------------------------------------------------------+
}
Implementation
Uses SysUtils; //BTRV_BFW;//Crt, BTRV_BFW,IOScreen,IOScrDef;

const
  // Sets UnixStartDate to TDateTime of 01/01/1970
  UnixStartDate: TDateTime = 25569.0;
{
+-------------------------------------------------------------------------+
¦  Implementation       PROZEDUREN UND FUNKTIONEN                         ¦
+-------------------------------------------------------------------------+
}
function get2Kdate(jahr : String):String;
begin
    if (FormatDateTime('YY', Now) < jahr) and (StrToInt(jahr) > 50) then
        result := '19'+jahr
    else
        result := '20'+jahr;
end;

Procedure rpsort(var a: array of String);
    var i,j : Longint;
    h : string;
    v0, v1, v2: Integer;
    tmpTimeSeparator,
    tmpDateSeparator : Char;
    tmpShortDateFormat,
    tmpShortTimeFormat,
    tmpLongTimeFormat : String;
begin
    try
        // Workaround für Bug in Windows 7
//        tmpDateSeparator    := DateSeparator;
//        tmpShortDateFormat  := ShortDateFormat;
//        tmpTimeSeparator    := TimeSeparator;
//        tmpShortTimeFormat  := ShortTimeFormat;
//        tmpLongTimeFormat   := LongTimeFormat;
//
//        DateSeparator       := '.';
//        ShortDateFormat     := 'dd.mm.yyyy';
//        TimeSeparator       := ':';
//        ShortTimeFormat     := 'HH:mm';
//        LongTimeFormat      := 'HH:mm:ss';


        For i:= 0 To High(a) Do Begin
            h := a[i];
            j := i;

            v0 := Round(StrToDate(MidStr(a[i],34,8)));
            v1 := Round(StrToDate(MidStr(a[i],25,8)));
            v2 := Round(StrToDate(MidStr(a[i],15,8)));

            While (j > 0) and
                (Round(StrToDate(MidStr(a[j-1],34,8))) > v0) Do Begin
                a[j] := a[j-1];
                dec(j);
            End;

            While (j > 0) and
                (Round(StrToDate(MidStr(a[j-1],25,8))) > v1) Do Begin
                a[j] := a[j-1];
                dec(j);
            End;

            While (j > 0) and
                (Round(StrToDate(MidStr(a[j-1],15,8))) > v2) Do Begin
                a[j] := a[j-1];
                dec(j);
            End;

            a[j] := h;
        End;

(*
        bis := High(a);
        k   := bis shr 1;
        j1 := '';
        j2 := '';
        while k > 0 do
        begin
            for i := 0 to bis - k do
            begin
                j := i;
                // Anfangsjahr Abrechnung
                j1 := get2Kdate(MidStr(a[j], 40,2));
                j2 := get2Kdate(MidStr(a[j + k],40,2));
            
                if StrToInt(j2) > 50 then j2 := '19'+j2 else j2 := '20'+j2;
                while (j >= 0) and (StrToDate(MidStr(A[j], 15,8)) > StrToDate(MidStr(a[j + k], 15,8))) and (j1 >= j2) do begin
                    h := a[j]; a[j]:= a[j+k]; a[j+k] := h;
                    if j > k then Dec(j,k) else j := 0
                end
            end;
            k := k shr 1
        end;
*)
//
//        DateSeparator   := tmpDateSeparator;
//        ShortDateFormat := tmpShortDateFormat;
//        TimeSeparator   := tmpTimeSeparator;
//        ShortTimeFormat := tmpShortTimeFormat;
//        LongTimeFormat  := tmpLongTimeFormat;
    except
        on e:Exception do
            ShowMessage('Fehler in rpsort: '+ e.Message);
    end;
end;
//
//procedure CustomWriteLN(S: String);
//var
//  buf: String;
//begin
//  SetLength(buf, Length(S));
//  CharToOEM(PChar(S), PChar(buf));
//  WriteLN(buf);
//end;

procedure fSplit(var PathNam,DirNam,FilNam,ExtNam:ShortString);
begin
    DirNam := ExtractFilePath(PathNam);     // mit \ am Ende
    //DirNam := ExtractFileDir(PathNam);    // ohne \ am Ende
    FilNam := ExtractFileName(PathNam);
    FilNam := ChangeFileExt(FilNam,'');
    ExtNam := ExtractFileExt(PathNam);
end;

(*
//-----------------------------------------
// Get handle to console input
//-----------------------------------------
function GetConInputHandle : THandle;
begin
    Result := GetStdHandle(STD_INPUT_HANDLE)
end;
//-----------------------------------------
// Get handle to console output
//-----------------------------------------
function GetConOutputHandle : THandle;
begin
    Result := GetStdHandle(STD_OUTPUT_HANDLE)
end;

procedure GotoXY(X, Y : Word);
var ConHandle  : THandle; // Handle to console window
    Coord      : TCoord;  // To store/set screen position
begin
    ConHandle := GetConOutputHandle;
    Coord.X := X; Coord.Y := Y;
    SetConsoleCursorPosition(ConHandle, Coord);
end;
*)

function PfadErmitteln (AnlNam: string) : string;
     var  TextM,
          APfad,
          AName,
          Erw  :        string;
          nVerz,
          nNr:          longint;
     begin
          AName := copy (AnlNam,1,Pos('.',AnlNam)-1);
          Erw   := copy (AnlNam,Pos('.',AnlNam)+1,3);

          Nnr   := str2num (copy (AName, 3, 5));
          Nverz := (nnr div 20) + 1;
          APfad := 'B:\' + AName [1] + AName [2] + '\' + 'DAT' + padl (alltrim (Num2Str (Nverz, 5, 0))  ,5, '-');
          APfad := APfad + '\' + AName+'.' + Erw;
          if (AName<>'') and not FileExists(APfad) then begin
             TextM := 'Anlage '+APfad+' nicht auf dieser Diskette !';
             //ShowMessage (TextM);
             AName := '';
          end;

          if AName = '' then APfad := '';
          PfadErmitteln := APfad;

     end; {PfadErmitteln}

function PfadZipErmitteln(const AnlNam: String): String;
const Anlverz : String = '\\BFWKA\KUARCHIV\';
var datNam,
    ext,
    anlnr,
    KdNr: String;
begin
    Result  := '';

    // Dateiname ohne Pfad
    datNam  := ExtractFileName(AnlNam);

    // Erweiterung
    ext     := ExtractFileExt(datNam);
    anlnr   := Copy(datNam, 1, 7);

    //'Anlage '+datNam+' nicht auf dieser Diskette !';
    if NOT isNumeric(anlnr) then Exit;
    if Length(ext) <> 0 then ChangeFileExt(datNam, '.ZIP');

    KdNr    := copy(datNam,1,2);
    anlnr   := Copy(datNam,1,7);
    Result  := Anlverz + '\'+kdnr+'\'+anlnr+'\'+anlnr+'.ZIP'
end;     

//
//Procedure InStr(var Ein;Str2:string; AbStelle:byte);
//var i : byte;
//    Str1: ShortString absolute Ein;
//begin
//    for i := 1 to Length(Str2) do
//        Str1[AbStelle+i-1] := Str2[i];
//end;
{
 +------------------------------------------------------------------------+
 ¦ Function ByteLongInt (Ein: Byte)                                       ¦
 ¦                                                                        ¦
 ¦ Rückgabe: LongInt                                                      ¦
 +------------------------------------------------------------------------+
}
Function  ByteLongInt (Ein: Byte): LongInt;
   var Int : Integer;
   begin
       Int := Ein;
       ByteLongInt := Int;
   end;  {ByteLongInt}

{
 +------------------------------------------------------------------------+
 ¦ Function Real_Int (Rl: Real): Integer                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Real als Integer codiert, indem nach Punktentfernung         ¦
 ¦           der String in Integer umgewandelt wurde.                     ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
Function  Real_Int (Rl: Real): Integer;

   var  LI:       Integer;
   begin
     if Rl = 0 then LI := 0
     else begin
       LI := Round(Rl);
     end;
     Real_Int := LI;

   end; {Real_Int}

Function  Real_Long (Rl: Real): longInt;

   var	LI:       LongInt;
   begin
     if Rl = 0 then LI := 0
     else begin
       LI := Round(Rl);
     end;
     Real_Long := LI;

   end; {Real_Long}

{
 +------------------------------------------------------------------------+
 ¦ Function Comp_LongInt (Rl: Comp): LongInt                              ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Cpmp als LongInt codiert, indem nach Punktentfernung         ¦
 ¦           der String in Integer umgewandelt wurde.                     ¦
 ¦                                                                        ¦
 +------------------------------------------------------------------------+
}
Function  Comp_LongInt (Rl: Comp): LongInt;
   var  Code:	  Integer;
        H_Str:    String;
        LI:       LongInt;
        NKS_S:    String[1];
        NKS:      Integer;
   begin
     if Rl = 0 then LI := 0
     else
     begin
       Str    (Rl,H_Str);
       Delete (H_Str,1,1);
       NKS_S := Copy (H_Str, 22,1);
       Val (NKS_S, NKS, Code);
       H_Str := Copy (H_Str, 1, NKS + 2);
       Delete (H_Str,2,1);

       Val (H_Str,LI,Code);
       if Code <> 0 then LI := 0;
     end;
     Comp_LongInt := LI;

   end; {Comp_LongInt}

{**********************}
Function  ZeichErsetzen (Ein: String; ZeichEin, ZeichAus: char): String;
   var ilauf : integer;
   begin
        for ilauf := 1 to Length (Ein) do begin
            if Ein [ilauf] = zeichEin then
               Ein [ilauf] := zeichAus;
        end;
        ZeichErsetzen := Ein;
   end; {  () }
{
 +------------------------------------------------------------------------+
 ¦ Function AllTrim (Ein: String)                                         ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String von führende und nachfolg. Leerstellen befreien.  ¦
 +------------------------------------------------------------------------+
}
Function AllTrim (Ein: String): String;
(*
   begin
        While (Ein [1] = ' ') and (Length (Ein) > 0) do
              Delete (Ein, 1, 1);
        While (Ein [Length (Ein)] = ' ') and (Length (Ein) > 0) do
              Delete (Ein, Length (Ein), 1);
        AllTrim := Ein;
   end; { AllTrim () }
*)
	begin
	   Ein := Trim(Ein);
       Alltrim := Ein;
	end;
   (*	begin
    	Ein := Trim(Ein);
    	Alltrim := Dos2AnsiStr(Ein);
    end;	{ AllTrim () }*)
{
 +------------------------------------------------------------------------+
 ¦ Function RTrim (Ein: String)                                           ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String von nachfolgenden Leerstellen befreien.           ¦
 +------------------------------------------------------------------------+
}
Function  RTrim (Ein: String): String;
   var  DummyChar : Char;
   begin
        Result := Ein;
        if Length(Ein) = 0 then Exit;

        DummyChar := Ein[Length (Ein)];
        While (Length (Ein) > 0) and
              ((DummyChar = ' ') or (DummyChar = Chr (255))) do
        begin
			Delete (Ein, Length (Ein), 1);
            if length(Ein) <> 0 then DummyChar := Ein [Length (Ein)];
        end;
        Rtrim := Ein;
   end; { RTrim () }

{
 +------------------------------------------------------------------------+
 ¦ Function PadC (Ein: String; Breite: Word; Zeichen: Char)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String, links und rechts gleichmäßig mit 'Zeichen' auf   ¦
 ¦           die 'Breite' aufgefüllt.                                     ¦
 ¦           Ist der Eingabestring Länger als 'Breite', wird er rechts    ¦
 ¦           auf 'Breite' gekürzt.                                        ¦
 ¦ Bsp:      PadC ('abc', 7, '-')        -> '--abc--'                     ¦
 ¦           PadC ('abcdefghi', 6, '-')  -> 'abcdef'                      ¦
 +------------------------------------------------------------------------+
}
Function  PadC (Ein: String; Breite: Word; Zeichen: Char): String;
   var Laenge, Zaehler, Haelfte: Word;

   begin
       Laenge := Length (Ein);
       if Laenge < Breite
       then begin
                 Haelfte := (Breite - Laenge) div 2;
                 For Zaehler := 1 to Haelfte do Ein := Zeichen + Ein + Zeichen;
                 if Length (Ein) < Breite then Ein := Ein + Zeichen;
            end
       else delete (Ein, Breite+1, Laenge-Breite);
       PadC := Ein;
   end;

{
 +------------------------------------------------------------------------+
 ¦ Function PadR (Ein: String; Breite: Word; Zeichen: Char)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String, rechts mit 'Zeichen' auf die 'Breite' aufgefüllt.¦
 ¦           Ist der Eingabestring Länger als 'Breite', wird er rechts    ¦
 ¦           auf 'Breite' gekürzt.                                        ¦
 ¦ Bsp:      PadR ('abc', 6, '-')        -> 'abc---'                      ¦
 ¦           PadR ('abcdefghi', 6, '-')  -> 'abcdef'                      ¦
 +------------------------------------------------------------------------+
}
Function  PadR (Ein: String; Breite: Word; Zeichen: Char): String;
   var Laenge, Zaehler: Word;
   begin
       Laenge := Length (Ein);
       if Laenge < Breite
       then For Zaehler := Laenge + 1 to Breite do Ein := Ein + Zeichen
       else delete (Ein, Breite+1, Laenge-Breite);
       PadR := Ein;
   end;

{
 +------------------------------------------------------------------------+
 ¦ Function PadL (Ein: String; Breite: Word; Zeichen: Char)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String, links mit 'Zeichen' auf die 'Breite' aufgefüllt. ¦
 ¦           Ist der Eingabestring Länger als 'Breite', wird er rechts    ¦
 ¦           auf 'Breite' gekürzt.                                        ¦
 ¦ Bsp:      PadL ('abc', 6, '-')        -> '---abc'                      ¦
 ¦           PadL ('abcdefghi', 6, '-')  -> 'abcdef'                      ¦
 +------------------------------------------------------------------------+
}
Function  PadL (Ein: String; Breite: Word; Zeichen: Char): String;
   var Laenge, Zaehler: Word;
   begin
       Laenge := Length (Ein);
       if Laenge < Breite
       then For Zaehler := Laenge + 1 to Breite do Ein := Zeichen + Ein
       else delete (Ein, Breite+1, Laenge-Breite);
       PadL := Ein;
   end;

{
 +------------------------------------------------------------------------+
 ¦ Function Rep  (Ein: char; Anzahl:integer): String;                      ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Ein Anzahl mal wiederholt als String.                        ¦
 ¦ Bsp:      Rep  ('*', 6)  -> '******'                                   ¦
 +------------------------------------------------------------------------+
}

Function Rep(Ein: char; Anzahl: integer): string;
	begin
        Rep := StringOfChar(Ein, Anzahl);
	end;

{
 +------------------------------------------------------------------------+
 ¦ Function Min (A, B: Word)                                              ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Minimum von A und B                                          ¦
 +------------------------------------------------------------------------+
}
Function  Min (A,B: Word): Word;
	begin
    	if A>B then Min := B
        	else Min := A;
	end;

{
 +------------------------------------------------------------------------+
 ¦ Function Max (A, B: Word)                                              ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Maximum von A und B                                          ¦
 +------------------------------------------------------------------------+
}
Function  Max (A,B: Word): Word;
	begin
    	if A<B then Max := B
        	else Max := A;
    end;

{
 +------------------------------------------------------------------------+
 ¦ Function Empty (var Ein)                                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn String leer bzw nur mit Blanks.                   ¦
 +------------------------------------------------------------------------+
}
Function  Empty (Ein : string): Boolean;
	begin
    	if Length(Trim(Ein)) = 0
        then Empty := true
        else Empty := false;
    end; { Empty }

{
 +------------------------------------------------------------------------+
 ¦ Function  Space (Anzahl: Byte):  String;                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: 'Anzahl' Leerzeichen in einem String.                        ¦
 +------------------------------------------------------------------------+
}
Function  Space (Anzahl: Byte):  String;
	begin
    	Space := Rep(' ', Anzahl);
    end;	{ Space () }

{
 +------------------------------------------------------------------------+
 ¦ Function  Str2Num (Ein: String): longint                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Das, was VAL zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  Str2Num (Ein: String): longint;
   var c: integer;
       l: longint;
   begin
        val (alltrim(Ein), l, c);
        if c<>0 then l:=0;
        Str2Num := l;
   end;
{
 +------------------------------------------------------------------------+
 ¦ Function  Str3Num (Ein: String): integer                               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Das, was VAL zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  Str3Num (Ein: String): integer;
   var c: integer;
       l: integer;
   begin
        val (alltrim(Ein), l, c);
        if c<>0 then l:=0;
        Str3Num := l;
   end;
{
 +------------------------------------------------------------------------+
 ¦ Function  W2ZeroStr (Ein: Word; Stellen: Byte): String;                    ¦
 ¦           'Word nach String'                                           ¦
 ¦ Rückgabe: Das, was STR zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  W2ZeroStr (Ein: Word; Stellen: Byte):  String;
   var Aus:    String;
   begin
        str (Ein, Aus);
        while length (Aus) < Stellen do Aus := '0'+Aus;
        W2ZeroStr := Aus;
   end;

{
 +------------------------------------------------------------------------+
 ¦ Function  W2Str (Ein: Word; Stellen: Byte): String;                    ¦
 ¦           'Word nach String'                                           ¦
 ¦ Rückgabe: Das, was STR zurückliefern würde, doch als Returnwert.       ¦
 +------------------------------------------------------------------------+
}
Function  W2Str (Ein: Word; Stellen: Byte):  String;
   var Aus:    String;
   begin
        str (Ein, Aus);
        while length (Aus) < Stellen do Aus := Aus + ' ';
        W2Str := Aus;
   end;

{
 +------------------------------------------------------------------------+
 ¦ Function  Num2DMStr (Num:LongInt; VKS, NKS: Byte):String               ¦
 ¦           'Numerisch nach DMString'                                    ¦
 ¦ Rückgabe: Das Integer als String mit Dezimalpunkt, 'VKS' Vorkomma-     ¦
 ¦           und 'NKS' Nachkommastellen und 1000 DM Punkten               ¦
 ¦ Bsp:      Num2DMStr (1234567, 3, 2)  -->  '  12.345,67'                ¦
 +------------------------------------------------------------------------+
}
Function  Num2DMStr (Num:Comp   ; VKS, NKS: Byte):String;
   var Zaehler: Word;
       RetS:    String;
   begin
        Str (Num:VKS+NKS:0, RetS);
        if NKS > 0 then Insert (',', RetS, VKS+1);
        if RetS [VKS] = ' ' then RetS [VKS] := '0';

        Zaehler := VKS + 2;
        while (Zaehler < VKS+NKS+1) and (RetS [Zaehler] = ' ') do
        begin
             RetS [Zaehler] := '0';
             Zaehler := Zaehler + 1;
        end;
        if abs(Num) >= 100000 then Insert ('.', RetS, VKS-2);
        if abs(Num) >= 100000000 then Insert ('.', RetS, VKS-5);
        Rets:=copy(Rets,Length(Rets)-VKS-NKS,Length(Rets));

        Num2DMStr := RetS;

   end; { Num2DMStr }
{
 +------------------------------------------------------------------------+
 ¦ Function  Num2Str (Num:LongInt; VKS, NKS: Byte):String                ¦
 ¦           'Numerisch nach String'                                      ¦
 ¦ Rückgabe: Das Integer als String mit Dezimalpunkt, 'VKS' Vorkomma-     ¦
 ¦           und 'NKS' Nachkommastellen.                                  ¦
 ¦ Bsp:      Num2Str (12345, 3, 2)  -->  '  123.45'
 ' 53.8968072                       ¦
 +------------------------------------------------------------------------+
}
Function  Num2Str (Num:Comp   ; VKS, NKS: Byte):String;
   var Zaehler: Word;
       RetS:    String;
   begin
        Str (Num:VKS+NKS:0, RetS);
        if NKS > 0 then begin
           if ((Length(Alltrim(RetS)) < NKS)   and (Num > 0)) then
               for zaehler := VKS+1 to VKS+NKS do
                   if RetS [zaehler] = ' ' then RetS [zaehler] := '0';
           if ((Length(Alltrim(RetS)) < NKS+1) and (Num < 0)) then begin
               for zaehler := VKS+1 to VKS+NKS do
                   if (RetS [zaehler]=' ') or (RetS [zaehler]='-') then RetS [zaehler]:='0';
               RetS [VKS] := '-';
           end;
           if (Length(Alltrim(RetS)) = VKS+NKS+1)
           then Insert ('.', RetS, VKS+2)
           else Insert ('.', RetS, VKS+1);
           if (Num < 0) and (RetS[VKS] = '-') then Insert ('0', RetS, VKS+1);
        end;
        if RetS [VKS] = ' ' then RetS [VKS] := '0';

        if (Num < 0) and (Length(RetS) > (VKS+NKS+1)) and (RetS[1] = ' ') then
           Delete (RetS,1,1);

        Zaehler := VKS + 2;
        while (Zaehler < VKS+NKS+1) and (RetS [Zaehler] = ' ') do
        begin
             RetS [Zaehler] := '0';
             Zaehler := Zaehler + 1;
        end;
        Num2Str := RetS;
   end; { Num2Str }
{
 +------------------------------------------------------------------------+
 ¦ Function  Num2KommaStr (Num:LongInt; VKS, NKS: Byte):String                ¦
 ¦           'Numerisch nach String'                                      ¦
 ¦ Rückgabe: Das Integer als String mit Dezimalpunkt, 'VKS' Vorkomma-     ¦
 ¦           und 'NKS' Nachkommastellen.                                  ¦
 ¦ Bsp:      Num2KommaStr (12345, 3, 2)  -->  '  123,45'                       ¦
 +------------------------------------------------------------------------+
}
Function  Num2KommaStr (Num:Comp   ; VKS, NKS: Byte):String;
   var Zaehler: Word;
       RetS:    String;
   begin
        Str (Num:VKS+NKS:0, RetS);
        if NKS > 0 then begin
           if ((Length(Alltrim(RetS)) < NKS)   and (Num > 0)) then
               for zaehler := VKS+1 to VKS+NKS do
                   if RetS [zaehler] = ' ' then RetS [zaehler] := '0';
           if ((Length(Alltrim(RetS)) < NKS+1) and (Num < 0)) then begin
               for zaehler := VKS+1 to VKS+NKS do
                   if (RetS [zaehler]=' ') or (RetS [zaehler]='-') then RetS [zaehler]:='0';
               RetS [VKS] := '-';
           end;
           if (Length(Alltrim(RetS)) = VKS+NKS+1)
           then Insert (',', RetS, VKS+2)
           else Insert (',', RetS, VKS+1);
           if (Num < 0) and (RetS[VKS] = '-') then Insert ('0', RetS, VKS+1);
        end;
        if RetS [VKS] = ' ' then RetS [VKS] := '0';

        if (Num < 0) and (Length(RetS) > (VKS+NKS+1)) and (RetS[1] = ' ') then
           Delete (RetS,1,1);

        Zaehler := VKS + 2;
        while (Zaehler < VKS+NKS+1) and (RetS [Zaehler] = ' ') do
        begin
             RetS [Zaehler] := '0';
             Zaehler := Zaehler + 1;
        end;
        Num2KommaStr := RetS;
   end; { Num2Str }

{
 +------------------------------------------------------------------------+
 ¦ Function  Num2ZeroStr (Num:Comp; Breite: Byte):String                  ¦
 ¦           Numerisch nach String mit '0' statt vorausgehenden ' '       ¦
 ¦ Rückgabe: Das Integer als String mit führenden '0' in der Breite       ¦
 ¦           'Breite'.                                                    ¦
 ¦ Bsp:      Num2ZeroStr (12345, 10)  -->  '0000012345'                   ¦
 +------------------------------------------------------------------------+
}
Function  Num2ZeroStr (Num:Comp; Breite: Byte):String;
//var RetS: String;
begin
    {
    Str (Num:1:0, RetS);
    while Length (RetS) < Breite do RetS := '0' + RetS;
    Result := RetS;
    }
    Result := Format('%.'+IntToStr(Breite)+'d',[Round(Num)]);
end; { Num2ZeroStr }

{
 +------------------------------------------------------------------------+
 ¦ Function ToUpper (Ein: String)                                         ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String in Großbuchstaben.                                ¦
 +------------------------------------------------------------------------+
}
Function ToUpper (Ein: String): String;
	begin
	    ToUpper := AnsiUpperCase(Ein);
	end; { ToUpper }

{
 +------------------------------------------------------------------------+
 ¦ Function Center  (Ein: String; AnzStellen: Byte)                       ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Den String zentriert in einem AnzStellen langen String.      ¦
 +------------------------------------------------------------------------+
}
Function Center (Ein: String; AnzStellen: Byte): String;
    var  DummyStr: String;
    begin
         if Length (Ein) >= AnzStellen then
            Center := Ein
         else
         begin
              DummyStr := Space ( (AnzStellen-Length(Ein)) div 2);
              Center   := DummyStr + Ein + DummyStr;
         end;
    end; { Center }

{
 +------------------------------------------------------------------------+
 ¦ Procedure InversText                                                   ¦
 ¦                                                                        ¦
 ¦ Invertiert die Textausgabe, d.h. Hintergrd hellgrau, Vordergrd schwarz.¦
 +------------------------------------------------------------------------+

Procedure InversText;
          begin TextColor (0); TextBackground (7); end;

{
 +------------------------------------------------------------------------+
 ¦ Procedure NormalText                                                   ¦
 ¦                                                                        ¦
 ¦ Normale Textausgabe, d.h. Hintergrd Schwarz, Vordergrd weiß.           ¦
 +------------------------------------------------------------------------+

Procedure NormalText;
          begin TextColor (15); TextBackground (0); end;

{
 +------------------------------------------------------------------------+
 ¦ Procedure Linie (l,o,r,u: Byte; Einfach: Boolean);                     ¦
 ¦                                                                        ¦
 ¦ Gibt im aktuellen Fenster eine Linie aus, horizontal oder Vertikal,    ¦
 ¦ im Textmodus. 'Einfach' bestimmt, ob einfache (true) oder doppelte     ¦
 ¦ Linien gezeichnet werden.                                              ¦
 +------------------------------------------------------------------------+
}
(*
Procedure Linie (l,o,r,u: Byte; Einfach: Boolean);
   var Zaehler: Byte;
       Zeichen: Char;
   begin
        if L<>R                            { horizontal }
        then begin
                  if Einfach then Zeichen := Chr(196) else Zeichen := Chr(205);
                  GotoXY (l,o);
                  For Zaehler := l to r do Write (Zeichen);
             end
        else                              { vertikal }
            begin
                  if Einfach then Zeichen := Chr(179) else Zeichen := Chr(186);
                  For Zaehler := o to u do
                  begin
                       GotoXY (l, Zaehler);  Write (Zeichen);
                  end;
             end;
   end; { Linie }
 *)

{
 +------------------------------------------------------------------------+
 ¦ Procedure Box (l,o,r,u: Byte; Einfach: Boolean);                       ¦
 ¦                                                                        ¦
 ¦ Gibt im aktuellen Fenster eine Box aus, im Textmodus.                  ¦
 ¦ Einfach bestimmt, ob die Linien einfach oder doppelt gezogen werden.   ¦
 +------------------------------------------------------------------------+
}
(*
Procedure Box (l,o,r,u: Byte; Einfach: Boolean);
   var Zaehler: Byte;
   begin
        Linie (l,o,r,o, Einfach);
        Linie (l,u,r,u, Einfach);
        Linie (l,o,l,u, Einfach);
        Linie (r,o,r,u, Einfach);
        if Einfach
        then begin GotoXY (l,o); Write (chr(218));
                   GotoXY (r,o); Write (chr(191));
                   GotoXY (r,u); Write (chr(217));
                   GotoXY (l,u); Write (chr(192));
             end

        else begin GotoXY (l,o); Write (chr(201));
                   GotoXY (r,o); Write (chr(187));
                   GotoXY (r,u); Write (chr(188));
                   GotoXY (l,u); Write (chr(200));
             end;
   end; { Box }
*)
{
 +------------------------------------------------------------------------+
 ¦ Function GetHeuteDat                                                   ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Aktuelles Datum im Format 'TTMMJJ'                           ¦
 +------------------------------------------------------------------------+
}
Function  GetHeuteDat: LongInt;
	begin
    	GetHeuteDat := StrToInt(FormatDateTime('ddmmyy', Date));
    end;	{ GetHeuteDat }

function datumHeute: String;
begin
    Result := FormatDateTime('dd.mm.yy', Now);
end;

{
 +------------------------------------------------------------------------+
 ¦ Function  DatStr                                                       ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Aktuelles Datum im Format 'TT/MM/JJ'                         ¦
 +------------------------------------------------------------------------+
}
Function  DatStr: String;
   begin
         DatStr := FormatDateTime('dd''/''mm''/''yy', Date);
   end; { DatStr }

{
 +------------------------------------------------------------------------+
 ¦ Function  DatTrenn()                                                   ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Trennt Datumsstring in gewünschtes Format					 ¦
 +------------------------------------------------------------------------+
}
Function DatTrenn(Dat, Trenn: String): String;
	begin
    	if length (Dat) = 5 then Dat := '0' + Dat;
		insert (Trenn,Dat,3); insert (Trenn,Dat,6);
		DatTrenn := Dat;
    end;

{
 +------------------------------------------------------------------------+
 ¦ Function  DatString()                                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Datum im Format 'TT.MM.JJ'                                   ¦
 +------------------------------------------------------------------------+
}
Function  DatString(Dat: string): String;
	begin
    	DatString	:= DatTrenn(Dat, '.');
    end;	{ DatString }

{
 +------------------------------------------------------------------------+
 ¦ Function  DatString()                                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Datum im Format 'TTMMJJ'                                   ¦
 +------------------------------------------------------------------------+
}
Function  DatBlank(Dat: string): String;
	begin
    	Result	:= DatTrenn(Dat, '');
    end;	{ DatString }


{
 +------------------------------------------------------------------------+
 ¦ Function  DatStrStrich()                                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Datum im Format 'TT/MM/JJ'                                   ¦
 +------------------------------------------------------------------------+
}
Function  DatStrStrich(Dat: string): String;
   begin
        DatStrStrich := DatTrenn(Dat, '/');
   end; 	{ DatStrStrich }

{
 +------------------------------------------------------------------------+
 ¦ Function  DatStringMonat()                                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Datum im Format 'TT Monat JJJJ'                                   ¦
 +------------------------------------------------------------------------+
}
Function  DatStringMonat(Dat: string): String;
   begin
        if length (Dat) = 5 then Dat := '0' + Dat;
        insert ('.',Dat,3); insert ('.20',Dat,6);
        DatStringMonat := FormatDateTime('dd. mmmm yyyy', strtodate(Dat));
   end; { DatStringMonat }
    
{
 +------------------------------------------------------------------------+
 ¦ Function  TimeStr                                                      ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Aktuelle Zeit im Format 'SS:MM'                              ¦
 +------------------------------------------------------------------------+
}
Function  TimeStr: String;
   begin
        TimeStr := FormatDateTime('hh:nn',Now);
   end; { TimeStr }

{
 +------------------------------------------------------------------------+
 ¦ Function DatVorhanden (DosName: String)                                ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn das File mit dem übergebenen Namen vorhanden ist. ¦
 +------------------------------------------------------------------------+
}
Function  DatVorhanden (DosName: String): Boolean;
   var Gef: TSearchRec;
   		DosError : Integer;
   begin
        DosError := FindFirst (DosName, faArchive, Gef);
        if (DosError = 0) {or (DosError = 18)} then DatVorhanden := true
                                             else DatVorhanden := false;
   end; { DatVorhanden }

{
 +------------------------------------------------------------------------+
 ¦ Function MyRound  (XVar: Extended): LongInt                            ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Gerundeter Wert. Bei .5 wird auf höheren Absolutwert         ¦
 ¦           gerundet.                                                    ¦
 +------------------------------------------------------------------------+
}
Function  MyRound ( XVar: Extended): LongInt;
   var Truncwert : LongInt;
       Rest      : Real;
   begin
        TruncWert := Trunc (XVar);
        Rest      := XVar - TruncWert;
        if (Rest = 0.5) or (Rest = -0.5)
        then XVar := XVar + Rest/5;        { bei Pos Zahlen wird 0.1 zuaddiert,
                                             bei negativen wird 0.1 subtrahiert }
        MyRound := Round (XVar);
   end; { MyRound }

{
 +------------------------------------------------------------------------+
 ¦ Function MyRound2Comp (XVar: Extended): Comp                           ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Gerundeter Wert. Bei .5 wird auf höheren Absolutwert         ¦
 ¦           gerundet. Rückgabewert ist Comp (!!)                         ¦
 +------------------------------------------------------------------------+
}
Function  MyRound2Comp ( XVar: Extended): Comp;
   var CVar      : Comp;
   begin
        CVar := XVar;
        if (XVar > 0) then
        begin
             if (XVar - CVar) >= 0.5 then CVar := CVar + 1
             else
                if (XVar - CVar) < -0.5 then CVar := CVar - 1;
        end
        else
        begin
             if (XVar - CVar) > 0.5 then CVar := CVar + 1
             else
                if (XVar - CVar) <= -0.5 then CVar := CVar - 1;
        end;

        MyRound2Comp := CVar;
   end; { MyRound }

{
 +------------------------------------------------------------------------+
 ¦ Function CharArray2Str (var FirstChar: Char; Len : Word)               ¦
 ¦                                                                        ¦
 ¦ Rückgabe: Die Zeichen aus CharArray in einem String, der Len Bytes (+1)¦
 ¦           lang ist.                                                    ¦
 +------------------------------------------------------------------------+
}
Function  CharArray2Str (var FirstChar: Char; Len : Word): String;
   var Zaehler  : Byte;
       MaxLen   : Word;
       Str      : String;
       CharArray: Array [1..256] of Char absolute FirstChar;
   begin
       MaxLen := Min (Word (Len), Word (255));
       Str    := '';
       for Zaehler := 1 to MaxLen do Str := Str + CharArray [Zaehler];
       CharArray2Str := Str;
   end; { CharArray2Str () }


{
 +------------------------------------------------------------------------+
 ¦ Procedure Wait (sec: Word);                                            ¦
 ¦                                                                        ¦
 ¦ Wartet sec Sekunden lang.                                              ¦
 +------------------------------------------------------------------------+
}
Procedure Wait (sec:Word);
   type Zeittyp = record
                       St, Min, Sec, Sec100: Word;
                  end;
   var T:        Zeittyp;
       Anfang,
       Ende:     LongInt;
   begin
        DecodeTime(now, T.St, T.Min, T.Sec, T.Sec100);
        Anfang := T.St * 3600 +  T.Min * 60 + T.Sec;
        Ende   := Anfang;
        while Ende-Anfang < sec do
        begin
             DecodeTime(now, T.St, T.Min, T.Sec, T.Sec100);
             Ende  := T.St * 3600 +  T.Min * 60 + T.Sec;
        end;
   end; { Wait }

{
 +------------------------------------------------------------------------+
 ¦ Function IsNum (Ein: char): boolean                                    ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn Ein ein Numerisches-Zeichen ist ['0'-'9']         ¦
 +------------------------------------------------------------------------+
}
function isNum (ein:char): boolean;
    begin if ('0' <= ein) and ('9' >= ein)
          then isNum := true
          else isNum := false;
    end;

{
 +------------------------------------------------------------------------+
 ¦ Function IsAlpha (Ein: char): boolean                                  ¦
 ¦                                                                        ¦
 ¦ Rückgabe: true, wenn Ein ein Alpha-Zeichen ist [A-Z, a-z, ÄÖÜ, äöü, ß] ¦
 +------------------------------------------------------------------------+
}
function IsAlpha (ein:char): boolean;
   begin if (('A' <= ein) and ('Z' >= ein))
         or (('a' <= ein) and ('z' >= ein))
         or ('Ž' = ein) or ('™' = ein) or ('š' = ein)
         or ('„' = ein) or ('”' = ein) or ('' = ein)
         or ('á' = ein)

         then isAlpha := true
         else isAlpha := false;
   end;

{
 +------------------------------------------------------------------------+
 ¦ Procedure Beep                                                         ¦
 ¦                                                                        ¦
 ¦ Gibt einen Beep aus. Benutzt  write (chr (7))                          ¦
 +------------------------------------------------------------------------+
}
Procedure Beep;
   begin
        write (chr(7));
   end;

{
 +------------------------------------------------------------------------+
 ¦ Procedure WinDel                                                       ¦
 ¦                                                                        ¦
 ¦ Löscht einen Fensterausschnitt. Koordinaten auf 1,1,80,25 bezogen.     ¦
 +------------------------------------------------------------------------+
}
(*
Procedure WinDel (x1, y1, x2, y2: Byte);
   var altx1, altx2, alty1, alty2: Byte;
   begin
        altx1 := Lo (WindMin)+1;
        alty1 := Hi (WindMin)+1;
        altx2 := Lo (WindMax)+1;
        alty2 := Hi (WindMax)+1;

        window (x1, y1, x2, y2);
        clrscr;
        window (altx1, alty1, altx2, alty2);
   end;
 *)

Procedure Int2ArrayChar (var Ein1,Ein2);
  var
     Num      : Smallint absolute Ein1;
     ArrChar  : array [1..4] of char absolute Ein2;
     DummyStr : Shortstring;
  begin
     DummyStr := Num2Zerostr(Num,4);
     //Str2Char (DummyStr, ArrChar [1], SizeOf (ArrChar));
  end;

{
 +------------------------------------------------------------------------+
 ¦ Function Bedeutungslos0Loeschen                                        ¦               ¦
 ¦                                                                        ¦
 ¦ Löscht am Ende eines Strings '.0'										¦
 +------------------------------------------------------------------------+
}
Function Bedeutungslos0Loeschen (Stand: string): string;
     var
          PunktPos,
          Laenge,
          zaehler	   : integer;
          StandN       : string;
     begin
          StandN := Alltrim(Stand);
          PunktPos := Pos('.', StandN);
          Laenge := Length (StandN);
          if Laenge = 0 then StandN := '0';
          if PunktPos > 0 then
             for zaehler := Laenge downto PunktPos+1 do
                if StandN[zaehler] = '0' then StandN[zaehler] := ' '
                else break;
          StandN := Alltrim(StandN);
          PunktPos := Pos('.', StandN);
          Laenge := Length (StandN);
          if Laenge = PunktPos then Delete (StandN,PunktPos,1);

          Bedeutungslos0Loeschen := StandN;

     end; {Bedeutungslos0Loeschen}

{**********************************************}
{**********************************************}
Procedure AnlAusdrSuchen (Pfad: string;var AnlExt: string);
var
   DummyW1,DummyW2 : word;
   SU,Code: integer;
   SRec            : TSearchRec;
   DummyStr        : string;
   DosError		   : Integer;
begin
     SU := 0; DummyW1 := 0; DummyW2 := 0;
     DosError := FindFirst (Pfad + '*.*', faArchive, SRec);
     while DosError = 0 do begin
         dummyStr := copy (SRec.Name,10,3);
         Val(DummyStr,DummyW2,Code);
         DummyW1 := Max (DummyW1,DummyW2);
         SU := SU + 1;
         FindNext (SRec);
     end;
     SU := SU + 1;
     if (SU < DummyW1) or (SU = DummyW1) then SU := DummyW1 + 1;
     AnlExt := Num2ZeroStr(SU,3);
end;


{**************************}
Procedure Ansi2DosChar   (var EinChar: Char);
begin
    if ord(EinChar) = 196 then EinChar := #142; // Ä
    if ord(EinChar) = 214 then EinChar := #153; // Ö
    if ord(EinChar) = 220 then EinChar := #154; // Ü
    if ord(EinChar) = 228 then EinChar := #132; // ä
    if ord(EinChar) = 246 then EinChar := #148; // ö
    if ord(EinChar) = 252 then EinChar := #129; // ü
    if ord(EinChar) = 223 then EinChar := #225; // ß
end;

Function Ansi2DosStr    (var Ein) : string;
var ilauf,Wieviel : integer;
    Ch            : Char;
    EinStr        : String;
    Quelle        : ShortString absolute Ein;
begin
    EinStr := Trim(Quelle);
    Wieviel := Length (EinStr);
    For ilauf := 1 to Wieviel do begin
        Ch := EinStr[ilauf];
        Ansi2DosChar (Ch);
        EinStr[ilauf] := Ch;
    end;
    Ansi2DosStr := EinStr;
end;


{**************************}
Procedure Dos2AnsiChar   (var EinChar: Char);
begin
    if EinChar = '³' then EinChar := 'ü';
    if EinChar = '_' then EinChar := 'Ü';
    if EinChar = 'õ' then EinChar := 'ä';
    if EinChar = '-' then EinChar := 'Ä';
    if EinChar = '÷' then EinChar := 'ö';
    if EinChar = 'Í' then EinChar := 'Ö';
    if EinChar = '¯' then EinChar := 'ß';
end;

Function Dos2AnsiStr(var Ein): string;
var ilauf,Wieviel : integer;
    Ch            : Char;
    EinStr        : String;
    Quelle        : ShortString absolute Ein;
begin
    EinStr := (Quelle);
    Wieviel := Length (EinStr);
    For ilauf := 1 to Wieviel do begin
        Ch := EinStr[ilauf];
         Dos2AnsiChar (Ch);
         EinStr[ilauf] := Ch;
    end;
    Dos2AnsiStr := EinStr;
end;

procedure AsciiToAnsi(var S: string);
begin
  OemToCharBuff(Pointer(S), Pointer(S), Length(S));
end;

procedure AnsiToAscii(var S: string);
begin
  CharToOemBuff(Pointer(S), Pointer(S), Length(S));
end;

function Ascii2Ansi(S: string) : String;
begin
  Result := '';
  if OemToCharBuff(Pointer(S), Pointer(S), Length(S)) then Result := S;
end;

function Ansi2Ascii(S: string) : String;
begin
  Result := '';
  if CharToOemBuff(Pointer(S), Pointer(S), Length(S)) then Result := S;
end;

function Utf8ToAscii(S: String): String;
var n: String;
begin
    n := Utf8ToAnsi(S);
    Result := Ansi2Ascii(Utf8ToAnsi(S));
end;

Procedure LeseStrTrenn  (var Woher; var Poss: Word; var Wohin; var Tren:char);
   var
       Quelle      : String absolute Woher;
       Ziel        : String absolute Wohin;                  { entgültiger Bestimmungsort }
       MaxPos      : Word;

   begin
        Ziel   := '';
        MaxPos := SizeOf (Quelle);

        { Zeichen für Zeichen anhängen, bis Puffer 'ausgelesen' oder Trennzeichen '#FF' }
        While (Poss <= MaxPos) and (Quelle [Poss] <> Tren)
               and (Poss <= Length(Quelle))  do
        begin
             if Length (Ziel) <= 255 then
                Ziel := Ziel + Quelle [Poss];
                Poss := Poss + 1;
        end;

        { TrennZeichen überlesen }
        if (Poss < MaxPos) and (Quelle [Poss] = Tren) then
           Poss := Poss + 1;

        Ziel := AllTrim(Ziel);
   end; {LeseStrTren}

 {################################################ }
Function  DatumKl (Anf, Ende : LongInt) : boolean;
var
   Anf_S, Ende_S : string[6];
   Ja,Je,
   Ma,Me,
   Ta,Te,
   Code         : integer;

begin
    DatumKl:= false;
    Anf_S  := Num2ZeroStr (Anf,  6);
    Ende_S := Num2ZeroStr (Ende, 6);
    Val (Copy(Anf_S, 1,2), Ta, Code);
    Val (Copy(Ende_S,1,2), Te, Code);
    Val (Copy(Anf_S, 3,2), Ma, Code);
    Val (Copy(Ende_S,3,2), Me, Code);
    Val (Copy(Anf_S, 5,2), Ja, Code);
    Val (Copy(Ende_S,5,2), Je, Code);

    if Ja > 70 then Ja := Ja + 1900;
    if Je > 70 then Je := Je + 1900;
    if Ja < 71 then Ja := Ja + 2000;
    if Je < 71 then Je := Je + 2000;

    if Ja < Je
    then DatumKl := true
    else begin
            if Ja > Je
            then DatumKl:= false
            else if Ma < Me
                 then DatumKl := true
                 else begin
                         if Ma > Me
                         then DatumKl:= false
                         else if Ta < Te
                              then DatumKl := true
                              else DatumKl:= false;
                      end;
         end;

    if (Anf = 0) or (Ende = 0) then DatumKl:= false;

end;  {   }

function isNumeric(Ein : String):Boolean;
var V : Double;
    Code : Integer;
begin
    Result := False;
    val(Ein, V, Code);
    if Code = 0 then Result := True;    
end;

function validAnlnum(LNR : String): Boolean;
begin
    Result := False;
    if LNR = '' then Exit;
    if NOT isNumeric(LNR) then Exit;
    if Length(LNR) <> 7 then Exit;
    Result := True;    
end;

function DateTimeToUnix(ConvDate: TDateTime): Longint;
begin
  //example: DateTimeToUnix(now);
  try
      Result := Round((ConvDate - UnixStartDate) * 86400);
  except
      Result := -1;
  end;
end;

function UnixToDateTime(USec: Longint): TDateTime;
begin
  //Example: UnixToDateTime(1003187418);
  try
      Result := (Usec / 86400) + UnixStartDate;
  except
      Result := -1;
  end;
end;

// zählt die Anzahl der Vorkommen des Buchstabens aChar in aString
function CountCharOccurrences(const aChar: Char; const aString: String): Integer;
asm
  // Wenn edx 0 ist, abbrechen und 0 zurückgeben
  or edx, edx
  jnz @@ValidString
  xor eax, eax
  ret
  @@ValidString:

  // Register sichern
  push edi

  // in al ist bereits aChar drin, fehlt für scasb noch der zu scannende
  // String in edi
  mov edi, edx
  mov ecx, dword ptr [edx - $04]

  xor edx, edx // Zähler auf 0

  @@repeat:
  inc edx
  {$ifdef UNICODE}
  repne scasw
  {$else}
  repne scasb
  {$endif}
  jz @@repeat

  // Ergebnis zurückgeben
  dec edx
  mov eax, edx

  // Register wiederherstellen
  pop edi
end;

//Format file byte size
function FormatByteSize(const bytes: Longint): string;
const
    B = 1; //byte
    KB = 1024 * B; //kilobyte
    MB = 1024 * KB; //megabyte
    GB = 1024 * MB; //gigabyte
begin
    Result := '0 bytes';
    if bytes = 0 then exit;
    
    if bytes > GB then
        result := FormatFloat('#.## GB', bytes / GB)
    else
        if bytes > MB then
            result := FormatFloat('#.## MB', bytes / MB)
        else
            if bytes > KB then
                result := FormatFloat('#.## KB', bytes / KB)
            else
                result := FormatFloat('#.## bytes', bytes) ;
end;

function germanStrToDate(Datum: String): TDateTime;
var tmpTimeSeparator,
    tmpDateSeparator : Char;
    tmpShortDateFormat,
    tmpShortTimeFormat,
    tmpLongTimeFormat : String;
begin
    // Workaround für Bug in Windows 7
//    tmpDateSeparator    := DateSeparator;
//    tmpShortDateFormat  := ShortDateFormat;
//    tmpTimeSeparator    := TimeSeparator;
//    tmpShortTimeFormat  := ShortTimeFormat;
//    tmpLongTimeFormat   := LongTimeFormat;
//
//    DateSeparator       := '.';
//    ShortDateFormat     := 'dd.mm.yyyy';
//    TimeSeparator       := ':';
//    ShortTimeFormat     := 'HH:mm';
//    LongTimeFormat      := 'HH:mm:ss';

    if Pos('.', Datum) > 0 then
        Result := StrToDate(Datum)
    else
        Result := StrToDate(LeftStr(Datum, 2)+'.'+MidStr(Datum, 3, 2)+'.'+RightStr(Datum, 2));
//
//    DateSeparator       := tmpDateSeparator;
//    ShortDateFormat     := tmpShortDateFormat;
//    TimeSeparator       := tmpTimeSeparator;
//    ShortTimeFormat     := tmpShortTimeFormat;
//    LongTimeFormat      := tmpLongTimeFormat;
end;

function germanStrToDateTime(Datum: String): TDateTime;
var tmpTimeSeparator,
    tmpDateSeparator : Char;
    tmpShortDateFormat,
    tmpShortTimeFormat,
    tmpLongTimeFormat : String;
begin
//    // Workaround für Bug in Windows 7
//    tmpDateSeparator := DateSeparator;
//    tmpShortDateFormat := ShortDateFormat;
//    tmpTimeSeparator :=  TimeSeparator;
//    tmpShortTimeFormat := ShortTimeFormat;
//    tmpLongTimeFormat := LongTimeFormat;
//
//    DateSeparator := '.';
//    ShortDateFormat := 'dd.mm.yyyy';
//    TimeSeparator := ':';
//    ShortTimeFormat := 'HH:mm';
//    LongTimeFormat := 'HH:mm:ss';

    if (Pos('.', Datum) > 0) AND (Pos(':', Datum) > 0) then
        Result := StrToDateTime(Datum)
    else
        Result := StrToDate(LeftStr(Datum, 2)+'.'+MidStr(Datum, 3, 2)+'.'+RightStr(Datum, 2));
//
//    DateSeparator := tmpDateSeparator;
//    ShortDateFormat := tmpShortDateFormat;
//    TimeSeparator :=  tmpTimeSeparator;
//    ShortTimeFormat := tmpShortTimeFormat;
//    LongTimeFormat := tmpLongTimeFormat;
end;

// Explode trennt S in die durch Separator getrennten Elemente auf. Wenn Limit
// > 0 ist, so werden max. Limit Elemente getrennt, wobei im letzen Element
// die Restzeichenkette steht.

function Explode(const Separator, S: string; Limit: Integer = 0): TSTringdynarray;
var
  SepLen: Integer;
  F, P: PChar;
  ALen, Index: Integer;
begin
  SetLength(Result, 0);
  if (S = '') or (Limit < 0) then Exit;
  if Separator = '' then
  begin
    SetLength(Result, 1);
    Result[0] := S;
    Exit;
  end;
  SepLen := Length(Separator);
  ALen := Limit;
  SetLength(Result, ALen);

  Index := 0;
  P := PChar(S);
  while P^ <> #0 do
  begin
    F := P;
    P := AnsiStrPos(P, PChar(Separator));
    if (P = nil) or ((Limit > 0) and (Index = Limit - 1)) then P := StrEnd(F);
    if Index >= ALen then
    begin
      Inc(ALen, 5);
      SetLength(Result, ALen);
    end;
    SetString(Result[Index], F, P - F);
    Inc(Index);
    if P^ <> #0 then Inc(P, SepLen);
  end;
  if Index < ALen then SetLength(Result, Index);
end;


End.
