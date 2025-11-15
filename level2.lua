-- level2.lua (fixed)

local socket = require("socket")
math.randomseed(os.time())

local MAP_WIDTH = 100
local MAP_HEIGHT = 37

local player = {
    x = 5, y = 10,
    wood = 0,
    netherite = 0,
    sword = true,
    armor = {helmet=false, chest=false, leggings=false, boots=false},
    inHouse = false,
    inCave = false,
    zombieAlive = false
}

local gui = { message = "Welcome! Chop trees, mine netherite, craft full armor!", craftingOpen = false }

local zombie = { hp = 3, spawnTimer = 60, lastSpawn = socket.gettime() }

local SYMBOLS = { empty=" ", tree="T", house="H", craftingTable="C", cave=">", zombie="Z", player="☻", bed="B" }

-- Generate map
local map = {}
for y=1, MAP_HEIGHT do
    map[y] = {}
    for x=1, MAP_WIDTH do
        map[y][x] = SYMBOLS.empty
    end
end

-- Trees
for i=1, 70 do
    local tx, ty = math.random(1, MAP_WIDTH-2), math.random(1, MAP_HEIGHT-2)
    map[ty][tx] = SYMBOLS.tree
end

-- House
local houseX, houseY = 30,5
map[houseY][houseX] = SYMBOLS.house
map[houseY+1][houseX] = SYMBOLS.craftingTable
map[houseY+1][houseX+1] = SYMBOLS.bed

-- Cave
local caveX, caveY = -10,5
map[caveY][caveX] = SYMBOLS.cave

local won = false
local quit = false -- new flag to handle leaving early

-- Draw map
local function drawMap()
    os.execute("clear")
    for y=1, MAP_HEIGHT do
        for x=1, MAP_WIDTH do
            if x==player.x and y==player.y then io.write(SYMBOLS.player)
            elseif player.zombieAlive and x==player.zombieX and y==player.zombieY then io.write(SYMBOLS.zombie)
            else io.write(map[y][x]) end
        end
        print()
    end
    print("\n"..gui.message)
    print(string.format("Wood: %d | Netherite: %d | Helmet: %s | Chest: %s | Leggings: %s | Boots: %s",
        player.wood, player.netherite,
        player.armor.helmet and "X" or "-",
        player.armor.chest and "X" or "-",
        player.armor.leggings and "X" or "-",
        player.armor.boots and "X" or "-"))
    if gui.craftingOpen then
        print("\nCrafting Menu: [helmet(4)] [chestplate(7)] [leggings(6)] [boots(4)] (type craft <item>)")
    end
    if player.zombieAlive then
        print("Zombie HP: "..zombie.hp.." (attack using 'attack')")
    end
end

local function tryWin()
    if player.armor.helmet and player.armor.chest and player.armor.leggings and player.armor.boots then
        won = true
        gui.message = "You crafted full Netherite Armor! You win!"
    end
end

local function chopTree()
    player.wood = player.wood + 4
    gui.message = "Chopped tree! Wood: "..player.wood
end

local function enterCave()
    if player.wood < 10 then gui.message = "Not enough wood to mine. Chop more trees!" return end
    player.inCave = true
    local mined = math.floor(player.wood / 10)
    player.wood = player.wood - mined*10
    player.netherite = player.netherite + mined
    gui.message = "Mined "..mined.." netherite!"
    player.inCave = false
end

local function enterHouse() player.inHouse=true; gui.message="Entered house. Crafting table available." end
local function leaveHouse() player.inHouse=false; gui.message="Left house." end
local function openCrafting()
    if player.inHouse then gui.craftingOpen=true; gui.message="Crafting menu open."
    else gui.message="You must be in house to craft." end
end
local function closeCrafting() gui.craftingOpen=false; gui.message="Crafting menu closed." end

local function craft(item)
    if not gui.craftingOpen then gui.message="Open crafting table first!" return end
    local cost = {helmet=4, chest=7, leggings=6, boots=4}
    if not cost[item] then gui.message="Unknown item."; return end
    if player.netherite>=cost[item] then
        player.netherite = player.netherite - cost[item]
        player.armor[item== "helmet" and "helmet" or item=="chestplate" and "chest" or item=="leggings" and "leggings" or "boots"] = true
        gui.message="Crafted "..item.."!"
        tryWin()
    else gui.message="Not enough netherite for "..item end
end

local function spawnZombie()
    if not player.zombieAlive then
        player.zombieAlive=true
        zombie.hp=3
        player.zombieX=math.random(1,MAP_WIDTH)
        player.zombieY=math.random(1,MAP_HEIGHT)
        gui.message="Zombie spawned!"
    end
end

local function attackZombie()
    if player.zombieAlive then
        zombie.hp = zombie.hp - 1
        if zombie.hp<=0 then player.zombieAlive=false; gui.message="Zombie killed!"
        else gui.message="Zombie hit! HP remaining: "..zombie.hp end
    else gui.message="No zombie to attack."
    end
end

local function update()
    if socket.gettime() - zombie.lastSpawn > zombie.spawnTimer then
        spawnZombie()
        zombie.lastSpawn = socket.gettime()
    end
end

local function showHelp()
    gui.message = "Commands: w/a/s/d to move, chop to chop tree, enter/leave house (H), open/close crafting (C), enter cave, leave to quit, attack zombie, help to display this message."
end

local function handleInput(input)
    input = input:lower()
    if input=="w" then player.y = math.max(1,player.y-1)
    elseif input=="s" then player.y = math.min(MAP_HEIGHT,player.y+1)
    elseif input=="a" then player.x = math.max(1,player.x-1)
    elseif input=="d" then player.x = math.min(MAP_WIDTH,player.x+1)
    elseif input=="chop" then if map[player.y][player.x]==SYMBOLS.tree then chopTree(); map[player.y][player.x]=SYMBOLS.empty else gui.message="No tree here." end
    elseif input=="enter house" then if map[player.y][player.x]==SYMBOLS.house then enterHouse() else gui.message="No house here." end
    elseif input=="leave house" then leaveHouse()
    elseif input=="open crafting" then openCrafting()
    elseif input=="close crafting" then closeCrafting()
    elseif input:sub(1,6)=="craft " then craft(input:sub(7))
    elseif input=="enter cave" then if map[player.y][player.x]==SYMBOLS.cave then enterCave() else gui.message="No cave here." end
    elseif input=="attack" then attackZombie()
    elseif input=="leave" then gui.message="Leaving game..." print("JOHN WILL NOT BE HAPPY"); quit=true
    elseif input=="help" then showHelp()
    else gui.message="Unknown command. Type help to see commands." end
end

-- Main loop
while not won and not quit do
    drawMap()
    io.write("> ")
    local input = io.read()
    handleInput(input)
    update()
end

-- End game
if won then
    return {won=true}
else
    return {won=false}
end
