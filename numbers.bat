::: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: #NumberMe.bat Version 1.9 .. put line numbers into Files or delete
::: #Numbering if found or/and/only delete all emty lines wiht or without spaces;
::: #help and progress of batch in german;
::: #[/?en] english short guide, bevor code in batch 1 line behind ::: [/?] Help ;
::: #Version 0.03 Placed into the Public Domain by Biber3@hotmail.de 15.08.2004;
::: #modified from 1.0 - 1.9 by pieh-ejdsch@o2online.de 13.06.2009 - 22.02.2011,
::: #last Versions: 0.03, 1.0, 1.0b thanks to bastla, 1.1 ... 1,9
::: #supportet by www.administrator.de ; Bugs or Updates? Please feedback!
::: #---Put in this code to Editor, save as "all-filetype" named NumberMe.cmd
::: #---For install on Win System: press [WIN]+[R] , then type: %windir%\system32
::: #---press Enter and put in this File to ExplorerWindow which has opened up
::: #---now this Application works in Batch; CMD or [WIN]+[R] by typing this
::: #---BatchName(.cmd) with or without Extension.---------------------------------
::: #------------------------------------------------------------------------------
::: [/?] Help german only, but here is an english short guide for You;
::: Sourcefilename must be the first Option. All other Options from second till
::: sixth can be in much differrent array. Dubbel dot in Options can be lost.
::: Options include no space to string together as /N-/Q/Z  -or Seperately or other
::: sourcefilename for working batch always be needed, without target-path-filename only output on Screen;
::: [/f] for aktion in sourcefile or in target-path-filename
::: [/n:1] one-figure numbering with Automated PreZeroNumbering (1-7, 0001-4702)
::: (for example: [/n:5] not less than five-figure numbering-> 00001-00120);
::: [/n:0] setting for without PreZero (1-245);
::: [/n:-] deletes a numbered consecutively before space or Piont if found it
::: - or is it used to test for -> gives exitcode 5;
::: without [/n:] Auto PreZeroNumbering with not less than two-figure number just   like [/n:2];
::: - only with [/n:] setting for without Numbering;
::: if you substitute [/N:] by [/L:] NumberMe will not be delete all empty lines,
::: syntax (behind dubble dot) takes effekt like than [/N:]; 
::: [/l:-] Denumbering without cleaning empty Lines; 
::: [/Z:] change delimiter: space by point; or behind : Input other Delimiter(s)
::: to include Spaces or additional characters after delimiter ->Syntax must insert
::: between quotation marks for denumbering and incluce string to remove for,
::: -> be sure in string 1st and the last sign is not a number
::: ->be sure in string the last sign exist once;
::: [/Q] Quit modus: no Program message; been related works with E [/QE]
::: [/E] Quit modus: no Error message; been related works with Q [/EQ]
::: > Spaces for Path-File-Name or additional characters must insert between        quotation marks;
::: > if source(path)name is equal to target(path)name NumberMe will be effect all
::: > in sourcefile and without Options [/Z] [/N|/L] [only deletes all empty lines;
::: > additional characters only displayed  false on Screen; 
::: output from sourcefile: number of all Lines and all empty Lines;
::: Programm messages Piped into the Handle 3
::: Error messages Piped into the handle 2
::: -------------------------------------------------------------------------------
::: EXITCODES: [0] successful; [1] put in filename; [2] sourcefile not found;
::: [3] input incorrect Syntax; [4] file is empty;
::: [5] file is not numbered consecutively; [6] file is without empty lines only
::: [7] file is with empty lines only;
::; :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off & setlocal disabledelayedexpansion
for %%i in ("pN=2" "b=" "b2=" "E=" "Q=" "Full=0" "noempty=0" "Zahlen=" "D=" "emptylines=" "erropt=" "NN=" "pOut=" "put=" "yes=1" "orig=" "vpn=" "nodel=" "Zeichen= " "noemptyLines=" "LL=" "L=" "O=" "um=" "F=") do set "%%~i"
::Syntaxpruefung: Quelle, Ziel, De- oder Nummerierung
:Parameter
set "Opt="%1""
setlocal enabledelayedexpansion
if "!Opt!" == """" ( endlocal&goto :Paraend) else set "Opt=!Opt:"=!"
if "!Opt!" == "/?" endlocal&goto :help
for %%i in ("/" "/help" ) do if /i "!Opt!"=="%%~i" endlocal&goto :help
if /i "!Opt!"=="/?en" endlocal&for /f "usebackq tokens=1,*" %%i in ("%~f0") do if "%%i" == "::;" (echo %%j& exit /b 0) else if "%%i" == ":::" echo %%j
(for /f "delims=" %%i in ("!Opt!") do endlocal&set "Opt=%%i") || (endlocal&shift /1 &goto :Parameter)
:2ndParam
if not "%Opt:~ 0, 1%" =="/" ( set "SL=") else set "SL=/"
for /f "tokens=1,* delims=/" %%a in ("%Opt%") do (
  if "%%b" == "" ( set "Opt=") else set "Opt=/%%b"
  set "px=%%a"
)
if not defined SL goto :InandOut
if "%px:~1,1%" == ":" set "px=%px:~0,1%%px:~2%"
if /i "%pX:~0,1%" == "Z" (
  set /a yes + = 1
  if "%pX:~1%" == "" ( set "Zeichen=.") else set "Zeichen=%pX:~1%"
) else if /i "%pX%" == "E" ( set "E=>nul"
) else if /i "%pX%" == "EQ" ( set "E=>nul" & set "Q=>nul"
) else if /i "%pX%" == "Q" ( set "Q=>nul"
) else if /i "%pX%" == "QE" ( set "E=>nul" & set "Q=>nul"
) else if /i "%pX:~0,1%" == "N" (
  set /a yes + = 1
  if "%pX:~1%" == "-" ( set "pN=D"
  ) else if "%pX:~1%" gtr "0" ( set /a pN = %pX:~1%
  ) else if "%pX:~1%" == "0" ( set "pN=0"
  ) else set "pN=N"
) else if /i "%pX:~0,1%" == "L" (
  set /a yes + = 1
  set L=1
  if "%pX:~1%" == "-" ( set "pN=D"
  ) else if "%pX:~1%" gtr "0" ( set /a pN = %pX:~1%
  ) else if "%pX:~1%" == "0" ( set "pN=0"
  ) else set "pN=N"
) else if /i "%pX%" == "F" ( set "O=1"
  for %%i in ("%px:~1%") do set "pOut=%%~dpi" & set "put=%%~nxi" & set "um=>>" & set "F=""
) else set "erropt=%pX%"
if defined Opt (goto :2ndParam) else shift /1 &goto :Parameter
:InandOut
if defined Input if not defined pOut for %%i in ("%px%") do set "pOut=%%~dpi" & set "put=%%~nxi" & set "um=>>" & set "F=""
if not defined Input for %%i in ("%px%") do set "InFile=%%~nxi"&set "Input=%%~i"
if defined Opt goto :2ndParam
shift /1 &goto :Parameter
:Paraend
for %%i in ("" "\" "." ".." "..." "....") do if "%Input%"=="%%~i" (echo Syntaxfehler! Bitte Quelldateinamen angeben! & set b=1 & goto :help )>&2
if not exist "%Input%" set b2=1 & goto :end
:: Zaehle Zeilen
findstr /n "^" "%Input%">"%temp%\Ltmp"
for /f "delims=:" %%i in ('find /c ":"^<"%temp%\Ltmp"') do set /a Full = %%i
(for /f "usebackq tokens=* delims=" %%i in ("%Input%") do @for /f %%j in ("%%i") do @echo.%%i
)>"%temp%\tmp"
findstr /n "^" "%temp%\tmp">"%temp%\Ftmp"
for /f "delims=:" %%i in ('find /c ":"^<"%temp%\Ftmp"') do set /a noempty = %%i
if defined erropt ( echo ungueltige Option: %erropt% %E%
  goto :syntax)>&2
::ist Quelle gleich Ziel? gleich Numberme?
if "%pOut%%put%" == "%~f0" set "orig=" & set "pOut=" & set "put=" & set "F=" & set "um="
if defined O if not defined output for %%i in ("%Input%") do set "pOut=%%~dpi" & set "put=%%~nxi" & set "um=>>" & set "F=""
if "%pOut%%put%" == "%Input%" set orig=%random%
if not defined O if defined orig if %yes% equ 1 set pN=N
if %Full% equ 0 goto :end
goto :next
:help
if defined b (echo. & echo gueltige Syntax:  %E% & goto :syntax)>&2
echo Listet Dateien ^(mit Nummerierung^) zeilenweise ^(ohne Leerzeilen^) auf den
echo Bildschirm oder in eine Datei. Oder Entfernt die Nummerierung.
:syntax
(echo. & echo %~n0 [Laufwerk:][Pfad]Quelldatei [/F][Laufwerk:][Pfad][Zieldatei] %E%
echo  [/N^|/L[:][WERT]] [/Z[:][ZEICHEN]] [/Q] [/E] %E%
echo                              [/?] Hilfe [/?en] credits and english short guide %E%
if defined b ( exit /b 1) else if defined erropt goto :end)>&2
echo.&echo  Quelldatei   Muss vor der Zieldatei angegeben werden.&echo.  
echo  Zieldatei    Wird die Zieldatei nicht angegeben wird der Inhalt auf dem
echo               Bildschirm ausgegeben. Zieldatei Wird ueberschrieben.
echo  OHNE AusgabeART wird OHNE Leerzeilen mit Vornullen und Minimum Zweistellig
echo  Numeriert ^= [/l:2]. &echo.
echo  Wenn Quell-Pfad-Datei und Ziel-Pfad-Datei gleich: Werden in der Quelldatei
echo  OHNE AusgabeART und OHNE Option Z oder F NUR Leerzeilen entfernt.
echo  Sonst wie Syntax.&echo.
echo   /F          Aktion in der Quelldatei ^(oder im Angegebenen Ziel^)&echo.
echo   /N          Gibt die AusgabeART an.         OHNE      Leerzeilen!
echo   /L          Gibt die AusgabeART an.   MIT             Leerzeilen!
echo     WERT      Wird WERT NICHT angegeben wird NICHT Nummeriert!
echo     -          Eine gefundene Durchgehende Nummerierung 
echo                mit Punkt oder
echo                mit Doppelpunkt oder
echo                mit LeerZeichen 
echo               ODER wie ZEICHEN     wird Entfernt und
echo                gibt exitcode 5 wenn Durchgehende Nummerierung fehlt.
echo                Bei Option L- werden Leerzeilen nicht entfernt.&echo.
echo     0         Es wird ohne Vornullen Nummeriert.
echo     1         Ab der Zahl 1 wird Automatisch Vorgenullt (1-7, 0001-4702)
echo               Oder Mindestene Stellenanzahl inklusive Vornullen (3^= 001-054)&echo.
echo   /Z          Trennzeichen zwischen Nummerierung und Text wird zum Punkt oder
echo                wie ZEICHEN.
echo               Fuer ZEICHEN : muss der Optionale Doppelpunkt auch mit angegeben
echo               werden. /Z::
echo     ZEICHEN   Angabe von ein oder mehr Trennzeichen zur de- oder Nummerierung.&echo.
echo      Achtung! Fuer Enthaltene Leer-/Sonderzeichen Syntax in " " setzen!
echo       Beispiel: /z": :" ^(mindestens das Sonderzeichen muss Umschlossen sein^)
echo               Bei Denummerierung gibt das erste Zeichen das Trennzeichen hinter
echo               der Nummerrierung an, das letzte Zeichen bis wohin geloescht
echo               wird. -^> Zeichenfolge wird Ueberprueft. Bei Denummerierung 
echo               keine Ziffern als erstes oder letztes Zeichen Verwenden.
echo               Das letzte Zeichen nicht doppelt Verwenden.&echo.
echo   /Q          Meldungen werden NICHT Ausgegeben - Hilfe wird immer angezeigt!
echo   /E          Entspricht 2^>nul Errormeldungen werden NICHT Ausgegeben. ODER
echo   /QE or /EQ  Unterdrueckung aller Meldungen in einer Option!&echo.
echo  Optionen koennen zusammenhaengend geschrieben werden zB: /N1/QE/Z wenn die
echo  einzelne Option Z Keine Leerzeichen enthaelt. Doppelpunkte sind Optional.&echo.
echo  Sonderzeichen: Falsche Ausgabe Nur auf Bildschirm! Im Dateiname:-^> setze " "  &echo.
echo  Die Anzahl Zeilen und Anzahl Leerzeilen der Quelldatei werden ausgegeben!&echo.
echo  Statusmeldungen werden im Handle 3 ausgegeben
echo  Errormeldungen werden im Handle 2 ausgegeben
exit /b 0
:next
::Statusmeldung für Vorgang
(   ::Wenn Nummerierung entfernen
  if %pN% == D (
    if %noempty% gtr 0 (
      if not "%pOut%" == "" (
        if defined L ( echo(
          echo    Nummerierung wird in "%put%" enfernt!
        ) else ( echo(
          if %noempty% lss %Full% (
            echo    Leerzeilen, Nummerierung werden in "%put%" enfernt!
          ) else echo    "%put%" enthaelt keine Leerzeilen, Nummerierung wird entfernt!
    ) ) ) else set emptylines=1 & goto :end
  ) else if not %pN% == N (
  ::Wenn Nummeriert werden soll
  if defined L (
    if not "%pOut%" == "" (
          if %noempty% lss %Full% ( echo(
          echo    "%put%" wird Nummeriert!
        ) else ( echo(
          echo    "%put%" enthaelt keine Leerzeilen, wird Nummeriert!
    ) ) ) else if %noempty% equ 0 ( set emptylines=1 & goto :end
    ) else if not "%pOut%" == "" ( echo(
      echo    "%put%" wird ohne Leerzeilen Nummeriert!
  ) )
  ::Wenn Leerzeilen entfernen
  if %pN% == N (
    if not defined L if %noempty% gtr 0 (
      if %noempty% lss %Full% (
        if not "%pOut%" == "" ( echo(
          echo    Leerzeilen werden in "%put%" enfernt!
      ) ) else set noemptyLines=1 & goto :end
    ) else set emptylines=1 & goto :end
) ) %Q% >&3
::Loesche vorhandene Zieldatei
if not "%pOut%%orig%%put%" == "" if exist "%pOut%%orig%%put%" del "%pOut%%orig%%put%"
::Erstelle extraDatei/Output fuer Leerzeilenentfernung oder Tempdatei fuer De- oder Nummerierung
if defined L if %pN% == N (
  findstr "^" "%Input%" %um%%F%%pOut%%orig%%put%%F%
  goto :end
)
if %pN% == N (
  findstr "^" "%temp%\tmp" %um%%F%%pOut%%orig%%put%%F%
  goto :end
)
if defined L if not %pN% == D set /a LL = Full & copy "%temp%\Ltmp" "%temp%\Ftmp" >nul
if not defined LL set /a LL = noempty
set NL=9
::mit oder ohne Vornull?
if %pN% == D ( set "D=1"
  set "NN=0"        
  goto :noZero
) else if %pN% lss 1 ( set "NN=0"
  goto :noZero
) else set "NN=1"
::Zaehlen der Automatischen oder Manuellen Vornullen
:testZero
if %NL% lss %LL% ( set "NL=%NL%9"
  set /a NN + = 1
  goto :testZero
)
if %NN% gtr %pN% ( set pN=%NN%) else set NN=%pN%
set NL=9
::Vornullen setzten 
:withZero
if not %pN% == 1 ( set "vpn=%vpN%0"
  set /a pN - = 1
  goto :withZero
)
::Spungziel bei keinen Vornullen oder nach Pruefung auf Nummerierung
:noZero
set /a pN = 0 , HNL = 0 , HL = 9
::Blockanfang De- oder Nummerierung 
:read
::Keine Nummerierung gefunden?
if defined nodel if "%Zeichen%" == " " ( set "nodel="
  set "Zeichen=."
  goto :noZero
) else if "%Zeichen%" == "." ( set "nodel="
  set "Zeichen=:"
  goto :noZero
) else goto :end
::Schalter fuer Pruefung auf vorhandene Nummerierung oder Sprung zum Ende oder Einstellung Ziffernbreite
if defined D (
  if %pN% == %LL% (
    if not defined delNR (
      set "delNR=1"
      goto :noZero
    ) else goto :end
  ) else ( set /a pN + = 1
) ) else if %pN% == %LL% ( goto :end) else set /a pN + = 1
::Zaehler fuer Zeile und VorNullen Einstellung und Ruf Zeilenwahl
call :setline %pN%
if %HL% == %pN% ( set "HNL=%NL%"
  set "HL=%HL%9"
)
if %NN% gtr 0 if %NL% == %pN% ( set "NL=%NL%9"
    set /a NN - = 1
    set "vpN=%vpN:~1%"
)
goto :read
::Zeilenauswahl zum Ueberspung
:setline
if 1 == %1 set "skip=" & goto :write
set /a skip = %1 - 1
set skip=Skip=%skip%
:write
::Test auf oder Entfernung einer Vorhandenen Nummerierung 
if defined D (
  if not defined delNR (
    for /f "usebackq tokens=1,* delims=:" %%i in ("%temp%\Ltmp") do (
      if defined nodel goto :eof
      for /f "delims=%Zeichen:~-1%" %%k in ("%%j") do (
        for /f "tokens=1,* delims=%Zeichen:~0,1%" %%l in ("%%k") do (
        for /f "tokens=* delims=0" %%n in ("%%l") do if not "%%n%%m" == "%%i%Zeichen:~1,-1%" set "nodel=1"
    ) ) )
    set "pN=%LL%" & goto :eof
  ) else (
    for /f "delims=" %%h in ("%Zeichen%") do (
      for /f "usebackq tokens=* delims=" %%i in ("%temp%\tmp") do (
        set "Zeile=%%i"
        setlocal enabledelayedexpansion
        set "Zeile=!Zeile:*%%h=!"
        if defined L ( echo(!Zeile!
        ) else for /f %%j in ("!Zeile!") do echo(!Zeile!
        endlocal
    ) )%um%%F%%pOut%%orig%%put%%F%
    set "pN=%LL%" & goto :eof   
) )
::Nummerieren
(
  for /f "usebackq %skip% tokens=*" %%i in ("%temp%\Ftmp") do (
    set "Zeile=%%i"
    setlocal enabledelayedexpansion
    for /f "delims=:" %%h in ("%%i") do set "HNNR=%%h"
    for %%j in ("!HNNR!") do (
      set "Zeile=!Zeile:*:=!"
      echo.%vpN%%%~j%Zeichen%!Zeile!
      if %%~j equ %LL% endlocal & set "pN=%%~j" & goto :eof
      if %%~j equ %HL% endlocal & set "pN=%%~j" & goto :eof
      endlocal
) ) )%um%%F%%pOut%%orig%%put%%F%
:end
( if defined b2 ( echo Fehler! Quelldatei "%InPut%" nicht gefunden! %E%
    exit /b 2)
  ( echo( %E% %Q%
  ) >&3
  if defined nodel echo "%InFile%" enthaelt keine Nummerierung! %E%
  if defined noemptyLines echo "%InFile%" enthaelt keine Leerzeilen %E%
  if defined emptylines echo "%InFile%" enthaelt nur Leerzeilen %E%
  if %Full% equ 0 echo "%InFile%" ist leer! %E%
) >&2
if %Full% equ 0 goto :noren
if not defined orig goto :noren
if defined erropt goto :noren
if defined emptylines goto :noren
if defined noemptyLines goto :noren
if defined nodel goto :noren 
move /y "%pOut%%orig%%put%" "%Input%" >nul
:noren
set /a Lempty = Full - noempty
( echo AnzahlZeilen %Full% AnzahlLeerzeilen %Lempty% %Q%
) >&3
if exist %temp%\Ftmp del %temp%\Ftmp
if defined erropt exit /b 3
if %Full% equ 0 exit /b 4
if defined noemptyLines exit /b 6
if defined nodel exit /b 5
if defined emptylines exit /b7
exit /b 0