-- --Variables that are used on both client and server
SWEP.Category               = ""
SWEP.Gun                    = ""
SWEP.Author                 = "Generic Default, Worshipper, Clavus, and Bob"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.DrawCrosshair          = true -- Hell no, crosshairs r 4 nubz!
SWEP.ViewModelFOV           = 65 -- How big the gun will look
SWEP.ViewModelFlip          = true -- True for CSS models, False for HL2 models

SWEP.Spawnable              = false
SWEP.AdminSpawnable         = false

SWEP.Primary.Sound          = "" -- Sound of the gun
SWEP.Primary.Round          = "" -- What kind of bullet?
SWEP.Primary.Cone           = 0.2 -- Accuracy of NPCs
SWEP.Primary.Recoil         = 10
SWEP.Primary.Damage         = 10
SWEP.Primary.Spread         = .01 --define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.NumShots       = 1
SWEP.Primary.RPM            = 0 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 0 -- Size of a clip
SWEP.Primary.DefaultClip    = 0 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.KickUpMultiplier       = 2

SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum side recoil (koolaid)
SWEP.Primary.Automatic      = true -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "none" -- What kind of ammo

-- SWEP.Secondary.ClipSize                 = 0                                     -- Size of a clip
-- SWEP.Secondary.DefaultClip                      = 0                                     -- Default number of bullets in a clip
-- SWEP.Secondary.Automatic                        = false                                 -- Automatic/Semi Auto
SWEP.Secondary.Ammo         = ""
----HAHA! GOTCHA, YA BASTARD!

-- SWEP.Secondary.IronFOV                  = 0                                     -- How much you 'zoom' in. Less is more!

SWEP.Penetration            = true
SWEP.Ricochet               = true
SWEP.RicochetCoin           = 1
SWEP.BoltAction             = false
SWEP.Scoped                 = false
SWEP.ShellTime              = .35
SWEP.Tracer                 = 0
SWEP.CanBeSilenced          = false
SWEP.Silenced               = false
SWEP.NextSilence            = 0
SWEP.SelectiveFire          = false
SWEP.NextFireSelect         = 0
SWEP.OrigCrossHair          = true

local CLIENT                = CLIENT
local SERVER                = SERVER
local MASK_SHOT             = MASK_SHOT
local IN_USE                = IN_USE

local PainMulti             = 1

if GetConVar( "M9KDamageMultiplier" ) == nil then
    PainMulti = 1
    print( "M9KDamageMultiplier is missing! You may have hit the lua limit! Reverting multiplier to 1." )
else
    PainMulti = GetConVar( "M9KDamageMultiplier" ):GetFloat()
    if PainMulti < 0 then
        PainMulti = PainMulti * -1
        print( "Your damage multiplier was in the negatives. It has been reverted to a positive number. Your damage multiplier is now " .. PainMulti )
    end
end

local function NewM9KDamageMultiplier( cvar, previous, new )
    print( "multiplier has been changed " )
    if GetConVar( "M9KDamageMultiplier" ) == nil then
        PainMulti = 1
        print( "M9KDamageMultiplier is missing! You may have hit the lua limit! Reverting multiplier to 1, you will notice no changes." )
    else
        PainMulti = GetConVar( "M9KDamageMultiplier" ):GetFloat()
        if PainMulti < 0 then
            PainMulti = PainMulti * -1
            print( "Your damage multiplier was in the negatives. It has been reverted to a positive number. Your damage multiplier is now " .. PainMulti )
        end
    end
end
cvars.AddChangeCallback( "M9KDamageMultiplier", NewM9KDamageMultiplier )

local function NewDefClips( cvar, previous, new )
    print( "Default clip multiplier has changed. A server restart will be required for these changes to take effect." )
end
cvars.AddChangeCallback( "M9KDefaultClip", NewDefClips )

if GetConVar( "M9KDefaultClip" ) == nil then
    print( "M9KDefaultClip is missing! You may have hit the lua limit!" )
else
    if GetConVar( "M9KDefaultClip" ):GetInt() >= 0 then
        print( "M9K Weapons will now spawn with " .. GetConVar( "M9KDefaultClip" ):GetFloat() .. " clips." )
    else
        print( "Default clips will be not be modified" )
    end
end

SWEP.IronSightsPos = Vector( 2.4537, 1.0923, 0.2696 )
SWEP.IronSightsAng = Vector( 0.0186, -0.0547, 0 )

SWEP.VElements = {}
SWEP.WElements = {}

function SWEP:Initialize()
    self.Reloadaftershoot = 0 -- Can't reload when firing
    self:SetHoldType( self.HoldType )
    self.OrigCrossHair = self.DrawCrosshair
    if SERVER and self:GetOwner():IsNPC() then
        self:SetNPCMinBurst( 3 )
        self:SetNPCMaxBurst( 10 ) -- None of this really matters but you need it here anyway
        self:SetNPCFireRate( 1 / (self.Primary.RPM / 60) )
        -- --self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
    end

    if CLIENT then
        -- -- Create a new table for every weapon instance
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

        self:CreateModels( self.VElements ) -- create viewmodels
        self:CreateModels( self.WElements ) -- create worldmodels

        -- -- init view model bone build function
        if IsValid( self:GetOwner() ) and self:GetOwner():IsPlayer() then
            if self:GetOwner():Alive() then
                local vm = self:GetOwner():GetViewModel()
                if IsValid( vm ) then
                    self:ResetBonePositions( vm )
                    -- -- Init viewmodel visibility
                    if (self.ShowViewModel == nil or self.ShowViewModel) then
                        vm:SetColor( Color( 255, 255, 255, 255 ) )
                    else
                        -- -- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
                        vm:SetMaterial( "Debug/hsv" )
                    end
                end
            end
        end
    end

    if CLIENT then
        local oldpath = "vgui/hud/name" -- the path goes here
        local newpath = string.gsub( oldpath, "name", self.Gun )
        self.WepSelectIcon = surface.GetTextureID( newpath )
    end
end

function SWEP:Equip()
    self:SetHoldType( self.HoldType )
end

function SWEP:Deploy()
    self:SetIronsights( false, self:GetOwner() ) -- Set the ironsight false
    self:SetHoldType( self.HoldType )

    if self.Silenced then
        self:SendWeaponAnim( ACT_VM_DRAW_SILENCED )
    else
        self:SendWeaponAnim( ACT_VM_DRAW )
    end

    self:SetNWBool( "Reloading", false )

    if ! self:GetOwner():IsNPC() and self:GetOwner() ~= nil then
        if self.ResetSights and self:GetOwner():GetViewModel() ~= nil then
            self.ResetSights = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
        end
    end
    return true
end

function SWEP:Holster()
    if CLIENT and IsValid( self:GetOwner() ) and not self:GetOwner():IsNPC() then
        local vm = self:GetOwner():GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end

    return true
end

function SWEP:OnRemove()
    if CLIENT and IsValid( self:GetOwner() ) and not self:GetOwner():IsNPC() then
        local vm = self:GetOwner():GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
end

function SWEP:GetCapabilities()
    return CAP_WEAPON_RANGE_ATTACK1, CAP_INNATE_RANGE_ATTACK1
end

function SWEP:Precache()
    util.PrecacheModel( self.ViewModel )
    util.PrecacheModel( self.WorldModel )
end

function SWEP:PrimaryAttack()
    if not IsValid( self ) and not IsValid( self:GetOwner() ) then return end

    if self:CanPrimaryAttack() and self:GetOwner():IsPlayer() then
        if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
            self:ShootBulletInformation()
            self:TakePrimaryAmmo( 1 )

            if self.Silenced then
                self:SendWeaponAnim( ACT_VM_PRIMARYATTACK_SILENCED )
                self:EmitSound( self.Primary.SilencedSound )
            else
                self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
                self:EmitSound( self.Primary.Sound )
            end

            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:GetOwner():MuzzleFlash()
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            self:CheckWeaponsAndAmmo()
            self.RicochetCoin = (math.random( 1, 4 ))
            if self.BoltAction then self:BoltBack() end
        end
    elseif self:CanPrimaryAttack() and self:GetOwner():IsNPC() then
        self:ShootBulletInformation()
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self:EmitSound( self.Primary.Sound )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        self:GetOwner():MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        self.RicochetCoin = (math.random( 1, 4 ))
    end
end

local weaponStrip = GetConVar( "M9KWeaponStrip" )
function SWEP:CheckWeaponsAndAmmo()
    if not SERVER then return end
    if not weaponStrip:GetBool() then return end
    if self:Clip1() ~= 0 or self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() ) ~= 0 then return end

    timer.Simple( .1, function()
        if not IsValid( self ) and not IsValid( self:GetOwner() ) then return end
        if self:GetOwner() == nil then return end
        self:GetOwner():StripWeapon( self.Gun )
    end )
end

--[[---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
   Desc: This func add the damage, the recoil, the number of shots and the cone on the bullet.
-------------------------------------------------------]]
function SWEP:ShootBulletInformation()
    local currentCone
    if self:GetIronsights() == true and self:GetOwner():KeyDown( IN_ATTACK2 ) then
        currentCone = self.Primary.IronAccuracy
    else
        currentCone = self.Primary.Spread
    end

    local damagedice = math.Rand( .95, 1.5 )

    local basedamage = PainMulti * self.Primary.Damage
    local currentDamage = basedamage * damagedice
    local currentRecoil = self.Primary.Recoil

    if self:GetIronsights() == true and self:GetOwner():KeyDown( IN_ATTACK2 ) then
        self:ShootBullet( currentDamage, currentRecoil / 6, self.Primary.NumShots, currentCone )
    else
        self:ShootBullet( currentDamage, currentRecoil, self.Primary.NumShots, currentCone )
    end
end

--[[---------------------------------------------------------
   Name: SWEP:BulletCallback()
   Desc: A convenience func to handle bullet callbacks.
-------------------------------------------------------]]
local iterationCount = {
    ["SniperPenetratedRound"] = 10,
    ["pistol"] = 2,
    ["357"] = 5,
    ["smg1"] = 4,
    ["ar2"] = 5,
    ["buckshot"] = 0,
    ["slam"] = 0,
    ["AirboatGun"] = 8
}

local maxPenetrationsTbl = {
    ["SniperPenetratedRound"] = 20,
    ["pistol"] = 9,
    ["357"] = 12,
    ["smg1"] = 14,
    ["ar2"] = 16,
    ["buckshot"] = 5,
    ["slam"] = 5,
    ["AirboatGun"] = 17
}

local penetrationDamageMult = {
    [MAT_CONCRETE] = 0.3,
    [MAT_METAL] = 0.3,
    [MAT_WOOD] = 0.8,
    [MAT_PLASTIC] = 0.8,
    [MAT_GLASS] = 0.8,
    [MAT_FLESH] = 0.9,
    [MAT_ALIENFLESH] = 0.9
}

local easyPenMaterials = {
    [MAT_GLASS] = true,
    [MAT_PLASTIC] = true,
    [MAT_WOOD] = true,
    [MAT_FLESH] = true,
    [MAT_ALIENFLESH] = true
}

local spreadVec = Vector( 0, 0, 0 )

function SWEP:BulletCallback( iteration, attacker, bulletTrace, dmginfo, direction )
    if CLIENT then return { damage = false, effects = false } end
    if bulletTrace.HitSky then return { damage = false, effects = false } end

    iteration = iteration and iteration + 1 or 0
    local maxIterations = iterationCount[self.Primary.Ammo] or 14
    if iteration > maxIterations then return { damage = true, effects = true } end

    direction = direction or bulletTrace.Normal

    local penetrated = self:BulletPenetrate( iteration, attacker, bulletTrace, dmginfo, direction )
    if penetrated then return { damage = true, effects = true } end

    local ricochet = self:BulletRicochet( iteration, attacker, bulletTrace, dmginfo, direction )
    if ricochet then return { damage = true, effects = true } end
end

function SWEP:BulletPenetrate( iteration, attacker, bulletTrace, dmginfo, direction )
    local maxPenetrations = maxPenetrationsTbl[self.Primary.Ammo] or 5
    local penDirection = direction * maxPenetrations
    if easyPenMaterials[bulletTrace.MatType] then
        penDirection = direction * maxPenetrations * 2
    end

    local hitEnt = bulletTrace.Entity
    local penTrace = util.TraceLine( {
        endpos = bulletTrace.HitPos,
        start = bulletTrace.HitPos + penDirection,
        mask = MASK_SHOT,
        filter = function( ent )
            if ent == hitEnt then return true end
            return false
        end
    } )

    debugoverlay.Line( bulletTrace.HitPos + penDirection, penTrace.HitPos, 10, Color( 255, 0, 0 ), true )

    if penTrace.AllSolid and penTrace.HitWorld then return false end
    if not penTrace.Hit then return false end
    if penTrace.Fraction >= 0.99 or penTrace.Fraction <= 0.01 then return false end

    debugoverlay.Text( penTrace.HitPos, "Pen:" .. tostring( iteration ), 10 )

    local damageMult = penetrationDamageMult[penTrace.MatType] or 0.5
    local bullet = {
        Num = 1,
        Src = penTrace.HitPos,
        Dir = direction,
        Spread = spreadVec,
        Tracer = 2,
        TracerName = "m9k_effect_mad_penetration_trace",
        Force = 5,
        Damage = dmginfo:GetDamage() * damageMult,
        Callback = function( a, b, c )
            return self:BulletCallback( iteration, a, b, c, direction )
        end
    }

    timer.Simple( 0, function()
        attacker:FireBullets( bullet )
    end )

    return true
end

local bulletMissSounds = {
    "weapons/fx/nearmiss/bulletLtoR03.wav",
    "weapons/fx/nearmiss/bulletLtoR04.wav",
    "weapons/fx/nearmiss/bulletLtoR06.wav",
    "weapons/fx/nearmiss/bulletLtoR07.wav",
    "weapons/fx/nearmiss/bulletLtoR09.wav",
    "weapons/fx/nearmiss/bulletLtoR10.wav",
    "weapons/fx/nearmiss/bulletLtoR13.wav",
    "weapons/fx/nearmiss/bulletLtoR14.wav"
}

local ricochetAmmoTable = {
    ["pistol"] = true,
    ["buckshot"] = true,
    ["slam"] = true,
    ["SniperPenetratedRound"] = true
}

function SWEP:BulletRicochet( iteration, attacker, bulletTrace, dmginfo, direction )
    local shouldRicochet = ricochetAmmoTable[self.Primary.Ammo] or false
    if not shouldRicochet and self.RicochetCoin ~= 1 then return false end

    if bulletTrace.MatType ~= MAT_METAL then
        util.ScreenShake( bulletTrace.HitPos, 5, 0.1, 0.5, 64 )
        local missSound = bulletMissSounds[math.random( #bulletMissSounds )]
        sound.Play( missSound, bulletTrace.HitPos, 75, math.random( 75, 150 ), 1 )

        if self.Tracer == 0 or self.Tracer == 1 or self.Tracer == 2 then
            local effectdata = EffectData()
            effectdata:SetOrigin( bulletTrace.HitPos )
            effectdata:SetNormal( bulletTrace.HitNormal )
            effectdata:SetScale( 20 )
            util.Effect( "AR2Impact", effectdata )
        elseif self.Tracer == 3 then
            local effectdata = EffectData()
            effectdata:SetOrigin( bulletTrace.HitPos )
            effectdata:SetNormal( bulletTrace.HitNormal )
            effectdata:SetScale( 20 )
            util.Effect( "StunstickImpact", effectdata )
        end

        return false
    end

    local dotProduct = bulletTrace.HitNormal:Dot( direction * -1 )
    local bullet = {
        Num = 1,
        Src = bulletTrace.HitPos + bulletTrace.HitNormal,
        Dir = ( ( 2 * bulletTrace.HitNormal * dotProduct ) + direction ) + ( VectorRand() * 0.05 ),
        Spread = spreadVec,
        Tracer = 1,
        TracerName = "m9k_effect_mad_ricochet_trace",
        Force = dmginfo:GetDamage() * 0.15,
        Damage = dmginfo:GetDamage() * 0.5,
        Callback = function( a, b, c )
            return self:BulletCallback( iteration, a, b, c )
        end
    }

    timer.Simple( 0, function()
        attacker:FireBullets( bullet )
    end )

    return true
end

--[[---------------------------------------------------------
   Name: SWEP:ShootBullet()
   Desc: A convenience func to shoot bullets.
-------------------------------------------------------]]
local TracerName = "Tracer"

function SWEP:ShootBullet( damage, recoil, num_bullets, aimcone )
    num_bullets = num_bullets or 1
    aimcone = aimcone or 0

    self:ShootEffects()

    if self.Tracer == 1 then
        TracerName = "Ar2Tracer"
    elseif self.Tracer == 2 then
        TracerName = "AirboatGunHeavyTracer"
    else
        TracerName = "Tracer"
    end

    local bullet = {
        Num = num_bullets,
        Src = self:GetOwner():GetShootPos(),
        Dir = ( self:GetOwner():GetAimVector():Angle() + self:GetOwner():GetViewPunchAngles() ):Forward(),
        Spread = Vector( aimcone, aimcone, 0 ),
        Tracer = 3,
        TracerName = TracerName,
        Force = damage * 0.25,
        Damage = damage,
        Callback = function( attacker, tracedata, dmginfo )
            return self:BulletCallback( 0, attacker, tracedata, dmginfo )
        end
    }
    if IsValid( self:GetOwner() ) then
        self:GetOwner():FireBullets( bullet )
    end
    -- --if SERVER and !self:GetOwner():IsNPC() then
    -- --        local anglo = Angle(math.Rand(-self.Primary.KickDown,-self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
    -- --        self:GetOwner():ViewPunch(anglo)

    -- --        local eyes = self:GetOwner():EyeAngles()
    -- --        eyes.pitch = eyes.pitch + anglo.pitch
    -- --        eyes.yaw = eyes.yaw + anglo.yaw
    -- --        if game.SinglePlayer() then self:GetOwner():SetEyeAngles(eyes) end
    -- --end

    local x = util.SharedRandom( "m9k_recoil", -self.Primary.KickDown, -self.Primary.KickUp * self.KickUpMultiplier, 100 )
    local y = util.SharedRandom( "m9k_recoil", -self.Primary.KickHorizontal, self.Primary.KickHorizontal, 200 )
    local anglo1 = Angle( x, y, 0 )
    self:GetOwner():ViewPunch( anglo1 )

    if SERVER and game.SinglePlayer() and ! self:GetOwner():IsNPC() then
        local offlineeyes = self:GetOwner():EyeAngles()
        offlineeyes.pitch = offlineeyes.pitch + anglo1.pitch
        offlineeyes.yaw = offlineeyes.yaw + anglo1.yaw
        if GetConVar( "M9KDynamicRecoil" ):GetBool() then
            self:GetOwner():SetEyeAngles( offlineeyes )
        end
    end

    if CLIENT and ! game.SinglePlayer() and ! self:GetOwner():IsNPC() then
        -- case 1 old random
        local eyes = self:GetOwner():EyeAngles()
        eyes.pitch = eyes.pitch + ( anglo1.pitch / 3 )
        eyes.yaw = eyes.yaw + ( anglo1.yaw / 3 )
        if IsFirstTimePredicted() and GetConVar( "M9KDynamicRecoil" ):GetBool() then
            self:GetOwner():SetEyeAngles( eyes )
        end
    end
end

function SWEP:SecondaryAttack()
    return false
end

function SWEP:Reload()
    if not IsValid( self ) then return end
    if not IsValid( self:GetOwner() ) then return end

    if self:GetOwner():IsNPC() then
        self:DefaultReload( ACT_VM_RELOAD )
        return
    end

    if self:GetOwner():KeyDown( IN_USE ) then return end

    if self.Silenced then
        self:DefaultReload( ACT_VM_RELOAD_SILENCED )
    else
        self:DefaultReload( ACT_VM_RELOAD )
    end

    if ! self:GetOwner():IsNPC() then
        if self:GetOwner():GetViewModel() == nil then
            self.ResetSights = CurTime() + 3
        else
            self.ResetSights = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
        end
    end

    if SERVER and (self:Clip1() < self.Primary.ClipSize) and ! self:GetOwner():IsNPC() then
        -- When the current clip < full clip and the rest of your ammo > 0, then
        self:GetOwner():SetFOV( 0, 0.3 )
        -- Zoom = 0
        self:SetIronsights( false )
        -- Set the ironsight to false
        self:SetNWBool( "Reloading", true )
    end

    local waitdammit = (self:GetOwner():GetViewModel():SequenceDuration())
    timer.Simple( waitdammit + .1, function()
        if not IsValid( self ) then return end
        if not IsValid( self:GetOwner() ) then return end

        if CLIENT and not self:GetOwner():KeyDown( IN_ATTACK2 ) then
            self.DrawCrosshair = true
        end

        self:SetNWBool( "Reloading", false )
        if self:GetOwner():KeyDown( IN_ATTACK2 ) and self:GetClass() == self.Gun then
            if CLIENT then return end
            if self.Scoped == false then
                self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
                self.IronSightsPos = self.SightsPos -- Bring it up
                self.IronSightsAng = self.SightsAng -- Bring it up
                self:SetIronsights( true, self:GetOwner() )
                self.DrawCrosshair = false
            else
                return
            end
        elseif self:GetOwner():KeyDown( IN_SPEED ) and self:GetClass() == self.Gun then
            if self:GetNextPrimaryFire() <= (CurTime() + .03) then
                self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
            end
            self.IronSightsPos = self.RunSightsPos -- Hold it down
            self.IronSightsAng = self.RunSightsAng -- Hold it down
            self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
            self:GetOwner():SetFOV( 0, 0.3 )
        else
            self.DrawCrosshair = true
        end
    end )
end

function SWEP:PostReloadScopeCheck()
    if self == nil then return end
    self:SetNWBool( "Reloading", false )
    if self:GetOwner():KeyDown( IN_ATTACK2 ) and self:GetClass() == self.Gun then
        if CLIENT then return end
        if self.Scoped == false then
            self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true, self:GetOwner() )
            self.DrawCrosshair = false
        else
            return
        end
    elseif self:GetOwner():KeyDown( IN_SPEED ) and self:GetClass() == self.Gun then
        if self:GetNextPrimaryFire() <= (CurTime() + .03) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.3 )
    else
        return
    end
end

function SWEP:Silencer()
    if self.NextSilence > CurTime() then return end

    if self ~= nil then
        self:GetOwner():SetFOV( 0, 0.3 )
        self:SetIronsights( false )
        self:SetNWBool( "Reloading", true ) -- i know we're not reloading but it works
    end

    if self.Silenced then
        self:SendWeaponAnim( ACT_VM_DETACH_SILENCER )
        self.Silenced = false
    elseif not self.Silenced then
        self:SendWeaponAnim( ACT_VM_ATTACH_SILENCER )
        self.Silenced = true
    end

    local siltimer = CurTime() + (self:GetOwner():GetViewModel():SequenceDuration()) + 0.1
    if self:GetNextPrimaryFire() <= siltimer then
        self:SetNextPrimaryFire( siltimer )
    end
    self.NextSilence = siltimer

    timer.Simple( self:GetOwner():GetViewModel():SequenceDuration() + 0.1, function()
        if not IsValid( self ) then return end
        self:SetNWBool( "Reloading", false )
        if self:GetOwner():KeyDown( IN_ATTACK2 ) and self:GetClass() == self.Gun then
            if CLIENT then return end
            if self.Scoped == false then
                self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
                self.IronSightsPos = self.SightsPos -- Bring it up
                self.IronSightsAng = self.SightsAng -- Bring it up
                self:SetIronsights( true, self:GetOwner() )
                self.DrawCrosshair = false
            else
                return
            end
        elseif self:GetOwner():KeyDown( IN_SPEED ) and self:GetClass() == self.Gun then
            if self:GetNextPrimaryFire() <= CurTime() + 0.3 then
                self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
            end

            self.IronSightsPos = self.RunSightsPos -- Hold it down
            self.IronSightsAng = self.RunSightsAng -- Hold it down
            self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
            self:GetOwner():SetFOV( 0, 0.3 )
        else
            return
        end
    end )
end

function SWEP:SelectFireMode()
    if self.Primary.Automatic then
        self.Primary.Automatic = false
        self.NextFireSelect = CurTime() + .5
        if CLIENT then
            self:GetOwner():PrintMessage( HUD_PRINTTALK, "Semi-automatic selected." )
        end
        self:EmitSound( "Weapon_AR2.Empty" )
    else
        self.Primary.Automatic = true
        self.NextFireSelect = CurTime() + .5
        if CLIENT then
            self:GetOwner():PrintMessage( HUD_PRINTTALK, "Automatic selected." )
        end
        self:EmitSound( "Weapon_AR2.Empty" )
    end
end

--[[---------------------------------------------------------
IronSight
-------------------------------------------------------]]
function SWEP:IronSight()
    if not IsValid( self ) then return end
    if not IsValid( self:GetOwner() ) then return end

    if ! self:GetOwner():IsNPC() then
        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil

            if self.Silenced then
                self:SendWeaponAnim( ACT_VM_IDLE_SILENCED )
            else
                self:SendWeaponAnim( ACT_VM_IDLE )
            end
        end
    end

    if self.CanBeSilenced and self.NextSilence < CurTime() then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_ATTACK2 ) then
            self:Silencer()
        end
    end

    if self.SelectiveFire and self.NextFireSelect < CurTime() and not (self:GetNWBool( "Reloading" )) then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_RELOAD ) then
            self:SelectFireMode()
        end
    end

    -- --copy this...
    if self:GetOwner():KeyPressed( IN_SPEED ) and not (self:GetNWBool( "Reloading" )) then -- If you are running
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = false
    end

    if self:GetOwner():KeyReleased( IN_SPEED ) then -- If you release run then
        self:SetIronsights( false, self:GetOwner() ) -- Set the ironsight true
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = self.OrigCrossHair
    end -- Shoulder the gun

    -- --down to this
    if ! self:GetOwner():KeyDown( IN_USE ) and ! self:GetOwner():KeyDown( IN_SPEED ) then
        -- --If the key E (Use Key) is not pressed, then

        if self:GetOwner():KeyPressed( IN_ATTACK2 ) and not (self:GetNWBool( "Reloading" )) then
            self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true, self:GetOwner() )
            self.DrawCrosshair = false
            -- --Set the ironsight true

            if CLIENT then return end
        end
    end

    if self:GetOwner():KeyReleased( IN_ATTACK2 ) and ! self:GetOwner():KeyDown( IN_USE ) and ! self:GetOwner():KeyDown( IN_SPEED ) then
        -- --If the right click is released, then
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = self.OrigCrossHair
        self:SetIronsights( false, self:GetOwner() )
        -- --Set the ironsight false

        if CLIENT then return end
    end

    if self:GetOwner():KeyDown( IN_ATTACK2 ) and ! self:GetOwner():KeyDown( IN_USE ) and ! self:GetOwner():KeyDown( IN_SPEED ) then
        self.SwayScale = 0.05
        self.BobScale  = 0.05
    else
        self.SwayScale = 1.0
        self.BobScale  = 1.0
    end
end

--[[---------------------------------------------------------
Think
-------------------------------------------------------]]
function SWEP:Think()
    self:IronSight()
end

--[[---------------------------------------------------------
GetViewModelPosition
-------------------------------------------------------]]
local IRONSIGHT_TIME = 0.3
-- --Time to enter in the ironsight mod

function SWEP:GetViewModelPosition( pos, ang )
    if (not self.IronSightsPos) then return pos, ang end

    local bIron = self:GetIronsights()

    if (bIron ~= self.bLastIron) then
        self.bLastIron = bIron
        self.fIronTime = CurTime()
    end

    local fIronTime = self.fIronTime or 0

    if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
        return pos, ang
    end

    local Mul = 1.0
    if (fIronTime > CurTime() - IRONSIGHT_TIME) then
        Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )

        if not bIron then Mul = 1 - Mul end
    end

    local Offset = self.IronSightsPos

    if (self.IronSightsAng) then
        ang = ang * 1
        ang:RotateAroundAxis( ang:Right(), self.IronSightsAng.x * Mul )
        ang:RotateAroundAxis( ang:Up(), self.IronSightsAng.y * Mul )
        ang:RotateAroundAxis( ang:Forward(), self.IronSightsAng.z * Mul )
    end

    local Right   = ang:Right()
    local Up      = ang:Up()
    local Forward = ang:Forward()

    pos           = pos + Offset.x * Right * Mul
    pos           = pos + Offset.y * Forward * Mul
    pos           = pos + Offset.z * Up * Mul

    return pos, ang
end

--[[---------------------------------------------------------
SetIronsights
-------------------------------------------------------]]
function SWEP:SetIronsights( b )
    self:SetNW2Bool( "M9K_Ironsights", b )
end

function SWEP:GetIronsights()
    return self:GetNW2Bool( "M9K_Ironsights" )
end

if CLIENT then
    SWEP.vRenderOrder = nil
    function SWEP:ViewModelDrawn()
        if not IsValid( self ) then return end
        if not IsValid( self:GetOwner() ) then return end
        local vm = self:GetOwner():GetViewModel()
        if ! IsValid( vm ) then return end

        if (! self.VElements) then return end

        self:UpdateBonePositions( vm )

        if (! self.vRenderOrder) then
            -- -- we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}

            for k, v in pairs( self.VElements ) do
                if (v.type == "Model") then
                    table.insert( self.vRenderOrder, 1, k )
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert( self.vRenderOrder, k )
                end
            end
        end

        for k, name in ipairs( self.vRenderOrder ) do
            local v = self.VElements[name]
            if (! v) then
                self.vRenderOrder = nil
                break
            end
            if (v.hide) then continue end

            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if (! v.bone) then continue end

            local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )

            if (! pos) then continue end

            if (v.type == "Model" and IsValid( model )) then
                model:SetPos( pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis( ang:Up(), v.angle.y )
                ang:RotateAroundAxis( ang:Right(), v.angle.p )
                ang:RotateAroundAxis( ang:Forward(), v.angle.r )

                model:SetAngles( ang )
                -- --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale( v.size )
                model:EnableMatrix( "RenderMultiply", matrix )

                if (v.material == "") then
                    model:SetMaterial( "" )
                elseif (model:GetMaterial() ~= v.material) then
                    model:SetMaterial( v.material )
                end

                if (v.skin and v.skin ~= model:GetSkin()) then
                    model:SetSkin( v.skin )
                end

                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup( k ) ~= v) then
                            model:SetBodygroup( k, v )
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting( true )
                end

                render.SetColorModulation( v.color.r / 255, v.color.g / 255, v.color.b / 255 )
                render.SetBlend( v.color.a / 255 )
                model:DrawModel()
                render.SetBlend( 1 )
                render.SetColorModulation( 1, 1, 1 )

                if (v.surpresslightning) then
                    render.SuppressEngineLighting( false )
                end
            elseif (v.type == "Sprite" and sprite) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial( sprite )
                render.DrawSprite( drawpos, v.size.x, v.size.y, v.color )
            elseif (v.type == "Quad" and v.draw_func) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis( ang:Up(), v.angle.y )
                ang:RotateAroundAxis( ang:Right(), v.angle.p )
                ang:RotateAroundAxis( ang:Forward(), v.angle.r )

                cam.Start3D2D( drawpos, ang, v.size )
                v.draw_func( self )
                cam.End3D2D()
            end
        end
    end

    SWEP.wRenderOrder = nil
    function SWEP:DrawWorldModel()
        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
        end

        if (! self.WElements) then return end

        if (! self.wRenderOrder) then
            self.wRenderOrder = {}

            for k, v in pairs( self.WElements ) do
                if (v.type == "Model") then
                    table.insert( self.wRenderOrder, 1, k )
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert( self.wRenderOrder, k )
                end
            end
        end

        if (IsValid( self:GetOwner() )) then
            bone_ent = self:GetOwner()
        else
            -- -- when the weapon is dropped
            bone_ent = self
        end

        for k, name in pairs( self.wRenderOrder ) do
            local v = self.WElements[name]
            if (! v) then
                self.wRenderOrder = nil
                break
            end
            if (v.hide) then continue end

            local pos, ang

            if (v.bone) then
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
            else
                pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
            end

            if (! pos) then continue end

            local model = v.modelEnt
            local sprite = v.spriteMaterial

            if (v.type == "Model" and IsValid( model )) then
                model:SetPos( pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
                ang:RotateAroundAxis( ang:Up(), v.angle.y )
                ang:RotateAroundAxis( ang:Right(), v.angle.p )
                ang:RotateAroundAxis( ang:Forward(), v.angle.r )

                model:SetAngles( ang )
                -- --model:SetModelScale(v.size)
                local matrix = Matrix()
                matrix:Scale( v.size )
                model:EnableMatrix( "RenderMultiply", matrix )

                if (v.material == "") then
                    model:SetMaterial( "" )
                elseif (model:GetMaterial() ~= v.material) then
                    model:SetMaterial( v.material )
                end

                if (v.skin and v.skin ~= model:GetSkin()) then
                    model:SetSkin( v.skin )
                end

                if (v.bodygroup) then
                    for k, v in pairs( v.bodygroup ) do
                        if (model:GetBodygroup( k ) ~= v) then
                            model:SetBodygroup( k, v )
                        end
                    end
                end

                if (v.surpresslightning) then
                    render.SuppressEngineLighting( true )
                end

                render.SetColorModulation( v.color.r / 255, v.color.g / 255, v.color.b / 255 )
                render.SetBlend( v.color.a / 255 )
                model:DrawModel()
                render.SetBlend( 1 )
                render.SetColorModulation( 1, 1, 1 )

                if (v.surpresslightning) then
                    render.SuppressEngineLighting( false )
                end
            elseif (v.type == "Sprite" and sprite) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                render.SetMaterial( sprite )
                render.DrawSprite( drawpos, v.size.x, v.size.y, v.color )
            elseif (v.type == "Quad" and v.draw_func) then
                local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
                ang:RotateAroundAxis( ang:Up(), v.angle.y )
                ang:RotateAroundAxis( ang:Right(), v.angle.p )
                ang:RotateAroundAxis( ang:Forward(), v.angle.r )

                cam.Start3D2D( drawpos, ang, v.size )
                v.draw_func( self )
                cam.End3D2D()
            end
        end
    end

    function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
        local bone, pos, ang
        if (tab.rel and tab.rel ~= "") then
            local v = basetab[tab.rel]

            if (! v) then return end

            -- -- Technically, if there exists an element with the same name as a bone
            -- -- you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation( basetab, v, ent )

            if (! pos) then return end

            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis( ang:Up(), v.angle.y )
            ang:RotateAroundAxis( ang:Right(), v.angle.p )
            ang:RotateAroundAxis( ang:Forward(), v.angle.r )
        else
            bone = ent:LookupBone( bone_override or tab.bone )

            if (! bone) then return end

            pos, ang = Vector( 0, 0, 0 ), Angle( 0, 0, 0 )
            local m = ent:GetBoneMatrix( bone )
            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end

            if (IsValid( self:GetOwner() ) and self:GetOwner():IsPlayer() and
                    ent == self:GetOwner():GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r ---- Fixes mirrored models
            end
        end

        return pos, ang
    end

    function SWEP:CreateModels( tab )
        if (! tab) then return end

        -- -- Create the clientside models here because Garry says we can't do it in the render hook
        for k, v in pairs( tab ) do
            if (v.type == "Model" and v.model and v.model ~= "" and (! IsValid( v.modelEnt ) or v.createdModel ~= v.model) and
                    string.find( v.model, ".mdl" ) and file.Exists( v.model, "GAME" )) then
                v.modelEnt = ClientsideModel( v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE )
                if (IsValid( v.modelEnt )) then
                    v.modelEnt:SetPos( self:GetPos() )
                    v.modelEnt:SetAngles( self:GetAngles() )
                    v.modelEnt:SetParent( self )
                    v.modelEnt:SetNoDraw( true )
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end
            elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (! v.spriteMaterial or v.createdSprite ~= v.sprite)
                    and file.Exists( "materials/" .. v.sprite .. ".vmt", "GAME" )) then
                local name = v.sprite .. "-"
                local params = { ["$basetexture"] = v.sprite }
                -- -- make sure we create a unique name based on the selected options
                local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
                for i, j in pairs( tocheck ) do
                    if (v[j]) then
                        params["$" .. j] = 1
                        name = name .. "1"
                    else
                        name = name .. "0"
                    end
                end
                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial( name, "UnlitGeneric", params )
            end
        end
    end

    local allbones
    local hasGarryFixedBoneScalingYet = false

    function SWEP:UpdateBonePositions( vm )
        if self.ViewModelBoneMods then
            if (! vm:GetBoneCount()) then return end

            -- -- !! WORKAROUND !! ----
            -- -- We need to check all model names :/
            local loopthrough = self.ViewModelBoneMods
            if (! hasGarryFixedBoneScalingYet) then
                allbones = {}
                for i = 0, vm:GetBoneCount() do
                    local bonename = vm:GetBoneName( i )
                    if (self.ViewModelBoneMods[bonename]) then
                        allbones[bonename] = self.ViewModelBoneMods[bonename]
                    else
                        allbones[bonename] = {
                            scale = Vector( 1, 1, 1 ),
                            pos = Vector( 0, 0, 0 ),
                            angle = Angle( 0, 0, 0 )
                        }
                    end
                end

                loopthrough = allbones
            end
            --!! ----------- !! --

            for k, v in pairs( loopthrough ) do
                local bone = vm:LookupBone( k )
                if (! bone) then continue end

                -- -- !! WORKAROUND !! ----
                local s = Vector( v.scale.x, v.scale.y, v.scale.z )
                local p = Vector( v.pos.x, v.pos.y, v.pos.z )
                local ms = Vector( 1, 1, 1 )
                if (! hasGarryFixedBoneScalingYet) then
                    local cur = vm:GetBoneParent( bone )
                    while (cur >= 0) do
                        local pscale = loopthrough[vm:GetBoneName( cur )].scale
                        ms = ms * pscale
                        cur = vm:GetBoneParent( cur )
                    end
                end

                s = s * ms
                --!! ----------- !! --

                if vm:GetManipulateBoneScale( bone ) ~= s then
                    vm:ManipulateBoneScale( bone, s )
                end
                if vm:GetManipulateBoneAngles( bone ) ~= v.angle then
                    vm:ManipulateBoneAngles( bone, v.angle )
                end
                if vm:GetManipulateBonePosition( bone ) ~= p then
                    vm:ManipulateBonePosition( bone, p )
                end
            end
        else
            self:ResetBonePositions( vm )
        end
    end

    function SWEP:ResetBonePositions( vm )
        if (! vm:GetBoneCount()) then return end
        for i = 0, vm:GetBoneCount() do
            vm:ManipulateBoneScale( i, Vector( 1, 1, 1 ) )
            vm:ManipulateBoneAngles( i, Angle( 0, 0, 0 ) )
            vm:ManipulateBonePosition( i, Vector( 0, 0, 0 ) )
        end
    end

    --[[*************************
            Global utility code
    *************************--]]

    -- -- Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
    -- -- Does not copy entities of course, only copies their reference.
    -- -- WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
    function table.FullCopy( tab )
        if (! tab) then return nil end

        local res = {}
        for k, v in pairs( tab ) do
            if (type( v ) == "table") then
                res[k] = table.FullCopy( v ) ---- recursion ho!
            elseif (type( v ) == "Vector") then
                res[k] = Vector( v.x, v.y, v.z )
            elseif (type( v ) == "Angle") then
                res[k] = Angle( v.p, v.y, v.r )
            else
                res[k] = v
            end
        end

        return res
    end
end
