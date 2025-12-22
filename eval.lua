-- =========================
-- File read
-- =========================
function fileopen(path, mode)
    local f = assert(io.open(path, mode))
    local data = f:read("*a")
    f:close()
    return data
end

-- =========================
-- Escape / Unescape
-- =========================
function escape(str)
    return (str:gsub(".", function(c)
        return string.format("%%%02X", string.byte(c))
    end))
end

function unescape(str)
    return (str:gsub("%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
    end))
end

-- =========================
-- Vigenère cipher
-- =========================
function vigcipherenc(text, key)
    local out = {}
    local klen = #key
    for i = 1, #text do
        local t = text:byte(i)
        local k = key:byte((i - 1) % klen + 1)
        out[i] = string.char((t + k) % 256)
    end
    return table.concat(out)
end

function vigcipherdec(text, key)
    local out = {}
    local klen = #key
    for i = 1, #text do
        local t = text:byte(i)
        local k = key:byte((i - 1) % klen + 1)
        out[i] = string.char((t - k) % 256)
    end
    return table.concat(out)
end

-- =========================
-- Eval
-- =========================
function eval(code)
    local f, err = load(code)
    if not f then error(err) end
    return f()
end

-- =========================
-- Main logic
-- =========================

local key1 = "FIRSTKEY123"
local key2 = "SECONDKEY456"

-- 1. Read file
local filecontents = fileopen("main.lua", "r")

-- 2. Double escape
local qw = escape(escape(filecontents))

-- 3. Double Vigenère encode
local deco = vigcipherenc(
    vigcipherenc(qw, key1),
    key2
)

-- 4. Decode back
local decoded = unescape(
    unescape(
        vigcipherdec(
            vigcipherdec(deco, key2),
            key1
        )
    )
)

-- 5. Output
print("ENCODED:")
print(deco)

print("\nDECODED:")
print(decoded)

-- Optional: execute decoded Lua
eval(decoded)
