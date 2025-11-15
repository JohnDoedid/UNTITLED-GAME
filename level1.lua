local config = {
	["characters"] = {
		["snakeHead"] = "O",
		["snakeTail"] = "█",
		["food"] = "+",
		["background"] = "▒"
	},
	["dynamicSnakeHead"] = true,
	["dynamicSnakeTail"] = true,
	["canvas"] = {
		["size"] = {
			["x"] = 20,
			["y"] = 10
		}
	}
}

--

require("math")

local snake = {
	["head"] = {
		["pos"] = {
			["x"] = math.floor(config.canvas.size.x/4),
			["y"] = math.floor(config.canvas.size.y/2)
		}
	},
	["tails"] = {
		[1] = {
			["pos"] = {
				["x"] = math.floor(config.canvas.size.x/4)-1,
				["y"] = math.floor(config.canvas.size.y/2)
			},
			["con"] = 0
		}
	},
	["dir"] = 4
}

local food = {
	["pos"] = {
		["x"] = math.floor(config.canvas.size.x/4)*3+1,
		["y"] = math.floor(config.canvas.size.y/2)
	}
}

local activations = {
	["gameOver"] = false,
}

local score = 0

local openspaces = {}
local openspacesclone

--

local function render()
	if config.dynamicSnakeHead then
			local dir = snake.dir
			if dir==1 then
				config.characters.snakeHead = "^"
			elseif dir==2 then
				config.characters.snakeHead = "<"
			elseif dir==3 then
				config.characters.snakeHead = "V"
			elseif dir==4 then
				config.characters.snakeHead = ">"
			end
		end
		--[[
		if config.dynamicSnakeTail then
			local dir = snake.dir
			if dir==1 then
				config.characters.snakeTail = "|"
			elseif dir==2 then
				config.characters.snakeTail = "-"
			elseif dir==3 then
				config.characters.snakeTail = "|"
			elseif dir==4 then
				config.characters.snakeTail = "-"
			end
		end
		--]]

	for y = 0, config.canvas.size.y-1 do
		local row = ""
		local showbackground = 0
		for x = 0, config.canvas.size.x-1 do
			if x==snake.head.pos.x and y==snake.head.pos.y then
				row = row..config.characters.snakeHead
				showbackground = showbackground + 1
			elseif x==food.pos.x and y==food.pos.y then
				row = row..config.characters.food
				showbackground = showbackground + 1
			end
			for i, tail in pairs(snake.tails) do
				if x==tail.pos.x and y==tail.pos.y then
					showbackground = showbackground + 1
					row = row..config.characters.snakeTail
				end
			end
			if showbackground==0 then
				row = row..config.characters.background
			else
				showbackground = showbackground - 1
			end
		end
		print(row)
	end
end

local function headMoveDir(dir)
	if dir==1 then
		snake.head.pos.y = snake.head.pos.y - 1
	elseif dir==2 then
		snake.head.pos.x = snake.head.pos.x -1
	elseif dir==3 then
		snake.head.pos.y = snake.head.pos.y + 1
	elseif dir==4 then
		snake.head.pos.x = snake.head.pos.x + 1
	end
end

local function gameOver()
	print("GAME OVER")
	activations.gameOver = true
	return {won=false}
end
local function gameWin()
	print("YOU WIN!")
	activations.gameOver = true
	return {won=true}
end

local function cloneTable(Table)
	local tablexd = {}
	for i, v in pairs(Table) do
		tablexd[#tablexd+1] = v
	end
	return  tablexd
end

--

math.randomseed(os.time())

for x = 0, config.canvas.size.x-1 do
	for y = 0, config.canvas.size.y-1 do
		openspaces[#openspaces+1] = {
			["x"] = x,
			["y"] = y
		}
	end
end
openspacesclone = cloneTable(openspaces)

while true do
	if not activations.gameOver then
		render()
		local input = io.read()

		openspacesclone = cloneTable(openspaces)
		for i = 0, #snake.tails do
			if i~=#snake.tails then
				local tail = snake.tails[#snake.tails-i]
				if tail.con==0 then
					tail.pos.x = snake.head.pos.x
					tail.pos.y = snake.head.pos.y
				else
					tail.pos.x = snake.tails[tail.con].pos.x
					tail.pos.y = snake.tails[tail.con].pos.y
				end

				for i, v in pairs(openspacesclone) do
					if v.x==tail.pos.x and v.y==tail.pos.y then
						table.remove(openspacesclone, i)
					end
				end
			end
		end
		openspacesclone[#openspacesclone+1] = {["x"]=snake.head.pos.x, ["y"]=snake.head.pos.y}
		print(#openspacesclone)

		local wwssadadba = false

		if input=="w" then
			if snake.dir~=3 then
				snake.dir = 1
			end
		elseif input=="a" then
			if snake.dir~=4 then
				snake.dir = 2
			end
		elseif input=="s" then
			if snake.dir~=1 then
				snake.dir = 3
			end
		elseif input=="d" then
			if snake.dir~=2 then
				snake.dir = 4
			end
		elseif input=="wwssadadba-tpfood" then
			if snake.dir==2 then
				snake.head.pos.x = food.pos.x+1
				snake.head.pos.y = food.pos.y
			elseif snake.dir==4 then
				snake.head.pos.x = food.pos.x-1
				snake.head.pos.y = food.pos.y
			elseif snake.dir==1 then
				snake.head.pos.x = food.pos.x
				snake.head.pos.y = food.pos.y+1
			elseif snake.dir==3 then
				snake.head.pos.x = food.pos.x
				snake.head.pos.y = food.pos.y-1
			end
		elseif input=="wwssadadba-10" then
			for i = 1, 10 do
				local len = #snake.tails
				snake.tails[len+1] = {
					["pos"] = {
						["x"] = -1,
						["y"] = -1
					},
					["con"] = len
				}
				score = score + 1
			end
		end

		--move head
		headMoveDir(snake.dir)

		--check if found food
		if snake.head.pos.x==food.pos.x and snake.head.pos.y==food.pos.y then
			if #openspacesclone~=1 then
				local len = #snake.tails
				snake.tails[len+1] = {
					["pos"] = {
						["x"] = -1,
						["y"] = -1
					},
					["con"] = len
				}
				score = score + 1

				local ok = {
					["x"] = openspacesclone[math.random(1, #openspacesclone)].x,
					["y"] = openspacesclone[math.random(1, #openspacesclone)].y
				}

				food.pos.x = ok.x
				food.pos.y = ok.y

				print("FOOD POS TP TO",ok.x, ok.y)
			end
		end

		--check if running into tail
		for i, tail in pairs(snake.tails) do
			if snake.head.pos.x==tail.pos.x and snake.head.pos.y==tail.pos.y then
				gameOver()
				os.execute("sleep 1")
				return {won=false}
			end
		end

		--check if running into wall
		if snake.head.pos.x<0 or snake.head.pos.y<0 or snake.head.pos.x==config.canvas.size.x or snake.head.pos.y==config.canvas.size.y then
			gameOver()
			os.execute("sleep 1")
			return {won=false}
		end

		if #openspacesclone==2 then
			gameWin()
			os.execute("sleep 1")
			return {won=true}
		end

		
		
	end
end
