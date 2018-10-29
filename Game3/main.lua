-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local background = display.newRect(160, 250, 320, 550) 
background:setFillColor(0.1, 0.1, 0.1) 

local physics = require( "physics" )
physics.start()  -- Start the physics engine
physics.setGravity( 0, 0 )


local qx=0
local qy=0
local v=0

local function dragShip (event)
    local phase = event.phase
    if('began' == phase) then
        display.currentStage:setFocus(background)
        planet = display.newCircle(event.x,event.y, 10)
        physics.addBody(planet, 'dynamic', {isSensor=true,radius=10})
        x1 = event.x
        y1 = event.y
    elseif('moved' == phase) then
        x2= event.x
        y2=event.y
    elseif('ended' or 'cancelled') then
        local distance = math.sqrt(math.pow(math.abs(x1-x2),2)+math.pow(math.abs(y1-y2),2))
        if (x2>=x1) then
            if (y2>=y1) then
                qx=-1
                qy=-1
            else 
                qx=-1
                qy=1
            end
        elseif (y2>=y1) then
            qx=1
            qy=-1
        else 
            qx=1
            qy=1
        end

        if (distance>0) then
            v=10
        end
    local speedx=(math.abs(x2-x1)/math.abs(y2-y1))*qx*v
    local speedy=(math.abs(y2-y1)/math.abs(x2-x1))*qy*v
    planet:setLinearVelocity( speedx, speedy )
    end
end

background:addEventListener('touch', dragShip)