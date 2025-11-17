-- insane_roguelike.lua
-- Pure Lua terminal roguelike (no external libs). Run with: lua insane_roguelike.lua

local s = require("soundmod")
math.randomseed(os.time())

-- CONFIG
local MAP_W, MAP_H = 100, 32
local FOV_RADIUS = 12
local INITIAL_HP = 50
local FLOORS_TO_WIN = 5

-- Tile types
local TILE_WALL = '█'
local TILE_FLOOR = '░'
local TILE_STAIRS = '>'
local TILE_UNKNOWN = ' '

-- Entities
local entities = {}
local player = nil
local floor_number = 1
local game_over = false
local victory = false
local message_log = {}

local function playsongg()
    local cmd = string.format(
        "ffplay -nodisp -autoexit -loop 14 -hide_banner -loglevel quiet nightprowler.ogg > /dev/null 2>&1" 
    )
    os.execute(cmd)
end


local function log(msg)
    table.insert(message_log, 1, msg)
    if #message_log > 6 then table.remove(message_log) end
end

-- Utils
local function rand(a,b) if b then return math.random(a,b) else return math.random(a) end end
local function clamp(x,a,b) if x<a then return a elseif x>b then return b else return x end end

-- Map generator: cellular automata cave
local function new_map(w,h)
    local map = {}
    for y=1,h do
        map[y] = {}
        for x=1,w do
            -- border walls
            if x==1 or y==1 or x==w or y==h then map[y][x]=TILE_WALL
            else
                map[y][x] = (math.random() < 0.44) and TILE_WALL or TILE_FLOOR
            end
        end
    end

    local function count_walls(mx,my)
        local count = 0
        for yy=my-1,my+1 do
            for xx=mx-1,mx+1 do
                if xx<1 or yy<1 or xx>w or yy>h or map[yy][xx]==TILE_WALL then count = count + 1 end
            end
        end
        return count
    end

    -- run simulation
    for i=1,5 do
        local newmap = {}
        for y=1,h do
            newmap[y] = {}
            for x=1,w do
                if x==1 or y==1 or x==w or y==h then newmap[y][x]=TILE_WALL
                else
                    local walls = count_walls(x,y)
                    if walls > 4 then newmap[y][x]=TILE_WALL
                    elseif walls < 4 then newmap[y][x]=TILE_FLOOR
                    else newmap[y][x]=map[y][x] end
                end
            end
        end
        map = newmap
    end

    -- ensure connectivity by flood fill from a floor tile
    local sx, sy
    for y=2,h-1 do for x=2,w-1 do if map[y][x]==TILE_FLOOR then sx,sy=x,y; break end end if sx then break end end
    if not sx then
        -- fallback: open center
        map[math.floor(h/2)][math.floor(w/2)] = TILE_FLOOR
        sx,sy = math.floor(w/2), math.floor(h/2)
    end

    local visited = {}
    local stack = {{sx,sy}} visited[sy] = {} visited[sy][sx]=true
    while #stack>0 do
        local cx,cy = table.unpack(table.remove(stack))
        for _,d in ipairs({{1,0},{-1,0},{0,1},{0,-1}}) do
            local nx,ny = cx+d[1], cy+d[2]
            if nx>=2 and ny>=2 and nx<=w-1 and ny<=h-1 and not (visited[ny] and visited[ny][nx]) and map[ny][nx]==TILE_FLOOR then
                visited[ny] = visited[ny] or {}
                visited[ny][nx] = true
                table.insert(stack, {nx,ny})
            end
        end
    end

    -- Turn unreachable floor tiles into walls (keeps map connected)
    for y=2,h-1 do
        for x=2,w-1 do
            if map[y][x]==TILE_FLOOR and not (visited[y] and visited[y][x]) then
                map[y][x] = TILE_WALL
            end
        end
    end

    -- place stairs in a floor tile far from start
    local farx,fary, maxd = sx,sy, -1
    for y=2,h-1 do for x=2,w-1 do
        if map[y][x]==TILE_FLOOR then
            local d = (x-sx)*(x-sx) + (y-sy)*(y-sy)
            if d > maxd then maxd=d; farx,fary=x,y end
        end
    end end
    map[fary][farx] = TILE_STAIRS

    return map, sx, sy
end

-- Entities API
local function make_entity(x,y,ch,name,hp,atk)
    local e = {x=x,y=y,ch=ch,name=name,hp=hp,maxhp=hp,atk=atk}
    e.is_dead = function(self) return self.hp <= 0 end
    table.insert(entities, e)
    return e
end

local function remove_entity(e)
    for i,v in ipairs(entities) do if v==e then table.remove(entities,i); return end end
end

-- Spawn monsters and items
local function spawn_entities(map)
    entities = {}
    -- spawn player later via returned spawn point
    local options = {}
    for y=2,MAP_H-1 do for x=2,MAP_W-1 do
        if map[y][x]==TILE_FLOOR then table.insert(options,{x,y}) end
    end end

    -- shuffle options
    for i=1,#options do local j=rand(i,#options); options[i],options[j]=options[j],options[i] end

    -- spawn some monsters depending on floor number
    local monster_count = 6 + floor_number * 3
    for i=1,monster_count do
        local p = options[#options]; options[#options]=nil
        if not p then break end
        local x,y = p[1],p[2]
        -- decide monster type: goblin common, orc medium, stronger types deeper
        local typ = (math.random() < 0.6) and "goblin" or (math.random() < 0.7 and "orc" or "brute")
        local ch = (typ=="goblin") and 'g' or (typ=="orc" and 'o' or 'r')
        local hp = (typ=="goblin") and (5 + floor_number*1) or (typ=="orc" and 8 + floor_number*2 or 12 + floor_number*3)
        local atk = (typ=="goblin") and 2 or (typ=="orc" and 3 or 4)
        make_entity(x,y,ch,typ,hp,atk)
    end

    -- boss on final floor
    if floor_number == FLOORS_TO_WIN then
        local p = options[#options]; options[#options]=nil
        local bx,by = p[1],p[2]
        make_entity(bx,by,'B','The Abyssal Warden', 30 + 10*floor_number, 6)
    end

    -- place items
    local item_spots = 5 + floor_number*2
    local items = {}
    for i=1,item_spots do
        local p = options[#options]; options[#options]=nil
        if not p then break end
        local x,y = p[1],p[2]
        -- store as entity-like for simpler rendering, with special name
        local kind = math.random() < 0.6 and 'potion' or 'weapon'
        local ch = (kind=='potion') and '!' or '/'
        local it = {x=x,y=y,ch=ch,kind=kind,name=(kind=='potion' and 'Health Potion' or 'Rusty Sword')}
        table.insert(items,it)
    end

    return items
end

-- Field of view (simple circle + line-of-sight using Bresenham)
local function bresenham(x0,y0,x1,y1, cb)
    local dx = math.abs(x1-x0)
    local dy = -math.abs(y1-y0)
    local sx = x0 < x1 and 1 or -1
    local sy = y0 < y1 and 1 or -1
    local err = dx + dy
    local x,y = x0,y0
    while true do
        if cb(x,y) then return true end
        if x==x1 and y==y1 then break end
        local e2 = 2*err
        if e2 >= dy then err = err + dy; x = x + sx end
        if e2 <= dx then err = err + dx; y = y + sy end
    end
    return false
end

local function compute_fov(map, px, py, radius)
    local seen = {}
    for y=1,MAP_H do seen[y] = {} end
    for dy=-radius,radius do
        for dx=-radius,radius do
            local tx,ty = px+dx, py+dy
            if tx>=1 and ty>=1 and tx<=MAP_W and ty<=MAP_H then
                if dx*dx + dy*dy <= radius*radius then
                    local blocked = false
                    bresenham(px,py,tx,ty, function(x,y)
                        if map[y][x]==TILE_WALL and not (x==px and y==py) then blocked = true; return true end
                        return false
                    end)
                    if not blocked then seen[ty][tx] = true end
                end
            end
        end
    end
    return seen
end

-- Find entity at position
local function entity_at(x,y)
    for _,e in ipairs(entities) do if e.x==x and e.y==y then return e end end
    return nil
end

local function item_at(items,x,y)
    for i,it in ipairs(items) do if it.x==x and it.y==y then return i,it end end
    return nil
end

-- Combat
local function attack(attacker, defender)
    local atk = attacker.atk or 1
    -- player weapon modifies attack
    if attacker == player and player.weapon then atk = atk + player.weapon.atk_bonus end
    local dmg = rand(1,atk)
    -- only subtract hp if defender has hp (prevents attacking items)
    if defender.hp then
        defender.hp = defender.hp - dmg
        log( string.format("%s hits %s for %d damage", attacker.name or "Something", defender.name or "something", dmg) )
        -- call is_dead only if exists
        if defender.is_dead and defender:is_dead() then
            log((defender.name or "Enemy") .. " dies.")
            remove_entity(defender)
        end
    else
        log(string.format("%s hits %s but nothing happens.", attacker.name or "Something", defender.name or "something"))
    end
end


-- Player actions
local function use_item_from_inv(slot)
    local it = player.inventory[slot]
    if not it then log("No item in that slot."); return end
    if it.kind == 'potion' then
        local heal = 8
        player.hp = math.min(player.maxhp, player.hp + heal)
        log("You drink a potion and heal "..heal.." HP.")
        table.remove(player.inventory, slot)
    else
        log("Can't use that now.")
    end
end

-- Monster AI: simple chase if close, otherwise wander
local function monsters_take_turn(map, items)
    for i=#entities,1,-1 do
        local e = entities[i]
        -- skip dead
        if not e then goto cont end
        -- simple: if close to player, move towards or attack
        local dx = player.x - e.x
        local dy = player.y - e.y
        local dist2 = dx*dx + dy*dy
        if dist2 <= 2 then
            -- adjacent: attack
            attack(e, player)
            if player.hp <= 0 then
                game_over = true
                log("You have been slain...")
                return
            end
        elseif dist2 <= 25 then
            -- move toward player with 60% chance, else small random move
            if math.random() < 0.8 then
                local step_x = dx==0 and 0 or (dx>0 and 1 or -1)
                local step_y = dy==0 and 0 or (dy>0 and 1 or -1)
                local nx,ny = e.x + step_x, e.y + step_y
                if nx>=1 and ny>=1 and nx<=MAP_W and ny<=MAP_H and map[ny][nx] ~= TILE_WALL and not entity_at(nx,ny) and not (nx==player.x and ny==player.y) then
                    e.x, e.y = nx, ny
                end
            else
                -- minor wander
                local dirs = {{1,0},{-1,0},{0,1},{0,-1}}
                local d = dirs[rand(1,#dirs)]
                local nx,ny = e.x + d[1], e.y + d[2]
                if nx>=1 and ny>=1 and nx<=MAP_W and ny<=MAP_H and map[ny][nx] ~= TILE_WALL and not entity_at(nx,ny) and not (nx==player.x and ny==player.y) then
                    e.x, e.y = nx, ny
                end
            end
        else
            -- wander occasionally
            if math.random() < 0.2 then
                local dirs = {{1,0},{-1,0},{0,1},{0,-1}}
                local d = dirs[rand(1,#dirs)]
                local nx,ny = e.x + d[1], e.y + d[2]
                if nx>=1 and ny>=1 and nx<=MAP_W and ny<=MAP_H and map[ny][nx] ~= TILE_WALL and not entity_at(nx,ny) and not (nx==player.x and ny==player.y) then
                    e.x, e.y = nx, ny
                end
            end
        end
        ::cont::
    end
end

-- Rendering to terminal
local function clear_screen()
    io.write("\27[2J\27[H") -- ANSI clear + move cursor home
end

local function draw(map, items, fov)
    clear_screen()
    -- show minimal UI: floor, hp, inventory, messages
    print(string.format("Floor %d/%d    HP: %d/%d    Weapon: %s", floor_number, FLOORS_TO_WIN, player.hp, player.maxhp, (player.weapon and player.weapon.name) or "None"))
    print(string.rep("-", MAP_W))

    for y=1,MAP_H do
        local line = {}
        for x=1,MAP_W do
            local ch = TILE_UNKNOWN
            if fov[y][x] then
                local drew = false
                -- entity or item precedence
                if x==player.x and y==player.y then
                    ch = '@'
                    drew = true
                else
                    local e = entity_at(x,y)
                    if e then ch = e.ch; drew = true end
                end
                if not drew then
                    local it_index,it = item_at(items,x,y)
                    if it then ch = it.ch; drew = true end
                end
                if not drew then ch = map[y][x] end
            else
                ch = TILE_UNKNOWN
            end
            table.insert(line, ch)
        end
        print(table.concat(line))
    end

    print(string.rep("-", MAP_W))
    -- inventory
    io.write("Inv: ")
    for i,it in ipairs(player.inventory) do
        io.write(string.format("[%d]%s ", i, it.name))
    end
    print()
    -- messages
    for i=1,6 do
        if message_log[i] then print(message_log[i]) else print() end
    end
    print("Commands: (h/j/k/l) move, (y/u/b/n) diagonals, i use inv, g pick up, > descend, q quit\n @ player, o orc, g goblin, > stairs (to descend), discover the others...")
    io.write("> ")
end

-- Movement handling and player turn
local function try_move(map, items, dx, dy)
    local nx,ny = player.x + dx, player.y + dy
    if nx<1 or ny<1 or nx>MAP_W or ny>MAP_H then return end
    if map[ny][nx] == TILE_WALL then log("You bump into a wall."); return end
    local e = entity_at(nx,ny)
    if e then
        -- attack
        attack(player, e)
if e and e.is_dead and e:is_dead() then
    -- if boss died, set victory if last floor boss
    if e.ch == 'B' then
        log("You have slain the boss!")
        victory = true
        game_over = true
    end
end

    else
        -- move
        player.x, player.y = nx, ny
        -- pick up items automatically? no, require 'g'
    end
end

local function pick_up(items)
    local idx,it = item_at(items, player.x, player.y)
    if it then
        if it.kind == 'potion' then
            table.insert(player.inventory, {kind='potion', name='Potion'})
            table.remove(items, idx)
            log("Picked up a potion.")
        elseif it.kind == 'weapon' then
            player.weapon = {name=it.name, atk_bonus = 2 + floor_number}
            table.remove(items, idx)
            log("Picked up a weapon: "..player.weapon.name)
        end
    else
        log("Nothing to pick up here.")
    end
end

-- Player turn prompt
local function player_turn(map, items, fov)
    draw(map, items, fov)
    local cmd = io.read()
    if not cmd then game_over = true; return end
    cmd = cmd:lower()
    if cmd == 'q' then game_over = true; return end
    local moves = {
        h = {-1,0}, j={0,1}, k={0,-1}, l={1,0},
        y={-1,-1}, u={1,-1}, b={-1,1}, n={1,1},
        ['4']={-1,0}, ['2']={0,1}, ['8']={0,-1}, ['6']={1,0}
    }
    if moves[cmd] then
        local d = moves[cmd]
        try_move(map, items, d[1], d[2])
        return true
    elseif cmd == 'g' then
        pick_up(items); return true
    elseif cmd == 'i' then
        -- show inv and ask slot to use
        if #player.inventory == 0 then log("Inventory empty."); return true end
        log("Choose slot to use (number):")
        draw(map, items, fov)
        local s = io.read()
        local n = tonumber(s)
        if n and player.inventory[n] then use_item_from_inv(n) else log("Invalid slot") end
        return true
    elseif cmd == '>' then
        -- if on stairs
        if map[player.y][player.x] == TILE_STAIRS then
            floor_number = floor_number + 1
            log("You descend to floor "..floor_number..".")
            return 'descend'
        else
            log("No stairs here.")
            return true
        end
    else
        log("Unknown command.")
        return true
    end
end

-- Place player at spawn
local function place_player(map, sx, sy)
    player = {x=sx, y=sy, name='You', hp=INITIAL_HP, maxhp=INITIAL_HP, atk=5, inventory={}, weapon=nil}
end

-- Main loop: generate floor, spawn entities, loop until descend or gameover
local function run_floor()
    local map, sx, sy = new_map(MAP_W, MAP_H)
    place_player(map, sx, sy)
    local items = spawn_entities(map)
    local items_table = items

    -- Ensure player doesn't spawn on entity or item: if so, move until valid
    if entity_at(player.x, player.y) then
        -- try to nudge
        for _,d in ipairs({{1,0},{-1,0},{0,1},{0,-1}}) do
            local nx,ny = player.x+d[1], player.y+d[2]
            if map[ny][nx]==TILE_FLOOR and not entity_at(nx,ny) then player.x,player.y=nx,ny; break end
        end
    end

    while true do
        local fov = compute_fov(map, player.x, player.y, FOV_RADIUS)
        local action = player_turn(map, items_table, fov)
        if action == 'descend' then
            return 'descend'
        end
        if game_over then return 'dead' end
        -- monsters turn
        monsters_take_turn(map, items_table)
        if game_over then return 'dead' end
    end
end

-- Game start
local function start_game()
    floor_number = 1
    player = nil
    entities = {}
    message_log = {}
    game_over = false
    victory = false
    log("Welcome to level 3! You only get one chance to beat this level..")
    log("Goal: Descend to floor "..FLOORS_TO_WIN.." and defeat the Abyssal Warden.")
    while not game_over do
        local result = run_floor()
        if result == 'descend' then
            if floor_number > FLOORS_TO_WIN then
                -- if you descended past final floor, something's off; treat as victory
                victory = true
                game_over = true
                break
            end
            -- continue to next floor
        elseif result == 'dead' then
            break
        end
    end

    clear_screen()
    if victory then
        print("\n\n\n")
        print("|=======================================================|")
        print("|                 VICTORY! You win.                     |")
        print("|You defeated the Abyssal Warden and escaped the depths.|")
        print("|=======================================================|")
        os.execute("sleep 1")
        return {won=true}
    else
        print("\n\n\n")
        print("|=======================================|")
        print("|              GAME OVER                |")
        print("|     You perished in the caverns.      |") 
        print("|=======================================|")
        s.gov(1)
        os.execute("sleep 1")
        return {won=false}
    end
    print("Thanks for playing.")
end

-- tiny entry menu
local function show_menu()
    clear_screen()
    print("LEVEL 3!!! YOUR CHANCE TO PROVE YOURSELF")
    print("(Set your terminal text size smaller until you see the status bar.)\nTo stop music after playing, do command 'killall ffplay' on linux\n    task manager for windows.\nControls: h/j/k/l to move, y/u/b/n diagonals, g pick up, i use inventory, > descend, q quit")
    print("Press Enter to start...")
    io.read()
    print("\n\n\n\n BUT BEFORE YOU PLAY!!")
    print("Listen to some music. There is no music in the level yet.\n maybe like brainstorm idk.\nCTRL+C to stop and play")
    
    playsongg()
    start_game()
    
end

show_menu()
