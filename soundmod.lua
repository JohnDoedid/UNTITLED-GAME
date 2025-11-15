-- soundmod.lua
local sound = {}

local function play(file, time)
    local cmd = string.format(
        "ffplay -nodisp -autoexit -t %d '%s' > /dev/null 2>&1 &",
        time, file
    )
    os.execute(cmd, "|", "sleep " .. time)
end

-- for tiny files, repeat to fill time
local function play_looped(file, time)
    -- 23 loops ≈ 1 second, multiply by time
    local loops = 23 * time
    local cmd = string.format(
        "ffplay -nodisp -autoexit -loop %d -t %d '%s' > /dev/null 2>&1 &",
        loops, time, file
    )
    os.execute(cmd, "|", "sleep " .. time)
end

-- normal sounds
function sound.gs(time)     play("gamestart.ogg", time) end
function sound.gov(time)    play("gamover.ogg", time) end

-- tiny voices
function sound.antag(time)  play_looped("antagonist.ogg", time) end
function sound.player(time) play_looped("player.ogg", time) end

return sound
