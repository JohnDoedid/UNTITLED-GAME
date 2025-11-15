---------------------------------------------------------
-- LEVEL 3 — Build a House
-- This level ends when:
--   ✔ Player builds a valid house → won = true
--   ✔ 5 minutes pass → won = false
---------------------------------------------------------

local level3 = {}

local TIME_LIMIT = 5 * 60          -- 5 minutes
local elapsed = 0
local finished = false
local playername = nil

---------------------------------------------------------
-- Utility: Return true if node is wall-like
---------------------------------------------------------
local function is_wall(node)
    if not node then return false end
    return minetest.get_item_group(node.name, "wood") > 0 or
           minetest.get_item_group(node.name, "stone") > 0
end

---------------------------------------------------------
-- Utility: Return true if node is roof-like
---------------------------------------------------------
local function is_roof(node)
    if not node then return false end
    return minetest.get_item_group(node.name, "slab") > 0
end

---------------------------------------------------------
-- Scan area around player
---------------------------------------------------------
local function detect_house(player)
    local pos = player:get_pos()
    local p1 = vector.add(pos, {-8, -1, -8})
    local p2 = vector.add(pos, { 8, 8,  8})

    -----------------------------------------------------
    -- Check walls
    -----------------------------------------------------
    local wall_nodes = 0

    for x = p1.x, p2.x do
    for y = p1.y, p1.y + 3 do
    for z = p1.z, p2.z do
        local node = minetest.get_node({x=x,y=y,z=z})
        if is_wall(node) then
            wall_nodes = wall_nodes + 1
        end
    end
    end
    end

    if wall_nodes < 25 then
        return false, "not enough walls"
    end


    -----------------------------------------------------
    -- Check roof
    -----------------------------------------------------
    local roof_found = false
    for x = p1.x, p2.x do
    for z = p1.z, p2.z do
        local node = minetest.get_node({x=x, y=p2.y, z=z})
        if is_roof(node) then
            roof_found = true
            break
        end
    end
    end

    if not roof_found then
        return false, "no roof"
    end


    -----------------------------------------------------
    -- Check for furniture (bed + crafting table)
    -----------------------------------------------------
    local bed = false
    local craft = false

    for x = p1.x, p2.x do
    for y = p1.y, p2.y do
    for z = p1.z, p2.z do
        local node = minetest.get_node({x=x, y=y, z=z}).name

        if node:find("bed") then bed = true end
        if node:find("craft") then craft = true end

        if bed and craft then break end
    end
    if bed and craft then break end
    end
    if bed and craft then break end
    end

    if not bed then return false, "no bed" end
    if not craft then return false, "no crafting table" end

    return true
end

---------------------------------------------------------
-- Called once when level starts
---------------------------------------------------------
function level3.start(name)
    playername = name
    elapsed = 0
    finished = false

    minetest.chat_send_player(name, "LEVEL 3: Build a house!")
    minetest.chat_send_player(name, "- Hollow box with walls")
    minetest.chat_send_player(name, "- Roof on top")
    minetest.chat_send_player(name, "- Must include a bed")
    minetest.chat_send_player(name, "- Must include a crafting table")
    minetest.chat_send_player(name, "- You have 5 minutes.")
end

---------------------------------------------------------
-- Main update loop — call this every frame or tick
---------------------------------------------------------
function level3.update(dtime)
    if finished then return end
    elapsed = elapsed + dtime

    local player = minetest.get_player_by_name(playername)
    if not player then return end

    -- Check for house creation
    local ok, reason = detect_house(player)
    if ok then
        finished = true
        minetest.chat_send_player(playername, "HOUSE DETECTED! YOU WIN!")
        return { won = true }
    end

    -- Time out
    if elapsed >= TIME_LIMIT then
        finished = true
        minetest.chat_send_player(playername,
            "Time is up! House incomplete. You lose.")
        return { won = false }
    end

    return nil
end

---------------------------------------------------------
-- Level cleanup (optional)
---------------------------------------------------------
function level3.stop()
    finished = true
end

return level3
