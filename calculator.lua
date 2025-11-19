print("Number A")
local a = io.read()
print("Number B")
local b = io.read()

if tonumber(a) == nil and tonumber(b) == nil then 
	print("Result:\n" .. a .. b)
	print("Div:\n" ..  a .. "/" .. b)
elseif tonumber(a) == nil or tonumber(b) == nil then
	print("Result:\n" .. a .. b)
	print("Div:\n" .. tonumber(a, 16) .. "/" ..  tonumber(b, 16))
	print(a .. " or " .. b .. " in decimal: " .. a .. " + 0, " .. b .. " + 0")

end
