local wirelessNIC = peripheral.find("modem", function(name, modem)
    return modem.isWireless()
end)
local thrusters = {peripheral.find("thruster")}
local locs =
{
  ["fore"] = 2002,
  ["starboard"] = 2003,
  ["aft"] = 2004,
  ["port"] = 2005,
  ["vertical"] = 2006,
}
local validLoc = false
local location = ""
while not validLoc do
  io.write("Please enter the thruster group location (fore/aft/port/starboard/vertical)")
  location = string.lower(io.read())
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
local registrationPayload = { location = #location }
wirelessNIC.transmit(2000,locs[location],registration Payload)

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
    
