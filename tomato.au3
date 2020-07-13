
; values
$press = 0
$first = true					; first run
$fruit = 0						; # of focus sessions, out of 4
$session = 25 * (60 * 1000)		; time of focus session
$small =    5 * (60 * 1000)		; time of small break
$large =   30 * (60 * 1000)		; time of large break


; gui stuff


func minimize()
   WinMinimizeAll()

endfunc


func study()
   if $first then
	  msgbox(0, title(), "Please focus on your task now.")
   else
	  msgbox(0, title(), "Break time is over. Please focus on your task now.")
   endif

   TraySetToolTip(title() & " - Working on a task.")
   sleep($session)	; 25 minute focus session
   $fruit += 1		; add a fruit

endfunc


func smallbreak()
   minimize()		; minimize everything
   msgbox(0, title(), "Tomato earned. Please take a small break.")
   TraySetToolTip(title() & " - Taking a small break.")
   sleep($small)	; 5 minute break

   minimize()		; minimize everything

endfunc


func bigbreak()
   minimize()		; minimize everything
   msgbox(0, title(), "Tomato earned. Please take a large break.")
   TraySetToolTip(title() & " - Taking a large break.")
   sleep($large)	; 30 minute break

endfunc


func restart()
   minimize()		; minimize everything
   $press = msgbox(4, title(), "Break time is over. Start a new session?")
   TraySetToolTip()
   if $press = 7 then
	  exit
   else
	  $press = 0
   endif

endfunc


func title()
   return string($fruit & "/4 Tomatoes")
endfunc



while true
   study()				;study

   if $fruit < 4 then
	  smallbreak()
	  $first = false

   else
	  bigbreak()
	  $fruit = 0
	  restart()
	  $first = true

   endif

wend



