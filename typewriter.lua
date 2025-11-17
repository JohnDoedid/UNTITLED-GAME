local s = require("soundmod")

local function typew(text)
for i = 1, #text do
local ch=  text:sub(i,i)
io.write(ch)
io.flush()
local delay = math.random() * 0.1
os.execute("sleep " .. delay)
end
end

s.antag(1)
os.execute("sleep 0.4")
typew("Hello, player!\n")
os.execute("sleep 1")
s.antag(2)
os.execute("sleep 0.4")
typew("This is a typewriter text test!\n")
os.execute("sleep 2")
