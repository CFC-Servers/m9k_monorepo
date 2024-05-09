M9K = M9K or {}

resource.AddWorkshop( "3114933414" ) -- Monorepo Content

local expectedTickSpeed = 1 / 67
local tickSpeed = engine.TickInterval()
M9K.TickspeedMult = tickSpeed / expectedTickSpeed
