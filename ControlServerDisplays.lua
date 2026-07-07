local relays = {peripheral.find("redstone_relay")}
table.sort(relays, function(left,right)
    return peripheral.getName(left)<peripheral.getName(right)
end)
local forwardSensor = relays[1]
local rightSensor = relays[2]
local backSensor = relays[3]
local leftSensor = relays[4]
local throttleSensor = relays[5]
local altimeter = peripheral.wrap("top")
local gyro = peripheral.find("gimbal_sensor")
local displays = {peripheral.find("monitor")}
table.sort(displays, function(left,right) 
    return left.getSize() < right.getSize()
    end)
local largeDisplay1 = displays[3]
local largeDisplay2 = displays[2]
local smallDisplay = displays[1]

while true do
    largeDisplay1.clear()
    largeDisplay1.setCursorPos(1,1)
    largeDisplay1.write("Altitude Thrust: " .. throttleSensor.getAnalogueInput("back"))
    largeDisplay1.setCursorPos(1,2)
    largeDisplay1.write("Altitude Reverse: " .. tostring(throttleSensor.getAnalogueInput("top") == 15))
    largeDisplay1.setCursorPos(1,3)
    largeDisplay1.write("Forward Thrust: " .. forwardSensor.getAnalogueInput("front"))
    largeDisplay1.setCursorPos(1,4)
    largeDisplay1.write("Backward Thrust: " .. backSensor.getAnalogueInput("back"))
    largeDisplay1.setCursorPos(1,5)
    largeDisplay1.write("Left Thrust: " .. leftSensor.getAnalogueInput("left"))
    largeDisplay1.setCursorPos(1,6)
    largeDisplay1.write("Right Thrust: " .. rightSensor.getAnalogueInput("right"))

    registrations = settings.get("registrations.thrusters")
    largeDisplay2.clear()
    largeDisplay2.setCursorPos(1,1)
    largeDisplay2.write("Fore Thrusters: " .. registrations["fore"])
    largeDisplay2.setCursorPos(1,2)
    largeDisplay2.write("Aft Thrusters: " .. registrations["aft"])
    largeDisplay2.setCursorPos(1,1)
    largeDisplay2.write("Port Thrusters: " .. registrations["port"])
    largeDisplay2.setCursorPos(1,1)
    largeDisplay2.write("Starboard Thrusters: " .. registrations["starboard"])
    largeDisplay2.setCursorPos(1,1)
    largeDisplay2.write("Vertical Thrusters: " .. registrations["vertical"])
    
    smallDisplay.clear()
    smallDisplay.setCursorPos(1,1)
    smallDisplay.write("Altitude: " .. altimeter.getHeight())
    smallDisplay.setCursorPos(1,2)
    smallDisplay.write("Angles: " .. (math.floor(gyro.getAngles()[1]*10^4)/10^4) .. ", " .. (math.floor(gyro.getAngles()[2]*10^4)/10^4))
    sleep(0.5)
end
