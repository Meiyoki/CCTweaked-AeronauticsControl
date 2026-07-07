local wirelessNIC = peripheral.find("modem", function(name, modem)
    return modem.isWireless()
end)
local thrusters = {peripheral.find("thruster")}
local locs =
{
  ["front"] = 2002,
  ["right"] = 2003,
  ["back"] = 2004,
  ["left"] = 2005,
  ["vertical"] = 2006,
}
local validLoc = false
local location = ""
while not validLoc do
  io.write("Please enter the thruster group location (front/back/left/right/vertical)")
  location = io.read()
  if(locs[location]) then
    validLoc = true
  else
    io.write("Invalid location entered")
  end
end
wirelessNIC.open(locs[location])
for i,v in ipairs(thrusters) do
  v.setControlMode("computer")
end
wirelessNIC.transmit(2001,locs[location],location .. "-" .. #location)

local errorState = false

while not errorState do
  eventData = os.pullEvent("modem_message")
  for i,v in ipairs(thrusters) do
    v.setThrottle(eventData[5])
    if(v.getFuel() == 0) then
      errorState = true
      wirelessNIC.transmit(2001, locs[location], -1)
    end
  end
end
for i,v in ipairs(thrusters) do
  v.setThrottle(0)
end
    
