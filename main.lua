print("Start performance test before playing? 'yes' or 'no'")
local wpdwoefnwisbfwjhfbwubfh = io.read()
if wpdwoefnwisbfwjhfbwubfh == "yes" then
os.execute("luajit tester.lua")
elseif wpdwoefnwisbfwjhfbwubfh == "no" then
end

local startTime = os.time()    -- seconds since epoch, used for days/hours/minutes/seconds
local startClock = os.clock()  -- CPU time in seconds (can get milliseconds)
local s = require("soundmod")

local function sleep()
	os.execute("sleep 1")
end
local function emph()
	os.execute("sleep 0.05")
end
print([["Unnamed Game" created by goldenhat. Enjoy!]])
s.gs(4)
os.execute("sleep 3")
os.execute("clear")
local win = dofile("thethingthatstartsitall.lua")
if win.yes then
	print("\n\n\n\nNEXT LEVEL")
	s.gs(4)
	sleep()
	sleep()
else
	print("tip: do not misspell anything")
	os.exit()
end
local win1 = dofile("level1.lua")
if win1.won then
	print("OMG!!! You completed my level!!!")
	s.antag(1)
	sleep()
	print("how?????")
	s.antag(1)
	os.write("??")
	os.flush()
	os.execute("sleep 0.05")
	os.write("???")
	os.flush()
	sleep()
	print("Anyways, thank you for creating my wall!!")
	s.antag(1)
	sleep()
	print("FOR THIS NEXT ONE,")
	s.antag(1)
	sleep()
	print("You will have to create me a.......")
	s.antag(1)
	sleep()
	s.antag(5)
local ascii = [[
                          ______ _    _ _      _      
                         |  ____| |  | | |    | |     
                         | |__  | |  | | |    | |     
                         |  __| | |  | | |    | |     
                         | |    | |__| | |____| |____ 
                         |_|     \____/|______|______|
                                                      
                                                      
         _   _ ______ _______ _    _ ______ _____  _____ _______ ______ 
        | \ | |  ____|__   __| |  | |  ____|  __ \|_   _|__   __|  ____|
        |  \| | |__     | |  | |__| | |__  | |__) | | |    | |  | |__   
        | . ` |  __|    | |  |  __  |  __| |  _  /  | |    | |  |  __|  
        | |\  | |____   | |  | |  | | |____| | \ \ _| |_   | |  | |____ 
        |_| \_|______|  |_|  |_|  |_|______|_|  \_\_____|  |_|  |______|
                                                                        
                                                                        
                          _____  __  __  ____  _    _ _____  _ 
                    /\   |  __ \|  \/  |/ __ \| |  | |  __ \| |
                   /  \  | |__) | \  / | |  | | |  | | |__) | |
                  / /\ \ |  _  /| |\/| | |  | | |  | |  _  /| |
                 / ____ \| | \ \| |  | | |__| | |__| | | \ \|_|
                /_/    \_\_|  \_\_|  |_|\____/ \____/|_|  \_(_)
]]

-- Split into lines
for line in ascii:gmatch("[^\r\n]+") do
    print(line)
    os.execute("sleep 0.1")  -- delay between lines
end
	sleep()
	print("You: Nah ain't no way I'm making that!!!!")
	s.player(1)
	sleep()
	print("NO!!!! YOU WILL CREATE THIS FOR ME!!")
	s.antag(1)
	os.execute("feh images/force.jpg")
	sleep()
	print("The levels will get crazier and crazier!!!!")
	s.antag(1)
	sleep()
	print("Trust me plz don't leave!!!!")
	s.antag(1)
	sleep()
	print("You: well ok then.....")
	s.player(1)
	sleep()
	print("Yes! thank you :3")
	s.antag(1)
	sleep()
	print("Anyway,")
	s.antag()
	sleep()
	emph()
	print("SEVMTE8sIFRISVMgSVMgQSBNRVNTQUdFIEZST00gVEhFIENSRUFUT1IsIEkgQU0gU1VQUE9SVElORyBZT1UuIFRISVMgR0FNRSBJUyBWRVJZIExPTkcgQU5EIFRPT0sgTUUgWUVBUlMgVE8gQ09NUExFVEUuIElGIFlPVSBXQU5UIFRPIFNFRSBUSEUgREVUQUlMRUQgUEFSVFMsIFlPVSBXSUxMIEhBVkUgVE8gR08gVEhST1VHSCBBIExPVCwgU08gUExFQVNFIEtFRVAgR09JTkchIFlPVSBXSUxMIFNVQ0NFRUQgSUYgWU9VIERPIEFMTCBPRiBUSEUgSEFSRCBXT1JLISEgSSBETyBOT1QgS05PVyBXSEFUIEVMU0UgVE8gUFVUIEhFUkUsIFNPIEkgV0lTSCBZT1UgR09EU1BFRUQhISEgLSBmcm9tIGdvbGRlbmhhdC4gbm92ZW1iZXIgMTQsIDIwMjUsIG9uIDE4OjAwLg0KaSB3YXMga2luZGEgdG9vIGxhenkgdG8gYWRkIGEgc2F2ZSBtZWNoYW5pc20gc29ycnkgOjM=")
	emph()
	print("aWYgeW91IGFyZSBnb2xkZW5oYXQsIGhlbGxvIGZyb20gYSA1IHllYXJzIGFnbyEhISE=")
elseif not win1.won then
	print("Oh my god!! Done already??")
	s.antag(2)
	sleep()
	sleep()
	print("That was fast!!")
	s.antag(2)
	sleep()
	sleep()
	print("What?! You failed?1!!")
	s.antag(2)
	sleep()
	print("I am sorry, but you will have to win the snake game before proceeding.. 	quitting!!!!")
	s.antag(3)
	sleep()
	sleep()
	sleep()
	s.gov(4)
	os.exit()
end


local win2 = dofile("level2.lua")
if win2 then
	print("OMG WHAT??!!!")
	s.antag(1)
	sleep()
	print("YOU ACTUALLY SUCCEEDED??")
	s.antag(2)
	sleep()
	sleep()
	print("Ok, here's one I am SURE you will lose!!")
	s.antag(2)
	sleep()
	sleep()
	print("you'll have to create me a,..................")
	s.antag(2)
	sleep()
	sleep()
	s.player(10)
	for k = 1,100 do
		os.write("*drum*")
		os.flush()
		os.execute("sleep 0.1")
	end
	local ascil = [[                                                                                                                 
                                                                                                                 
`7MM"""Yb. `7MM"""YMM  `7MM"""YMM `7MM"""YMM        db   MMP""MM""YMM     MMP""MM""YMM `7MMF'  `7MMF'`7MM"""YMM  
  MM    `Yb. MM    `7    MM    `7   MM    `7       ;MM:  P'   MM   `7     P'   MM   `7   MM      MM    MM    `7  
  MM     `Mb MM   d      MM   d     MM   d        ,V^MM.      MM               MM        MM      MM    MM   d    
  MM      MM MMmmMM      MM""MM     MMmmMM       ,M  `MM      MM               MM        MMmmmmmmMM    MMmmMM    
  MM     ,MP MM   Y  ,   MM   Y     MM   Y  ,    AbmmmqMA     MM               MM        MM      MM    MM   Y  , 
  MM    ,dP' MM     ,M   MM         MM     ,M   A'     VML    MM               MM        MM      MM    MM     ,M 
.JMMmmmdP' .JMMmmmmMMM .JMML.     .JMMmmmmMMM .AMA.   .AMMA..JMML.           .JMML.    .JMML.  .JMML..JMMmmmmMMM 
                                                                                                                 
                                                                                                                 
                                                                                                                 
                                                                                                                 
  .g8"""bgd     db `7MMF'   `7MF'`7MM"""YMM      `7MM"""Yp,   .g8""8q.    .M"""bgd  .M"""bgd                     
.dP'     `M    ;MM:  `MA     ,V    MM    `7        MM    Yb .dP'    `YM. ,MI    "Y ,MI    "Y                     
dM'       `   ,V^MM.  VM:   ,V     MM   d          MM    dP dM'      `MM `MMb.     `MMb.                         
MM           ,M  `MM   MM.  M'     MMmmMM          MM"""bg. MM        MM   `YMMNq.   `YMMNq.                     
MM.          AbmmmqMA  `MM A'      MM   Y  ,       MM    `Y MM.      ,MP .     `MM .     `MM                     
`Mb.     ,' A'     VML  :MM;       MM     ,M       MM    ,9 `Mb.    ,dP' Mb     dM Mb     dM                     
  `"bmmmd'.AMA.   .AMMA. VF      .JMMmmmmMMM     .JMMmmmd9    `"bmmd"'   P"Ybmmd"  P"Ybmmd"                      
                                                                                                                 
                                                                                                                 
 ]]

s.antag(2)
-- Split into lines
for line in ascil:gmatch("[^\r\n]+") do
    print(line)
    os.execute("sleep 0.1")  -- delay between lines
end
	sleep()
	print("YOU: WHAT?!!!! BUT THAT IS VERY HARD!!")
	s.player(1)
	sleep()
	print("YES!! YES YES!! THIS GAME IS SUPPOSED TO")
	s.antag(1)
	sleep()
	print("BE HARD SO LOTS OF PEOPLE QUIT!!!")
	s.antag(1)
	sleep()
	print("You may quit now, but you will not be able to finish the game!!")
	s.antag(2)
	sleep()
	sleep()
	print("    (or u just played the game again and you have already finished the game)")
	s.player(1)
	sleep()
	print("This time, if you win this level, you will")
	s.antag(1)
	sleep()
	print("be eligible to continue to the full game!!! WHICH IS SUPER HARD!!!")
	s.antag(2)
	sleep()
	print("Proceed???????? (Yes, or No (case sensitive))")
	s.antag(1)
	sleep()
	local qapl = io.read()
	if qapl == "yes" or qapl == "Yes" then
		print("THANK YOU!!!")
		s.antag()
		sleep()
		print("3...")
		sleep()
		print("2...")
		sleep()
		print("1...")
		sleep()
		print("0!!!")
	elseif qapl == "no" or "No" then
		print("well...")
		s.antag(1)
		sleep()
		print("Okay then!!!")
		s.antag(1)
		sleep()
		print("(Start over? run the game again!!!)")
		s.antag(1)
	end
else
	io.write("...") io.flush() sleep() io.write("..") io.flush() emph() io.write(".") io.flush() emph() print("OH HI!!!")
	s.antag()
	sleep()
	print("WHAT??!!! YOU DID NOT SUCCEED??")
	s.antag()
	sleep()
	print("Goodbye!")
	s.antag()
	os.exit()
end

sleep()
local win3 = dofile("level3.lua")
if win3.won then
	print("OMG!!! YOU BEAT THE CAVE BOSS!!")
	s.antag(0.5)
	emph()
	emph()
	emph()
	emph()
	s.antag(0.5)
	emph()
	emph()
	emph()
	emph()
	for p = 1,100 do
		io.write(".") io.flush()
	end
		local ascib = [[                                                                                                                 
   █████████                                                    █████               ████             █████     ███                      ███ ███ ███
  ███░░░░░███                                                  ░░███               ░░███            ░░███     ░░░                      ░███░███░███
 ███     ░░░   ██████  ████████    ███████ ████████   ██████   ███████   █████ ████ ░███   ██████   ███████   ████   ██████  ████████  ░███░███░███
░███          ███░░███░░███░░███  ███░░███░░███░░███ ░░░░░███ ░░░███░   ░░███ ░███  ░███  ░░░░░███ ░░░███░   ░░███  ███░░███░░███░░███ ░███░███░███
░███         ░███ ░███ ░███ ░███ ░███ ░███ ░███ ░░░   ███████   ░███     ░███ ░███  ░███   ███████   ░███     ░███ ░███ ░███ ░███ ░███ ░███░███░███
░░███     ███░███ ░███ ░███ ░███ ░███ ░███ ░███      ███░░███   ░███ ███ ░███ ░███  ░███  ███░░███   ░███ ███ ░███ ░███ ░███ ░███ ░███ ░░░ ░░░ ░░░ 
 ░░█████████ ░░██████  ████ █████░░███████ █████    ░░████████  ░░█████  ░░████████ █████░░████████  ░░█████  █████░░██████  ████ █████ ███ ███ ███
  ░░░░░░░░░   ░░░░░░  ░░░░ ░░░░░  ░░░░░███░░░░░      ░░░░░░░░    ░░░░░    ░░░░░░░░ ░░░░░  ░░░░░░░░    ░░░░░  ░░░░░  ░░░░░░  ░░░░ ░░░░░ ░░░ ░░░ ░░░ 
                                  ███ ░███                                                                                                         
                                 ░░██████                                                                                                          
                                  ░░░░░░                                                                                                           
 ]]
s.gov(1)
s.antag(1)
-- Split into lines
for line in ascib:gmatch("[^\r\n]+") do
    print(line)
    os.execute("sleep 0.1")  -- delay between lines
end
sleep()
		local ascim = [[                                                                                                                 
                                                                                                         
                                                                                                         
`YMM'   `MM' .g8""8q. `7MMF'   `7MF'    `7MMF'  `7MMF'      db `7MMF'   `7MF'`7MM"""YMM                  
  VMA   ,V .dP'    `YM. MM       M        MM      MM       ;MM:  `MA     ,V    MM    `7                  
   VMA ,V  dM'      `MM MM       M        MM      MM      ,V^MM.  VM:   ,V     MM   d                    
    VMMP   MM        MM MM       M        MMmmmmmmMM     ,M  `MM   MM.  M'     MMmmMM                    
     MM    MM.      ,MP MM       M        MM      MM     AbmmmqMA  `MM A'      MM   Y  ,                 
     MM    `Mb.    ,dP' YM.     ,M        MM      MM    A'     VML  :MM;       MM     ,M                 
   .JMML.    `"bmmd"'    `bmmmmd"'      .JMML.  .JMML..AMA.   .AMMA. VF      .JMMmmmmMMM                 
                                                                                                         
                                                                                                         
                                                                                                         
       ,,             ,...                                   ,,               ,,                         
     `7MM           .d' ""               mm                `7MM        mm   `7MM                         
       MM           dM`                  MM                  MM        MM     MM                         
  ,M""bMM  .gP"Ya  mMMmm.gP"Ya   ,6"Yb.mmMMmm .gP"Ya    ,M""bMM      mmMMmm   MMpMMMb.  .gP"Ya           
,AP    MM ,M'   Yb  MM ,M'   Yb 8)   MM  MM  ,M'   Yb ,AP    MM        MM     MM    MM ,M'   Yb          
8MI    MM 8M""""""  MM 8M""""""  ,pm9MM  MM  8M"""""" 8MI    MM        MM     MM    MM 8M""""""          
`Mb    MM YM.    ,  MM YM.    , 8M   MM  MM  YM.    , `Mb    MM        MM     MM    MM YM.    ,          
 `Wbmd"MML.`Mbmmd'.JMML.`Mbmmd' `Moo9^Yo.`Mbmo`Mbmmd'  `Wbmd"MML.      `Mbmo.JMML  JMML.`Mbmmd'          
                                                                                                         
                                                                                                         
                                                                                                         
                                                                                                         
      db      `7MM"""Yp, `YMM'   `MM'.M"""bgd  .M"""bgd       .g8"""bgd     db `7MMF'   `7MF'`7MM"""YMM  
     ;MM:       MM    Yb   VMA   ,V ,MI    "Y ,MI    "Y     .dP'     `M    ;MM:  `MA     ,V    MM    `7  
    ,V^MM.      MM    dP    VMA ,V  `MMb.     `MMb.         dM'       `   ,V^MM.  VM:   ,V     MM   d    
   ,M  `MM      MM"""bg.     VMMP     `YMMNq.   `YMMNq.     MM           ,M  `MM   MM.  M'     MMmmMM    
   AbmmmqMA     MM    `Y      MM    .     `MM .     `MM     MM.          AbmmmqMA  `MM A'      MM   Y  , 
  A'     VML    MM    ,9      MM    Mb     dM Mb     dM     `Mb.     ,' A'     VML  :MM;       MM     ,M 
.AMA.   .AMMA..JMMmmmd9     .JMML.  P"Ybmmd"  P"Ybmmd"        `"bmmmd'.AMA.   .AMMA. VF      .JMMmmmmMMM 
                                                                                                         
                                                                                                         
                                                                                                         
                                                                                                         
`7MM"""Yp,   .g8""8q.    .M"""bgd  .M"""bgd                                                              
  MM    Yb .dP'    `YM. ,MI    "Y ,MI    "Y                                                              
  MM    dP dM'      `MM `MMb.     `MMb.                                                                  
  MM"""bg. MM        MM   `YMMNq.   `YMMNq.                                                              
  MM    `Y MM.      ,MP .     `MM .     `MM                                                              
  MM    ,9 `Mb.    ,dP' Mb     dM Mb     dM                                                              
.JMMmmmd9    `"bmmd"'   P"Ybmmd"  P"Ybmmd"                                                               
                                                                                                         
                                                                                                          ]]
s.gov(1)
s.antag(3)
-- Split into lines
for line in ascim:gmatch("[^\r\n]+") do
    print(line)
    os.execute("sleep 0.1")  -- delay between lines
end
	sleep()
	s.antag(1)
	print("YOU ARE CHOSEN TO CONTINUE!!!")
	sleep()
	s.antag(1)
	print("3....")
	sleep()
	s.antag(1)
	print("2....")
	sleep()
	s.antag(1)
	print("1....")
	sleep()
elseif not win3.won then
	os.exit()
end

dofile("loading.lua")

-- END OF THE GAME PART!!!
local levels = {win1, win2, win3}  -- add more levels if needed

-- Build the summary string
local summaryText = ""
for i, win in ipairs(levels) do
    summaryText = summaryText .. "Level " .. i .. ": " .. (win.won and "Won" or "Lost") .. "\n"
end

-- Add full time played at the end
local elapsedSeconds = os.difftime(os.time(), startTime)
local totalMilliseconds = (os.clock() - startClock) * 1000
local days = math.floor(elapsedSeconds / 86400)
local hours = math.floor((elapsedSeconds % 86400) / 3600)
local minutes = math.floor((elapsedSeconds % 3600) / 60)
local seconds = elapsedSeconds % 60
local milliseconds = totalMilliseconds % 1000

local timeformat = string.format(
    "%d days %02d:%02d:%02d.%03d",
    days, hours, minutes, seconds, milliseconds
)

summaryText = summaryText .. "Full time played: " .. timeformat

-- Show the popup
iup.Message("SUMMARY OF GAME", summaryText)
print(summaryText)
