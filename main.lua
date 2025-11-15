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
	local ascil = [[ ░▒▓██████▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░       
░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      
░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░             
░▒▓████████▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓███████▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒▒▓███▓▒░      
░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      
░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      
░▒▓█▓▒░░▒▓█▓▒░       ░▒▓█████████████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░       
                                                                                                                      
                                                                                                                      
 ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓██████████████▓▒░░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░                                        
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░                                       
░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░                                              
░▒▓█▓▒▒▓███▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒▒▓███▓▒░                                       
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░                                       
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░                                       
 ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░                                        
                                                                                                                      
                                                                                                                      
░▒▓██████████████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓███████▓▒░▒▓████████▓▒░                                             
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░                                                    
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░                                                    
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓██████▓▒░                                               
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░                                                    
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░                                                    
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░                                             
                                                                                                                      
                                                                                                                      ]]

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
	print("This time, there will be consequences")
	s.antag(1)
	sleep()
	print("When you lose!!!!")
	s.antag(1)
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

local win3 = dofile("level3.lua")
if win3 then
	-- soon to be added
elseif not win3 then
	os.exit()
end


-- END OF THE GAME PART!!!
local levels = {win1, win2}  -- add more levels if needed

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
