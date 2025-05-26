-- Variables that are used on both client and server
SWEP.Gun = "m9k_ied_detonator" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ("Fire to drop ied." .. "\n" .. "Alt fire to detonate")
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "IED Detonator" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4 -- Slot in the weapon selection menu
SWEP.SlotPos                = 25 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = false -- set false if you want no crosshair
SWEP.Weight                 = 2 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "fist" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV           = 75
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_invisib.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_camphon2.mdl" -- Weapon world model
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = true

SWEP.Primary.Sound          = "" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 60 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 1 -- Size of a clip
SWEP.Primary.DefaultClip    = 1 -- Bullets you start with
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "Improvised_Explosive"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_improvised_explosive" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!
SWEP.Secondary.ClipSize     = 1 -- Size of a clip
SWEP.Secondary.DefaultClip  = 1 -- Default number of bullets in a clip
SWEP.Secondary.Automatic    = false -- Automatic/Semi Auto
SWEP.Secondary.Ammo         = ""

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos              = Vector( 0, 0, 0 ) -- These are the same as IronSightPos and IronSightAng
SWEP.SightsAng              = Vector( 0, 0, 0 ) -- No, I don't know why
SWEP.RunSightsPos           = Vector( 0, 0, 0 )
SWEP.RunSightsAng           = Vector( 0, 0, 0 )

--and now to the nasty parts of this swep...

if IsMounted( "cstrike" ) then
    SWEP.ViewModel         = "models/weapons/v_knife_t.mdl" -- Weapon view model
    SWEP.ViewModelBoneMods = {
        ["v_weapon.knife_Parent"] = { scale = Vector( 0.009, 0.009, 0.009 ), pos = Vector( 0, 0, 1.904 ), angle = Angle( 0, 0, 0 ) },
        ["v_weapon.Right_Middle02"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 35.375, 0 ) },
        ["v_weapon.Right_Pinky03"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 31.504, 0 ) },
        ["v_weapon.Right_Index02"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 2.875, 26.035, 0 ) },
        ["v_weapon.Right_Index01"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0.912, 30.708, 0 ) },
        ["v_weapon.Right_Ring01"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 6.368, 23.934, 0 ) },
        ["v_weapon.Right_Index03"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 47.61, 0 ) },
        ["v_weapon.Right_Pinky02"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 27.075, 0 ) },
        ["v_weapon.Right_Thumb03"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 7.138, -15.06, -13.447 ) },
        ["v_weapon.Left_Arm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -16.826, -30, 2.539 ), angle = Angle( 0, 0, 0 ) },
        ["v_weapon.Right_Middle01"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 29.128, 0 ) },
        ["v_weapon.Right_Ring03"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -1.68, 5.666, 0 ) },
        ["v_weapon.Right_Pinky01"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 23.523, 0 ) },
        ["v_weapon.Right_Middle03"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, -1.736, 0 ) },
        ["v_weapon.Right_Thumb01"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -0.519, 0, 0 ), angle = Angle( -10.695, 2.921, 3.049 ) },
        ["v_weapon.Right_Thumb02"] = { scale = Vector( 1, 1, 1 ), pos = Vector( -0.009, 0, 0 ), angle = Angle( -5.969, 3.542, -26.505 ) },
        ["v_weapon.Right_Ring02"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 35.75, 0 ) }
    }
    SWEP.VElements         = {
        ["phone"] = { type = "Model", model = "models/weapons/w_camphon2.mdl", bone = "v_weapon.knife_Parent", rel = "", pos = Vector( 2.884, 1.353, 1.207 ), angle = Angle( 13.812, 168.289, 83.724 ), size =
            Vector( 1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    }
else
    SWEP.ViewModel         = "models/weapons/v_invisib.mdl" -- Weapon view model
    SWEP.ViewModelBoneMods = {
        ["r-ring-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0.148, 0 ), angle = Angle( 14.43, 0, 0 ) },
        ["r-middle-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -77.495, 0, 0 ) },
        ["r-pinky-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -101.027, 0, 0 ) },
        ["r-ring-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -86.765, 0, 0 ) },
        ["r-index-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -3.405, 0, 0 ) },
        ["r-forearm"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 0, 3.042, 100.974 ) },
        ["r-thumb-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 38.379, 0, 0 ) },
        ["r-index-mid"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -108.598, 0, 0 ) },
        ["r-middle-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 4.488, 0, 0 ) },
        ["r-pinky-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( 25.802, 0, 0 ) },
        ["r-thumb-tip"] = { scale = Vector( 1, 0.845, 0.989 ), pos = Vector( 0, 0, 0 ), angle = Angle( -17.769, 0, 0 ) },
        ["r-thumb-low"] = { scale = Vector( 1, 1, 1 ), pos = Vector( 0, 0, 0 ), angle = Angle( -13.4, 32.006, -34.099 ) }
    }
    SWEP.VElements         = {
        ["phone"] = { type = "Model", model = "models/weapons/w_camphon2.mdl", bone = "Da Machete", rel = "", pos = Vector( -4.327, 6.361, 15.64 ), angle = Angle( 141.658, -25.886, -28.254 ), size =
            Vector( 1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
    }
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    self:TakePrimaryAmmo( 1 )
    self:SetNextPrimaryFire( CurTime() + 1 / ( self.Primary.RPM / 60 ) )

    if CLIENT then return end

    local aim = self:GetOwner():GetAimVector()
    local side = aim:Cross( Vector( 0, 0, 1 ) )
    local up = side:Cross( aim )
    local pos = self:GetOwner():M9K_GetShootPos() + side * -5 + up * -10

    local rocket = ents.Create( self.Primary.Round )
    if not rocket:IsValid() then return false end

    rocket:SetAngles( aim:Angle() + Angle( 90, 0, 0 ) )
    rocket:SetPos( pos )
    rocket.BombOwner = self:GetOwner()
    rocket:Spawn()

    local phys = rocket:GetPhysicsObject()
    phys:ApplyForceCenter( self:GetOwner():GetAimVector() * 1500 )

    timer.Simple( 0.25, function()
        if not IsValid( self ) then return end
        if not IsValid( self:GetOwner() ) then return end
        if self:GetOwner():Alive() and self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
            self:Reload()
        end
    end )
end

if SERVER then
    local weaponStrip = GetConVar( "M9KWeaponStrip" )
    function SWEP:SecondaryAttack()
        local foundBomb = false
        for _, v in pairs( ents.FindByClass( "m9k_improvised_explosive" ) ) do
            if v.BombOwner == self:GetOwner() then
                v.Boom = true
                foundBomb = true
            end
        end

        if foundBomb then
            self:SendWeaponAnim( ACT_VM_DRAW )
        end

        timer.Simple( 0.01, function()
            if not IsValid( self ) then return end
            if not IsValid( self:GetOwner() ) then return end
            if self:Clip1() == 0 and self:GetOwner():GetAmmoCount( self:GetPrimaryAmmoType() ) == 0 and weaponStrip:GetBool() then
                self:GetOwner():StripWeapon( self.Gun )
            end
        end )
    end
end
