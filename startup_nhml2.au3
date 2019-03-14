#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------
$DEBUG="NO"

func logging($text, $window_title=$notepad_title)
	WinActivate($window_title)
	WinWaitActive($window_title)
	Send($text)
	Send("{ENTER}")
EndFunc

func MoveSecondWorker($workername, $wintitle, $x, $y, $speed)
  $controlname="[NAME:textBoxWorkerName]"
  $list=WinList($wintitle, "")

  for $i=1 To $list[0][0]
	$handle1=$list[$i][1]
	$text1=ControlGetText($handle1, "", $controlname)
    if $text1 = $workername Then
       ; MsgBox(0, "title", "found window with workername! , next move!: text: "&$text1)
	   WinActivate($handle1)
	   WinMove($handle1, "", $x, $y, "","", $speed)
	   ;break
	endif
  Next
EndFunc


sleep(3000)

$notepad_title="Nimetön – Muistio"
$notepad_pid=Run("notepad.exe")
sleep(3000)

logging("debug set to: ")
logging($DEBUG)
if $DEBUG = "NO" then
   logging("sleep 30...")
   Sleep(30000)
EndIf

Logging("notepad started for Info...")
logging("close avast browser...")
WinClose("Uusi välilehti - Avast Secure Browser")

; Script Start - Add your code below here
; 0=OK-button; 60 seconds to disappear
if($DEBUG = "NO") then
   Logging("msgbox start...")
   MsgBox(0, "First Message, boot!.TITLE", "First Message, AUTOIT, windows boot!", 5)
EndIf

; for info log...
; TODO CHECK HERE 1.st NHML is started and running
$both_running=0

Logging("start while...")
$nh_title="NiceHash Miner Legacy v1.9.0.16"
$worker2 = "i3NVIDIARTX1070"
$worker1 = "i3R280RX500"

Opt("WinTitleMatchMode", 4)

$jobstart=TimerInit()
WinMinimizeAll()
while $both_running = 0
  WinSetState($notepad_title, "", @SW_MAXIMIZE)
  WinMove($notepad_title, "", 130, 485, 680,480)

  if(WinExists($nh_title)) then
	logging("move 1st window...")
	WinSetState($nh_title, "", @SW_RESTORE)
	;MoveSecondWorker($nh_title, $worker1, 113,65,80)
	WinMove($nh_title,"", 113, 65, "","", 10)
	logging("found 1.st windows, run second...")
    $pid=ShellExecute("C:\Users\user\Desktop\NHML UUSIN B 1.9.0.16 – Pikakuvake.lnk", "C:\Users\user\Desktop")
	sleep(20000)

    logging("move second worker....")
	MoveSecondWorker($worker2, $nh_title, 719, 65,80)
	;WinMove($nh_title,$worker2, 719, 65, "","", 50)

	;if WinExists($program_title, $workertitle) Then
	;	textBoxWorkerName
	$both_running=1
	;endif
	; textBoxWorkerName = i3R280RX500
	; ; textBoxWorkerName = ???
  EndIf
  if($DEBUG = "NO") then
    Sleep(5000);
  Else
	Sleep(1000);
  EndIf
  ; max 3 min loop
  if timerdiff($jobstart) > 180000 Then
	  ; close everything
	  logging("over 3 mins passed, close script")
	  logging("task FAILED!.")
	  $both_running=1
  endif
wend
; check 2 nhml windows open and running....
; Logging("Check both windows running...")

logging("close this notepad in 10 secs....")
sleep(10000)
WinClose("[CLASS:Notepad]","")
