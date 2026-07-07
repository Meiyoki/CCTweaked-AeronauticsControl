local wirelessNIC = peripheral.find("modem", function(name, modem)
    return modem.isWireless()
)
wirelessNIC.open(2001)
local relays = {peripheral.find("redstone_relay")}
local forwardSensor = relays[1]
local rightSensor = relays[2]
local backSensor = relays[3]
local leftSensor = relays[4]
local throttleSensor = relays[5]
local gyro = peripheral.find("gimbal_sensor")

local verticalThrust = 0

while true do
    if math.abs(gyro.getAngles()[1]) > 15 or math.abs(gyro.getAngles()[2]) < 15 then
        wirelessNIC.transmit(2002, 2001, 0)
        wirelessNIC.transmit(2003, 2001, 0)
        wirelessNIC.transmit(2004, 2001, 0)
        wirelessNIC.transmit(2005, 2001, 0)
        wirelessNIC.transmit(2006, 2001, 0)
    else
        wirelessNIC.transmit(2002, 2001, forwardSensor.getAnalogueInput("front"))
        wirelessNIC.transmit(2003, 2001, rightSensor.getAnalogueInput("right"))
        wirelessNIC.transmit(2004, 2001, backSensor.getAnalogueInput("back"))
        wirelessNIC.transmit(2005, 2001, leftSensor.getAnalogueInput("left"))
        verticalThrust = throttleSensor.getAnalogueInput("back")
        if(throttleSensor.getAnalogueInput("top") == 15) then
            verticalThrust = 0 - verticalThrust
        end
        wirelessNIC.transmit(2006, 2001, verticalThrust)
    end
end
