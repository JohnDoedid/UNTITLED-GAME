local startTime = os.time()
os.execute("ffplay -nodisp -autoexit gamestart.ogg > /dev/null 2>&1")
local elapsed1 = os.time() - startTime
print("Elapsed time for sound test:", elapsed1)
if elapsed1 == 2 then
    print("Description: quick, normal.")
elseif elapsed1 > 2 and elapsed1 <= 4 then
    print("Description: a bit longer than normal.")
elseif elapsed1 > 4 then
    print("Description: very bad. your device may not handle this game.")
end

os.execute("sleep 2")
startTime = os.clock()  -- reset timer for next task
for i = 1, 100 do
    for j = 1, 100 do
        io.write("x")
    end
    io.write("\n")
end
local elapsed2 = os.clock() - startTime
print("Elapsed time for printing:", elapsed2)
if elapsed2 <= 0.005 then
print("Description: minimal time for printing text! super fast")
elseif elapsed2 > 0.02 then
print("Description: good performance, smooth printing")
elseif elapsed2 > 0.05 then
print("Description: noticable delay, but still good enough")
elseif elapsed2 > 0.12 then
print("Description: very slow. 120 ms delay.")
elseif elapsed2 > 1 then
print("Description: EXTERMELY SLOW! unrecommended speed.")
end
os.execute("sleep 1")


local ffi = require("ffi")
local sdl = ffi.load("SDL2")

ffi.cdef[[
typedef struct SDL_Window SDL_Window;
typedef struct SDL_Event {
    uint32_t type;
    uint8_t padding[56]; // SDL_Event union is big, avoid memory issues
} SDL_Event;

int SDL_Init(uint32_t flags);
SDL_Window* SDL_CreateWindow(const char* title, int x, int y, int w, int h, uint32_t flags);
void SDL_DestroyWindow(SDL_Window* window);
int SDL_PollEvent(SDL_Event* event);
void SDL_Quit(void);

enum { SDL_INIT_VIDEO = 0x00000020, SDL_WINDOW_SHOWN = 0x00000004, SDL_QUIT = 0x100 };
]]

local startTime = os.clock()

if sdl.SDL_Init(sdl.SDL_INIT_VIDEO) ~= 0 then
    error("SDL_Init failed")
end

local window = sdl.SDL_CreateWindow("LuaJIT Window Test",
    100, 100, 640, 480, sdl.SDL_WINDOW_SHOWN)
if window == nil then error("Failed to create window") end

local e = ffi.new("SDL_Event")
local t0 = os.clock()

while os.clock() - t0 < 2 do  -- keep open for 2 seconds
    while sdl.SDL_PollEvent(e) ~= 0 do
        if e.type == sdl.SDL_QUIT then
            t0 = os.clock() - 2 -- force exit loop
        end
    end
end

sdl.SDL_DestroyWindow(window)
sdl.SDL_Quit()

local elapsed3 = os.clock() - startTime
print("Elapsed time for window test:", elapsed3)
if elapsed3 <= 1 then
print("Description: fAst window opening! great")
elseif elapsed3 >= 2 then
print("Description: average for linux, epic")
elseif elapsed3 > 3.5 then
print("Description: a bit slow, acceptable")
elseif elapsed3 > 5 then
print("Description: very slow, might wanna close a few tabs")
end

os.execute("sleep 1")

local url = "https://glitch.com"
-- Open in background
os.execute("xdg-open '"..url.."' &")
local elapsed4 = os.clock() - startTime
print("Elapsed time for url opening test:", elapsed4)
if elapsed4 <= 1 then
print("Description: fast loading! good quick!")
elseif elapsed4 > 2 then
print("Description: quick! great!")
elseif elapsed4 > 4 then
print("Description: not fast, but good")
elseif elapsed4 > 5 then
print("Description: unrecommended speed! might wanna close a few tabs")
end

os.execute("sleep 1")

local elapsed5 = os.clock() - startTime

-- Function to get ordinal suffix
local function ordinal(n)
    local lastDigit = n % 10
    local lastTwoDigits = n % 100
    if lastTwoDigits >= 11 and lastTwoDigits <= 13 then
        return "th"
    elseif lastDigit == 1 then
        return "st"
    elseif lastDigit == 2 then
        return "nd"
    elseif lastDigit == 3 then
        return "rd"
    else
        return "th"
    end
end

-- Function to create nested table
local function ctd(dep)
    print("Going " .. dep .. " deep")
    local t = {}
    local cur = t
    for i = 1, dep do
        cur["T" .. i] = {}
        cur = cur["T" .. i]
    end
    cur.value = "You have reached the " .. dep .. ordinal(dep) .. " nested value"
    return t
end

local depth = 99999
local dt = ctd(depth)

local cure = dt
for i = 1, depth do
    cure = cure["T" .. i]
end

print(cure.value)
print("Elapsed time for " .. depth .. " nest table: " .. elapsed5)
if elapsed5 <= 0.05 then
    print("Description: minimal time for very deep table! NICE")
elseif elapsed5 > 0.1 then
    print("Description: best time for deep table! great")
elseif elapsed5 > 2 then
    print("Description: average time for deep table! good")
elseif elapsed5 > 7 then
    print("Description: slow time for deep tables. might wanna remove some plates")
elseif elapsed5 > 10 then
    print("Description: very slow! unepic.")
end

-- Calculate average performance
local elapsedTimes = {elapsed1, elapsed2, elapsed3, elapsed4, elapsed5}
local sum = 0
for _, t in ipairs(elapsedTimes) do
    sum = sum + t
end
local average = sum / #elapsedTimes

-- Determine performance category
local category
if average <= 0.05 then
    category = "Excellent"
elseif average >= 0.1 then
    category = "Best"
elseif average >= 0.2 then
    category = "Fast"
elseif average >= 0.5 then
    category = "Good"
elseif average >= 1 then
    category = "Average"
elseif average >= 2 then
    category = "Needs work"
elseif average >= 5 then
    category = "Bad"
else
    category = "Ugly"
end

print(string.format("\nAverage time: %.3f s — Performance: %s", average, category))
