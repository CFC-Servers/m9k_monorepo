ENT.Type              = "anim"
ENT.PrintName         = "satellite of love"
ENT.Author            = ""
ENT.Contact           = ""
ENT.Purpose           = ""
ENT.Instructions      = ""
ENT.Spawnable         = false
ENT.AdminOnly         = true
ENT.DoNotDuplicate    = true
ENT.DisableDuplicator = true

ENT.PoorBastard       = false
ENT.Target            = false

if SERVER then
    AddCSLuaFile()

    --[[---------------------------------------------------------
   Name: ENT:Initialize()
-----------------------------------------------------------]]
    function ENT:Initialize()
        self.CanTool = false

        self:SetModel( "models/maxofs2d/hover_classic.mdl" ) --fix that
        self:SetMoveType( MOVETYPE_FLY )
        self:DrawShadow( false )

        --self:SetLocalVelocity(Vector(math.Rand(-1,1),math.Rand(-1,1),0) * 500)

        self:SetRenderMode( RENDERMODE_TRANSALPHA )
        self:SetColor( Color( 0, 0, 0, 0 ) )

        local phys = self:GetPhysicsObject()

        if phys:IsValid() then
            phys:Wake()
        end


        if self.PoorBastard then
            self:CannonTargetingPerson( self.Target, self.Sky )
        else
            self:CannonTargeting( self.Ground, self.Sky )
        end
    end

    function ENT:CannonTargeting( ground, sky )
        if SERVER then
            local tip = ents.Create( "env_sprite" )
            tip:SetPos( ground )
            tip:SetKeyValue( "model", "light_glow01.vmt" )
            tip:SetKeyValue( "rendercolor", "255 0 0" )
            tip:SetKeyValue( "scale", ".1" )
            tip:SetKeyValue( "rendermode", "9" )
            tip:Spawn()
            tip:Activate()
            tip:Fire( "Kill", "", 1 )
        end

        timer.Simple( 1.5, function() if IsValid( self ) then self:CannonTargeting2( ground, sky ) end end )
    end

    function ENT:CannonTargetingPerson( target, sky )
        if not IsValid( target ) then return end

        if SERVER then
            local tip = ents.Create( "env_sprite" )
            tip:SetPos( target:GetPos() )
            tip:SetKeyValue( "model", "light_glow01.vmt" )
            tip:SetKeyValue( "rendercolor", "255 0 0" )
            tip:SetKeyValue( "scale", ".1" )
            tip:SetKeyValue( "rendermode", "9" )
            tip:Spawn()
            tip:Activate()
            tip:Fire( "Kill", "", 1 )
            tip:SetParent( target )
        end

        timer.Simple( 1.5, function() if IsValid( self ) then self:CannonTargetingPerson2( target, sky ) end end )
    end

    function ENT:CannonTargeting2( ground, sky )
        if SERVER then
            local tip = ents.Create( "env_sprite" )
            tip:SetPos( ground )
            tip:SetKeyValue( "model", "light_glow01.vmt" )
            tip:SetKeyValue( "rendercolor", "255 0 0" )
            tip:SetKeyValue( "scale", ".1" )
            tip:SetKeyValue( "rendermode", "9" )
            tip:Spawn()
            tip:Activate()
            tip:Fire( "Kill", "", 1 )
        end

        timer.Simple( 1.5, function() if IsValid( self ) then self:CannonTargeting3( ground, sky ) end end )
    end

    function ENT:CannonTargetingPerson2( target, sky )
        if not IsValid( target ) then return end
        if SERVER then
            local tip = ents.Create( "env_sprite" )
            tip:SetPos( target:GetPos() )
            tip:SetKeyValue( "model", "light_glow01.vmt" )
            tip:SetKeyValue( "rendercolor", "255 0 0" )
            tip:SetKeyValue( "scale", ".1" )
            tip:SetKeyValue( "rendermode", "9" )
            tip:Spawn()
            tip:Activate()
            tip:Fire( "Kill", "", 1 )
            tip:SetParent( target )
        end

        timer.Simple( 1.5, function() if IsValid( self ) then self:CannonTargetingPerson3( target, sky ) end end )
    end

    function ENT:CannonTargeting3( ground, sky )
        if SERVER then
            targ = ents.Create( "info_target" )
            targ:SetKeyValue( "targetname", tostring( targ ) )
            targ:SetPos( ground )
            targ:Spawn()
            targ:Fire( "Kill", "", 3 )

            laser = ents.Create( "env_laser" )
            laser:SetKeyValue( "texture", "sprites/laserbeam.spr" )
            laser:SetKeyValue( "TextureScroll", "30" )
            laser:SetKeyValue( "noiseamplitude", "0" )
            laser:SetKeyValue( "width", "1" )
            laser:SetKeyValue( "damage", "0" )
            laser:SetKeyValue( "rendercolor", "255 0 0" )
            laser:SetKeyValue( "renderamt", "255" )

            laser:SetKeyValue( "lasertarget", tostring( targ ) )
            laser:SetKeyValue( "parent", tostring( self ) )
            laser:SetPos( self:GetPos() )
            laser:Spawn()
            laser:Fire( "turnon", 0 )
            laser:Fire( "Kill", "", 3 )
            laser:SetParent( self )

            local tip = ents.Create( "env_sprite" )
            tip:SetPos( ground )
            tip:SetKeyValue( "model", "light_glow01.vmt" )
            tip:SetKeyValue( "rendercolor", "255 0 0" )
            tip:SetKeyValue( "scale", ".1" )
            tip:SetKeyValue( "rendermode", "9" )
            tip:Spawn()
            tip:Activate()
            tip:Fire( "Kill", "", 3 )
        end

        timer.Simple( 3, function() if IsValid( self ) then self:GiantLaser( ground, sky ) end end )
    end

    function ENT:CannonTargetingPerson3( target, sky )
        if not IsValid( target ) then return end
        if SERVER then
            targ = ents.Create( "info_target" )
            targ:SetKeyValue( "targetname", tostring( targ ) )
            targ:SetPos( target:GetPos() )
            targ:Spawn()
            targ:Fire( "Kill", "", 3 )
            targ:SetParent( target )

            laser = ents.Create( "env_laser" )
            laser:SetKeyValue( "texture", "sprites/laserbeam.spr" )
            laser:SetKeyValue( "TextureScroll", "30" )
            laser:SetKeyValue( "noiseamplitude", "0" )
            laser:SetKeyValue( "width", "1" )
            laser:SetKeyValue( "damage", "0" )
            laser:SetKeyValue( "rendercolor", "255 0 0" )
            laser:SetKeyValue( "renderamt", "255" )

            laser:SetKeyValue( "lasertarget", tostring( targ ) )
            laser:SetKeyValue( "parent", tostring( self ) )
            laser:SetPos( self:GetPos() )
            laser:Spawn()
            laser:Fire( "turnon", 0 )
            laser:Fire( "Kill", "", 3 )
            laser:SetParent( self )

            local tip = ents.Create( "env_sprite" )
            tip:SetPos( target:GetPos() )
            tip:SetKeyValue( "model", "light_glow01.vmt" )
            tip:SetKeyValue( "rendercolor", "255 0 0" )
            tip:SetKeyValue( "scale", ".1" )
            tip:SetKeyValue( "rendermode", "9" )
            tip:Spawn()
            tip:Activate()
            tip:Fire( "Kill", "", 3 )
            tip:SetParent( target )
        end

        timer.Simple( 3, function() if IsValid( self ) then self:GiantLaserPerson( target, sky ) end end )
    end

    function ENT:GiantLaser( ground, sky )
        pos = self:GetPos()
        lowerleft = Vector( 870, 500, 0 )
        lowerright = Vector( -870, 500, 0 )
        top = Vector( 0, -1000, 0 )

        local targ = ents.Create( "info_target" )
        targ:SetKeyValue( "targetname", tostring( targ ) )
        targ:SetPos( ground )
        targ:Spawn()
        targ:Fire( "Kill", "", 2.25 )

        local glow = ents.Create( "env_lightglow" )
        glow:SetKeyValue( "rendercolor", "255 100 100" )
        glow:SetKeyValue( "VerticalGlowSize", "1800" )
        glow:SetKeyValue( "HorizontalGlowSize", "1000" )
        glow:SetKeyValue( "MaxDist", "1000" )
        glow:SetKeyValue( "MinDist", "4000" )
        glow:SetKeyValue( "OuterMaxDist", "20000" )
        glow:SetPos( ground )
        glow:Spawn()
        glow:Fire( "Kill", "", 2.25 )

        local laser = ents.Create( "env_laser" )
        laser:SetKeyValue( "texture", "sprites/laser.vmt" )
        laser:SetKeyValue( "TextureScroll", "30" )
        laser:SetKeyValue( "noiseamplitude", "0" )
        laser:SetKeyValue( "width", "500" )
        laser:SetKeyValue( "damage", "0" )
        laser:SetKeyValue( "rendercolor", "100 100 255" )
        laser:SetKeyValue( "renderamt", "255" )

        laser:SetKeyValue( "lasertarget", tostring( targ ) )
        laser:SetPos( self:GetPos() + top )
        laser:Spawn()
        laser:Fire( "turnon", 0 )
        laser:Fire( "Kill", "", 2.25 )
        laser:SetParent( self )

        local smokering = EffectData()
        smokering:SetOrigin( ground )
        smokering:SetEntity( self.Owner ) --i dunno, just use it!
        smokering:SetScale( 2 ) --otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
        util.Effect( "m9k_orbital_smokering", smokering )

        timer.Simple( .75, function()
            if IsValid( self ) then
                local laser2 = ents.Create( "env_laser" )
                laser2:SetKeyValue( "texture", "sprites/laser.vmt" )
                laser2:SetKeyValue( "TextureScroll", "30" )
                laser2:SetKeyValue( "noiseamplitude", "0" )
                laser2:SetKeyValue( "width", "500" )
                laser2:SetKeyValue( "damage", "0" )
                laser2:SetKeyValue( "rendercolor", "100 100 255" )
                laser2:SetKeyValue( "renderamt", "255" )
                laser2:SetKeyValue( "lasertarget", tostring( targ ) )
                laser2:SetPos( self:GetPos() + lowerleft )
                laser2:Spawn()
                laser2:Fire( "turnon", 0 )
                laser2:Fire( "Kill", "", 1.5 )
                laser2:SetParent( self )
            end
        end )

        timer.Simple( 1.25, function()
            if IsValid( self ) then
                local laser3 = ents.Create( "env_laser" )
                laser3:SetKeyValue( "texture", "sprites/laser.vmt" )
                laser3:SetKeyValue( "TextureScroll", "30" )
                laser3:SetKeyValue( "noiseamplitude", "0" )
                laser3:SetKeyValue( "width", "500" )
                laser3:SetKeyValue( "damage", "0" )
                laser3:SetKeyValue( "rendercolor", "100 100 255" )
                laser3:SetKeyValue( "renderamt", "255" )
                laser3:SetKeyValue( "lasertarget", tostring( targ ) )
                laser3:SetPos( self:GetPos() + lowerright )
                laser3:Spawn()
                laser3:Fire( "turnon", 0 )
                laser3:Fire( "Kill", "", 1 )
                laser3:SetParent( self )
            end
        end )

        timer.Simple( 1.75, function()
            if IsValid( self ) then
                local laser4 = ents.Create( "env_laser" )
                laser4:SetKeyValue( "texture", "sprites/laser.vmt" )
                laser4:SetKeyValue( "TextureScroll", "30" )
                laser4:SetKeyValue( "noiseamplitude", "0" )
                laser4:SetKeyValue( "width", "500" )
                laser4:SetKeyValue( "damage", "0" )
                laser4:SetKeyValue( "rendercolor", "100 100 255" )
                laser4:SetKeyValue( "renderamt", "255" )
                laser4:SetKeyValue( "lasertarget", tostring( targ ) )
                laser4:SetPos( self:GetPos() )
                laser4:Spawn()
                laser4:Fire( "turnon", 0 )
                laser4:Fire( "Kill", "", .5 )
                laser4:SetParent( self )
            end
        end )
        timer.Simple( 2.25, function() if IsValid( self ) then self:MassiveFuckingExplosion( ground, sky ) end end )
        timer.Simple( 1.5, function()
            for k, v in ipairs( player.GetAll() ) do
                if IsValid( v ) then
                    v:EmitSound( "npc/strider/fire.ogg" )
                    --sound.Play("npc/strider/fire.ogg", v:GetPos(), 100, 100, 1)
                end
            end
        end )
    end

    function ENT:GiantLaserPerson( ground, sky )
        if not IsValid( ground ) then return end

        pos = self:GetPos()
        lowerleft = Vector( 870, 500, 0 )
        lowerright = Vector( -870, 500, 0 )
        top = Vector( 0, -1000, 0 )

        targ = ents.Create( "info_target" )
        targ:SetKeyValue( "targetname", tostring( targ ) )
        targ:SetPos( ground:GetPos() )
        targ:Spawn()
        targ:Fire( "Kill", "", 2.25 )
        targ:SetParent( ground )

        targ2 = ents.Create( "info_target" )
        targ2:SetKeyValue( "targetname", tostring( targ2 ) )
        targ2:SetPos( self:GetPos() )
        targ2:Spawn()
        targ2:Fire( "Kill", "", 2.25 )
        targ2:SetParent( self )

        laser0 = ents.Create( "env_laser" )
        laser0:SetKeyValue( "texture", "sprites/laser.vmt" )
        laser0:SetKeyValue( "TextureScroll", "30" )
        laser0:SetKeyValue( "noiseamplitude", "0" )
        laser0:SetKeyValue( "width", "500" )
        laser0:SetKeyValue( "damage", "0" )
        laser0:SetKeyValue( "rendercolor", "100 100 255" )
        laser0:SetKeyValue( "renderamt", "255" )
        laser0:SetKeyValue( "lasertarget", tostring( targ2 ) )
        laser0:SetPos( ground:GetPos() + Vector( 0, 0, 80 ) )
        laser0:Spawn()
        laser0:Fire( "turnon", 0 )
        laser0:Fire( "Kill", "", 2.25 )
        laser0:SetParent( ground )

        laser = ents.Create( "env_laser" )
        laser:SetKeyValue( "texture", "sprites/laser.vmt" )
        laser:SetKeyValue( "TextureScroll", "30" )
        laser:SetKeyValue( "noiseamplitude", "0" )
        laser:SetKeyValue( "width", "500" )
        laser:SetKeyValue( "damage", "0" )
        laser:SetKeyValue( "rendercolor", "100 100 255" )
        laser:SetKeyValue( "renderamt", "255" )

        laser:SetKeyValue( "lasertarget", tostring( targ ) )
        laser:SetPos( self:GetPos() + top )
        laser:Spawn()
        laser:Fire( "turnon", 0 )
        laser:Fire( "Kill", "", 2.25 )
        laser:SetParent( self )

        local smokering = EffectData()
        smokering:SetOrigin( ground:GetPos() )
        smokering:SetEntity( self.Owner ) --i dunno, just use it!
        smokering:SetScale( 2 ) --otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
        util.Effect( "m9k_orbital_smokering", smokering )

        timer.Simple( .75, function()
            if IsValid( self ) then
                laser2 = ents.Create( "env_laser" )
                laser2:SetKeyValue( "texture", "sprites/laser.vmt" )
                laser2:SetKeyValue( "TextureScroll", "30" )
                laser2:SetKeyValue( "noiseamplitude", "0" )
                laser2:SetKeyValue( "width", "500" )
                laser2:SetKeyValue( "damage", "0" )
                laser2:SetKeyValue( "rendercolor", "100 100 255" )
                laser2:SetKeyValue( "renderamt", "255" )
                laser2:SetKeyValue( "lasertarget", tostring( targ ) )
                laser2:SetPos( self:GetPos() + lowerleft )
                laser2:Spawn()
                laser2:Fire( "turnon", 0 )
                laser2:Fire( "Kill", "", 1.5 )
                laser2:SetParent( self )
            end
        end )

        timer.Simple( 1.25, function()
            if IsValid( self ) then
                laser3 = ents.Create( "env_laser" )
                laser3:SetKeyValue( "texture", "sprites/laser.vmt" )
                laser3:SetKeyValue( "TextureScroll", "30" )
                laser3:SetKeyValue( "noiseamplitude", "0" )
                laser3:SetKeyValue( "width", "500" )
                laser3:SetKeyValue( "damage", "0" )
                laser3:SetKeyValue( "rendercolor", "100 100 255" )
                laser3:SetKeyValue( "renderamt", "255" )
                laser3:SetKeyValue( "lasertarget", tostring( targ ) )
                laser3:SetPos( self:GetPos() + lowerright )
                laser3:Spawn()
                laser3:Fire( "turnon", 0 )
                laser3:Fire( "Kill", "", 1 )
                laser3:SetParent( self )
            end
        end )

        timer.Simple( 1.75, function()
            if IsValid( self ) then
                laser4 = ents.Create( "env_laser" )
                laser4:SetKeyValue( "texture", "sprites/laser.vmt" )
                laser4:SetKeyValue( "TextureScroll", "30" )
                laser4:SetKeyValue( "noiseamplitude", "0" )
                laser4:SetKeyValue( "width", "500" )
                laser4:SetKeyValue( "damage", "0" )
                laser4:SetKeyValue( "rendercolor", "100 100 255" )
                laser4:SetKeyValue( "renderamt", "255" )
                laser4:SetKeyValue( "lasertarget", tostring( targ ) )
                laser4:SetPos( self:GetPos() )
                laser4:Spawn()
                laser4:Fire( "turnon", 0 )
                laser4:Fire( "Kill", "", .5 )
                laser4:SetParent( self )
            end
        end )
        timer.Simple( 2.25, function() if IsValid( self ) then self:MassiveFuckingExplosionPerson( ground, sky ) end end )
        timer.Simple( 1.5, function()
            for k, v in ipairs( player.GetAll() ) do
                sound.Play( "npc/strider/fire.ogg", v:GetPos(), 100, 100 )
            end
        end )
    end

    function ENT:MassiveFuckingExplosion( ground, sky )
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        pos = self:GetPos()
        lowerleft = pos + Vector( 870, 500, 0 )
        lowerright = pos + Vector( -870, 500, 0 )
        top = pos + Vector( 0, -1000, 0 )

        tr1 = {}
        tr1.start = lowerleft
        tr1.endpos = ground
        tr1.filter = self
        tr1 = util.TraceLine( tr1 )

        tr2 = {}
        tr2.start = lowerleft
        tr2.endpos = ground
        tr2.filter = self
        tr2 = util.TraceLine( tr2 )

        tr3 = {}
        tr3.start = lowerright
        tr3.endpos = ground
        tr3.filter = self
        tr3 = util.TraceLine( tr3 )

        tr4 = {}
        tr4.start = lowerright
        tr4.endpos = ground
        tr4.filter = self
        tr4 = util.TraceLine( tr4 )

        if tr2.HitPos ~= ground then
            self:SmallerExplo( tr2.HitPos, tr2.Normal )
        end

        if tr3.HitPos ~= ground then
            self:SmallerExplo( tr3.HitPos, tr3.Normal )
        end

        if tr4.HitPos ~= ground then
            self:SmallerExplo( tr4.HitPos, tr4.Normal )
        end

        local effectdata = EffectData()
        effectdata:SetOrigin( ground )
        effectdata:SetRadius( 5000 )
        effectdata:SetMagnitude( 5000 )
        util.Effect( "HelicopterMegaBomb", effectdata )

        local exploeffect = EffectData()
        exploeffect:SetOrigin( ground )
        exploeffect:SetStart( ground )
        util.Effect( "Explosion", exploeffect, true, true )

        local effectdata = EffectData()
        effectdata:SetOrigin( ground ) -- Where is hits
        effectdata:SetNormal( Vector( 0, 0, 1 ) ) -- Direction of particles
        effectdata:SetEntity( self.Owner ) -- Who done it?
        effectdata:SetScale( 8 ) -- Size of explosion
        effectdata:SetRadius( 67 ) -- What texture it hits
        effectdata:SetMagnitude( 8 ) -- Length of explosion trails
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        --generic default, you are a god among men

        util.BlastDamage( self, (self:OwnerCheck()), ground, 4000, 500 )

        local shake = ents.Create( "env_shake" )
        shake:SetOwner( self.Owner )
        shake:SetPos( ground )
        shake:SetKeyValue( "amplitude", "4000" ) -- Power of the shake
        shake:SetKeyValue( "radius", "5000" ) -- Radius of the shake
        shake:SetKeyValue( "duration", "2.5" ) -- Time of shake
        shake:SetKeyValue( "frequency", "255" ) -- How har should the screenshake be
        shake:SetKeyValue( "spawnflags", "4" ) -- Spawnflags(In Air)
        shake:Spawn()
        shake:Activate()
        shake:Fire( "StartShake", "", 0 )
        shake:Fire( "Kill", "", 3 )

        self:Remove()

        local smokering = EffectData()
        smokering:SetOrigin( ground )
        smokering:SetEntity( self.Owner ) --i dunno, just use it!
        smokering:SetScale( 1 ) --otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
        util.Effect( "m9k_orbital_smokering", smokering )

        for k, v in ipairs( player.GetAll() ) do
            if IsValid( v ) then
                v:EmitSound( "ambient/explosions/explode_6.wav" )
                --sound.Play("ambient/explosions/explode_6.wav", v:GetPos(), 100, 100, 1)
            end
        end
    end

    function ENT:MassiveFuckingExplosionPerson( ground, sky )
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end

        if not IsValid( ground ) then return end
        pos = self:GetPos()
        lowerleft = pos + Vector( 870, 500, 0 )
        lowerright = pos + Vector( -870, 500, 0 )
        top = pos + Vector( 0, -1000, 0 )

        tr1 = {}
        tr1.start = lowerleft
        tr1.endpos = ground:GetPos()
        tr1.filter = self, ground
        tr1 = util.TraceLine( tr1 )

        tr2 = {}
        tr2.start = lowerleft
        tr2.endpos = ground:GetPos()
        tr2.filter = self, ground
        tr2 = util.TraceLine( tr2 )

        tr3 = {}
        tr3.start = lowerright
        tr3.endpos = ground:GetPos()
        tr3.filter = self, ground
        tr3 = util.TraceLine( tr3 )

        tr4 = {}
        tr4.start = lowerright
        tr4.endpos = ground:GetPos()
        tr4.filter = self, ground
        tr4 = util.TraceLine( tr4 )

        if tr2.Entity ~= ground then
            self:SmallerExplo( tr2.HitPos, tr2.Normal )
        end

        if tr3.Entity ~= ground then
            self:SmallerExplo( tr3.HitPos, tr3.Normal )
        end

        if tr4.Entity ~= ground then
            self:SmallerExplo( tr4.HitPos, tr4.Normal )
        end

        local effectdata = EffectData()
        effectdata:SetOrigin( ground:GetPos() )
        effectdata:SetRadius( 5000 )
        effectdata:SetMagnitude( 5000 )
        util.Effect( "HelicopterMegaBomb", effectdata )

        local exploeffect = EffectData()
        exploeffect:SetOrigin( ground:GetPos() )
        exploeffect:SetStart( ground:GetPos() )
        util.Effect( "Explosion", exploeffect, true, true )

        local effectdata = EffectData()
        effectdata:SetOrigin( ground:GetPos() ) -- Where is hits
        effectdata:SetNormal( Vector( 0, 0, 1 ) ) -- Direction of particles
        effectdata:SetEntity( self.Owner ) -- Who done it?
        effectdata:SetScale( 8 ) -- Size of explosion
        effectdata:SetRadius( 67 ) -- What texture it hits
        effectdata:SetMagnitude( 8 ) -- Length of explosion trails
        util.Effect( "m9k_gdcw_cinematicboom", effectdata )
        --generic default, you are a god among men

        util.BlastDamage( self, (self:OwnerCheck()), ground:GetPos(), 4000, 500 )

        local shake = ents.Create( "env_shake" )
        shake:SetOwner( self.Owner )
        shake:SetPos( ground:GetPos() )
        shake:SetKeyValue( "amplitude", "4000" ) -- Power of the shake
        shake:SetKeyValue( "radius", "5000" ) -- Radius of the shake
        shake:SetKeyValue( "duration", "2.5" ) -- Time of shake
        shake:SetKeyValue( "frequency", "255" ) -- How har should the screenshake be
        shake:SetKeyValue( "spawnflags", "4" ) -- Spawnflags(In Air)
        shake:Spawn()
        shake:Activate()
        shake:Fire( "StartShake", "", 0 )
        shake:Fire( "Kill", "", 3 )

        self:Remove()

        local smokering = EffectData()
        smokering:SetOrigin( ground:GetPos() )
        smokering:SetEntity( self.Owner ) --i dunno, just use it!
        smokering:SetScale( 1 ) --otherwise you'll get the pinch thing. just leave it as it is for smoke, i'm trying to save on lua files dammit!
        util.Effect( "m9k_orbital_smokering", smokering )

        for k, v in ipairs( player.GetAll() ) do
            sound.Play( "ambient/explosions/explode_6.wav", v:GetPos(), 100, 100 )
        end
    end

    function ENT:SmallerExplo( targ, norm )
        -- local effectdata = EffectData()
        -- effectdata:SetOrigin(targ)			-- Where is hits
        -- effectdata:SetNormal(norm)		-- Direction of particles
        -- effectdata:SetEntity(self.Owner)		-- Who done it?
        -- effectdata:SetScale(4)			-- Size of explosion
        -- effectdata:SetRadius(67)		-- What texture it hits
        -- effectdata:SetMagnitude(4)			-- Length of explosion trails
        -- util.Effect( "m9k_gdcw_cinematicboom", effectdata )

        util.BlastDamage( self, (self:OwnerCheck()), targ, 1000, 150 )

        local effectdata = EffectData()
        effectdata:SetOrigin( targ )
        effectdata:SetRadius( 100 )
        effectdata:SetMagnitude( 100 )
        util.Effect( "HelicopterMegaBomb", effectdata )

        local exploeffect = EffectData()
        exploeffect:SetOrigin( targ )
        exploeffect:SetStart( targ )
        util.Effect( "Explosion", exploeffect, true, true )
    end

    function ENT:OwnerCheck()
        if IsValid( self.Owner ) then
            return self.Owner
        else
            return self
        end
    end

    --[[---------------------------------------------------------
   Name: ENT:Think()
-----------------------------------------------------------]]
    function ENT:Think()
        if not IsValid( self.Owner ) then
            self:Remove()
            return
        end
    end
end
