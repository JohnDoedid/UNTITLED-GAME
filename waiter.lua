math.randomseed(os.time())

------------------------------------------------------------
-- UTIL: Terminal dimensions
------------------------------------------------------------
local function termHeight()
    local f = io.popen("tput lines 2>/dev/null")
    if not f then return 25 end
    local h = tonumber(f:read("*n"))
    f:close()
    return h or 25
end

local function termWidth()
    local f = io.popen("tput cols 2>/dev/null")
    if not f then return 80 end
    local w = tonumber(f:read("*n"))
    f:close()
    return w or 80
end

------------------------------------------------------------
-- UTIL: Centered text
------------------------------------------------------------
local function center(text)
    local width = termWidth()
    local padding = math.floor((width - #text) / 2)
    if padding < 0 then padding = 0 end
    print(string.rep(" ", padding) .. text)
end

------------------------------------------------------------
-- UTIL: Micro-stalls
------------------------------------------------------------
local function microStall()
    if math.random(1, 100) <= 5 then
        os.execute("sleep " .. tostring(math.random() * 0.15 + 0.05))
    end
end

------------------------------------------------------------
-- UTIL: Network pauses
------------------------------------------------------------
local netPauses = {
    "Resolving DNS...",
    "Waiting for socket...",
    "Network congestion detected...",
    "Idle handshake phase...",
    "TCP slow-start...",
    "Retransmission timeout...",
    "Negotiating ciphers...",
}

local function randomPauseEvent()
    if math.random(1, 40) == 1 then
        center(netPauses[math.random(#netPauses)])
        os.execute("sleep " .. tostring(math.random() * 0.9 + 0.3))
    end
end

------------------------------------------------------------
-- Bottom fixed progress bar with live packet count & speed
------------------------------------------------------------
local function bottomProgress(label, current, total, packetCount, speed)
    local width = termWidth() - 35
    if width < 10 then width = 10 end

    local ratio = current / total
    local filled = math.floor(ratio * width)
    local bar = string.rep("#", filled) .. string.rep("-", width - filled)

    local h = termHeight()
    io.write(string.format("\27[%d;1H", h))  -- move to bottom line
    io.write("\27[2K")                        -- clear line
    io.write(string.format("[%s] %3d%%  %s | %d pkts | %.1f Mbps",
        bar, math.floor(ratio * 100), label, packetCount, speed))
    io.write("\27[u")  -- restore cursor
    io.flush()
end

------------------------------------------------------------
-- Log tables
------------------------------------------------------------
local sites = {
    "cdn.micromedium.com","player.one","www.goggles-eyewear.images",
    "dkms.lnx","qpsk.com","microscan.net","static.corporatekiosk.org",
    "edge.qwpo.net","assets.alphapack.dev","io.fastlayer.cc","video.capsulecdn.tv",
    "pkg.subsystem.lnx","update.hardenednode.io","router.interlink.srv",
    "repo.astralcloud.app","images.triangletech.graphics",
    "content-x.blazonware.com/qpl","cdn.hydravision.net/sda",
    "endpoint.safemode.srv/wdw","mirror.falconpacket.io/iso/efi",
    "network.net/network/cfm","qpal.kaa/qpal/file/w/","epic.dot/repo/splunking/"
}

local logTypes = {
    "TLS Handshake requested for ","Connecting to ","Waiting for ",
    "Fetching files from ","Resolving DNS for ","Opening persistent session with ",
    "Received malformed packet from ","Retrying connection to ","Timed out while pinging ",
    "Authenticated successfully with ","Request queued by ","Negotiating secure cipher suite with ",
    "HTTP/2 upgrade requested by ","Packet loss detected from ","TLS handshake completed for ",
    "Following redirects from ","Initializing connection for ","","Initiating QUIC channel with ",
    "Redirected to ","Handshake validated for ","Session resumed for ",
    "Streaming data from ","Prefetching resources from "
}

local qapeo = {}

------------------------------------------------------------
-- Initialization block
------------------------------------------------------------
local init = [[
● netmon.service - Network Activity Monitor
Loaded: loaded (/usr/lib/systemd/system/netmon.service; enabled)
Active: active (running)
Tasks: 4 (limit: 18919)
Memory: 9.7M
CPU: 34ms
------------------------------------------------------
]]

-- Save cursor position
io.write("\27[s")

for line in init:gmatch("[^\r\n]+") do
    os.execute("sleep " .. tostring(math.random() * 0.5))
    center(line)
end

------------------------------------------------------------
-- Generation phase
------------------------------------------------------------
local totalLogs = 5000

for i = 1, totalLogs do
    local message = logTypes[math.random(#logTypes)] .. sites[math.random(#sites)]
    table.insert(qapeo, message)
    microStall()
    bottomProgress("Gather .db files", i, totalLogs, i, math.random(50,200))
end

print("\n")

------------------------------------------------------------
-- Playback phase (streaming logs)
------------------------------------------------------------
local packetCount = 0

os.execute("ffplay -nodisp -autoexit 5mb.ogg > /dev/null 2>&1 &")
for _, v in ipairs(qapeo) do
    packetCount = packetCount + 1

    randomPauseEvent()
    local speed = math.random(50, 200) + math.random()  -- Mbps simulation
    bottomProgress("Downloading files", packetCount, totalLogs, packetCount, speed)
    os.execute("sleep " .. tostring(math.random() * 1.3 + 0.05))
    center(v)
end

print("\nDone.\n")
