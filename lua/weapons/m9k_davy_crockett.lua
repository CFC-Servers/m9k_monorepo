-- Variables that are used on both client and server
SWEP.Gun = "m9k_davy_crockett" -- must be the name of your swep but NO CAPITALS!
SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Davy Crockett" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4 -- Slot in the weapon selection menu
SWEP.SlotPos                = 31 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "rpg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_RL7.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_RL7.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = "" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 20 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1 -- Size of a clip
SWEP.Primary.DefaultClip    = 1 -- Bullets you start with
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Nuclear_Warhead"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_launched_davycrockett" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 40 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos              = Vector( -3.7384, -5.7481, -0.2713 )
SWEP.SightsAng              = Vector( 1.1426, 0.0675, 0 )
SWEP.RunSightsPos           = Vector( 2.4946, -1.5644, 1.699 )
SWEP.RunSightsAng           = Vector( -20.1104, 35.1164, -12.959 )


if GetConVar( "M9K_Davy_Crockett_Timer" ) == nil then
    SWEP.NextFireTime = 3
    SWEP.Countdown = 3
    print( "M9K_Davy_Crockett_Timer con var is missing! You may have a corrupt addon, or hit the lua limit." )
else
    SWEP.NextFireTime = GetConVarNumber( "M9K_Davy_Crockett_Timer" )
    SWEP.Countdown = GetConVarNumber( "M9K_Davy_Crockett_Timer" )
end

SWEP.FireDelay = SWEP.NextFireTime

--and now to the nasty parts of this swep...
function SWEP:Deploy()
    if timer.Exists( "davy_crocket_" .. self:GetOwner():UniqueID() ) then
        timer.Remove( "davy_crocket_" .. self:GetOwner():UniqueID() )
    end
    self:SetIronsights( false )
    self:SendWeaponAnim( ACT_VM_DRAW )

    if GetConVar( "DavyCrockettAllowed" ):GetBool() then
        self.FireDelay = CurTime() + self.NextFireTime
        self:SetNextPrimaryFire( self.FireDelay )
        self:GetOwner():PrintMessage( HUD_PRINTCENTER, "Warhead will be armed in " .. self.Countdown .. " seconds." )
        self:GetOwner().DCCount = self.Countdown - 1
        timer.Create( "davy_crocket_" .. self:GetOwner():UniqueID(), 1, self.Countdown, function()
            if not IsValid( self ) then return end
            if not IsValid( self:GetOwner() ) then return end
            if not IsValid( self:GetOwner():GetActiveWeapon() ) then return end
            if self:GetOwner():GetActiveWeapon():GetClass() ~= self.Gun then
                timer.Remove( "davy_crocket_" .. self:GetOwner():UniqueID() )
                return
            end

            self:DeployCountDownFunc( self:GetOwner().DCCount )
            self:GetOwner().DCCount = self:GetOwner().DCCount - 1
        end )
    else
        self:GetOwner():PrintMessage( HUD_PRINTCENTER, "Nukes are not allowed on this server." )
    end

    if not self:GetOwner():IsNPC() then
        self.ResetSights = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
    end

    self:SetHoldType( self.HoldType )
    self:SetReloading( false )
    return true
end

function SWEP:DeployCountDownFunc( count )
    if not IsValid( self:GetOwner() ) then return end
    if self:GetOwner():GetActiveWeapon():GetClass() ~= self.Gun then
        timer.Remove( "davy_crocket_" .. self:GetOwner():UniqueID() )
        return
    end
    if count == 0 then
        self:GetOwner():PrintMessage( HUD_PRINTTALK, "WARHEAD IS ARMED AND READY TO FIRE" )
    elseif count == 1 then
        self:GetOwner():PrintMessage( HUD_PRINTTALK, count .. " second remaining!" )
    else
        self:GetOwner():PrintMessage( HUD_PRINTTALK, count .. " seconds remaining" )
    end
    if count <= 5 then
        self:EmitSound( "C4.PlantSound" )
    end
end

function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() and self.FireDelay <= CurTime() and not self:GetOwner():KeyDown( IN_SPEED ) then
        if self:GetOwner():IsPlayer() then
            if GetConVar( "DavyCrockettAllowed" ) == nil or (GetConVar( "DavyCrockettAllowed" ):GetBool()) then
                self:FireRocket()
                self:EmitSound( "RPGF.single" )
                self:TakePrimaryAmmo( 1 )
                self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
                self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
                self:GetOwner():MuzzleFlash()
                self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            else
                self:GetOwner():PrintMessage( HUD_PRINTCENTER, "Nukes are not allowed on this server." )
            end
        end
        self:CheckWeaponsAndAmmo()
    end
end

function SWEP:FireRocket()
    local aim = self:GetOwner():GetAimVector()
    local pos = self:GetOwner():M9K_GetShootPos()

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( self:GetOwner() )
        rocket.Owner = self:GetOwner()
        rocket:Spawn()
        rocket:Activate()
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
    if CLIENT and IsValid( self:GetOwner() ) and not self:GetOwner():IsNPC() then
        local vm = self:GetOwner():GetViewModel()
        if IsValid( vm ) then
            self:ResetBonePositions( vm )
        end
    end
    if timer.Exists( "davy_crocket_" .. self:GetOwner():UniqueID() ) then timer.Remove( "davy_crocket_" .. self:GetOwner():UniqueID() ) end
    return true
end

SWEP.VElements = {
    ["bomb"] = { type = "Model", model = "models/Failure/MK6/m62.mdl", bone = "Rocket", rel = "", pos = Vector( -0.093, 7.412, -0.005 ), angle = Angle( -45, 0, 90 ), size = Vector( 0.449, 0.449, 0.449 ), color =
        Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
    ["nuke"] = { type = "Model", model = "models/failure/mk6/m62.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector( 28.054, 0.268, -5.1 ), angle = Angle( -90, 0, 0 ), size = Vector( 0.504,
        0.504, 0.504 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

if GetConVar( "DavyCrocketAdminOnly" ) == nil then
    print( "DavyCrocketAdminOnly is missing! You may have hit the lua limit!" )
else
    if GetConVar( "DavyCrocketAdminOnly" ):GetInt() == 1 then
        SWEP.Spawnable = false
    end
end

--[[---------------------------------------------------------
IronSight
-------------------------------------------------------]]
function SWEP:IronSight()
    if not IsValid( self:GetOwner() ) then return end

    if not self:GetOwner():IsNPC() then
        if self.ResetSights and CurTime() >= self.ResetSights then
            self.ResetSights = nil
        end
    end

    if self.CanBeSilenced and self.NextSilence < CurTime() then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_ATTACK2 ) then
            self:Silencer()
        end
    end

    if self.SelectiveFire and self.NextFireSelect < CurTime() and not (self:GetReloading()) then
        if self:GetOwner():KeyDown( IN_USE ) and self:GetOwner():KeyPressed( IN_RELOAD ) then
            self:SelectFireMode()
        end
    end

    -- --copy this...
    if self:GetOwner():KeyPressed( IN_SPEED ) and not (self:GetReloading()) then -- If you are running
        if self:GetNextPrimaryFire() <= (CurTime() + 0.3) then
            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
        end
        self.IronSightsPos = self.RunSightsPos -- Hold it down
        self.IronSightsAng = self.RunSightsAng -- Hold it down
        self:SetIronsights( true )
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = false
    end

    if self:GetOwner():KeyReleased( IN_SPEED ) then -- If you release run then
        self:SetIronsights( false )
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = self.OrigCrossHair
    end -- Shoulder the gun

    -- --down to this
    if not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        -- --If the key E (Use Key) is not pressed, then

        if self:GetOwner():KeyPressed( IN_ATTACK2 ) and not (self:GetReloading()) then
            self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos -- Bring it up
            self.IronSightsAng = self.SightsAng -- Bring it up
            self:SetIronsights( true, self:GetOwner() )
            self.DrawCrosshair = false

            if CLIENT then return end
        end
    end

    if self:GetOwner():KeyReleased( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        -- --If the right click is released, then
        self:GetOwner():SetFOV( 0, 0.3 )
        self.DrawCrosshair = self.OrigCrossHair
        self:SetIronsights( false )

        if CLIENT then return end
    end

    if self:GetOwner():KeyDown( IN_ATTACK2 ) and not self:GetOwner():KeyDown( IN_USE ) and not self:GetOwner():KeyDown( IN_SPEED ) then
        self.SwayScale = 0.05
        self.BobScale  = 0.05
    else
        self.SwayScale = 1.0
        self.BobScale  = 1.0
    end
end
