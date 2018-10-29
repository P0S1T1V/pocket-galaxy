-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local background = display.newRect(160, 250, 320, 550) 
background:setFillColor(0.1, 0.1, 0.1) 

local blackhole = display.newImage('blackhole.png', display.contentCenterX, display.contentCenterY)
blackhole:scale(0.15, 0.15)

local PlanetRadius = 10
local planet = display.newCircle(display.contentCenterX, display.contentCenterY, PlanetRadius)

planet.y = planet.y - 100
planet.x = planet.x + 50

local physics = require( "physics" )
physics.start()  -- Start the physics engine
physics.setGravity( 0, 0 ) 

physics.addBody( blackhole, "static", { isSensor=true, radius=30 } )
physics.addBody(planet, 'dynamic', {isSensor=true,radius=10})

local qx=0
local qy=0
local v=0

local function onUpdate (event)
    local distance = math.sqrt(math.pow(math.abs(blackhole.x-planet.x),2)+math.pow(math.abs(blackhole.y-planet.y),2))
    if (blackhole.x>=planet.x) then
        if (blackhole.y>=planet.y) then
            qx=1
            qy=1
        else 
            qx=1
            qy=-1
        end
    elseif (blackhole.y>=planet.y) then
        qx=-1
        qy=1
    else 
        qx=-1
        qy=-1
    end

    if (distance>=45) then
        v=4
    elseif (distance<=45) and (distance>=40) then
        v=8
    elseif (distance<=40) and (distance>=35) then
        v=12
    elseif (distance<=35) and (distance>=30) then
        v=16
    elseif (distance<=30) and (distance>=25) then
        v=20
    elseif (distance<=25) and (distance>=20) then
        v=24
    elseif (distance<=20) and (distance>=15) then
        v=28
    elseif (distance<=15) and (distance>=10) then
        v=7.5
    elseif (distance<=10) and (distance>=5) then
        v=8
    elseif (distance<=5) and (distance>=0) then
        v=8.5
    end
    local speedx=(math.abs(blackhole.x-planet.x)/math.abs(blackhole.y-planet.y))*qx*v
    local speedy=(math.abs(blackhole.y-planet.y)/math.abs(blackhole.x-planet.x))*qy*v
    planet:setLinearVelocity( speedx, speedy )
end

Runtime:addEventListener("enterFrame", onUpdate)
