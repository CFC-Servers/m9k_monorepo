-- Variables that are used on both client and server
SWEP.Gun = "m9k_usas" -- must be the name of your swep but NO CAPITALS!
SWEP.Category = "M9K Shotguns"
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.MuzzleAttachment = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName = "USAS" -- Weapon name (Shown on HUD)
SWEP.Slot = 3
SWEP.SlotPos = 29
SWEP.DrawAmmo = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair = true -- set false if you want no crosshair
SWEP.Weight = 30
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.HoldType = "ar2"


SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_usas12_shot.mdl"
SWEP.WorldModel = "models/weapons/w_usas_12.mdl"
SWEP.Base = "bobs_gun_base"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.Sound = "Weapon_usas.Single"
SWEP.Primary.RPM = 260 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 60
SWEP.Primary.KickUp = 1 -- Maximum up recoil (rise)
SWEP.Primary.KickDown = 0.4 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0.7 -- Maximum up recoil (stock)
SWEP.Primary.Automatic = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo = "buckshot" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets
SWEP.SelectiveFire = true
SWEP.Secondary.IronFOV = 55 -- How much you 'zoom' in. Less is more!
SWEP.data = {} --The starting firemode
SWEP.data.ironsights = 1
SWEP.Primary.NumShots = 10 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage = 7 -- Base damage per bullet
SWEP.Primary.SpreadHip = .048 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights = .048 -- Ironsight accuracy, should be the same for shotguns
SWEP.SightsPos = Vector( 4.519, -2.159, 1.039 )
SWEP.SightsAng = Vector( 0.072, 0.975, 0 )
SWEP.RunSightsPos = Vector( -3.0328, 0, 1.888 )
SWEP.RunSightsAng = Vector( -24.2146, -36.522, 10 )
SWEP.ReloadPos = Vector( -3.0328, 0, 1.888 )
SWEP.ReloadsAng = Vector( -24.2146, -36.522, 10 )
SWEP.WElements = {
    ["fix2"] = {
        type = "Model",
        model = "models/hunter/blocks/cube025x05x025.mdl",
        bone = "ValveBiped.Bip01_R_Hand",
        rel = "",
        pos = Vector( 22.416, 2.073, -5.571 ),
        angle = Angle( 0, 0, -90 ),
        size = Vector( 0.899, 0.118, 0.1 ),
        color = Color( 0, 0, 0, 255 ),
        surpresslightning = false,
        material = "",
        skin = 0,
        bodygroup = {}
    },
    ["magfix"] = {
        type = "Model",
        model = "models/XQM/cylinderx1.mdl",
        bone = "ValveBiped.Bip01_R_Hand",
        rel = "",
        pos = Vector( 10.482, 1.389, 0.078 ),
        angle = Angle( -8.098, 0, 0 ),
        size = Vector( 0.2, 0.589, 0.589 ),
        color = Color( 0, 0, 0, 255 ),
        surpresslightning = false,
        material = "",
        skin = 0,
        bodygroup = {}
    }
}

function SWEP:Reload()
    local owner = self:GetOwner()

    if self:Clip1() < self.Primary.ClipSize and owner:GetAmmoCount( "buckshot" ) > 0 and not self:GetReloading() then
        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
        self:SetReloading( true )
        self:SetNextPrimaryFire( CurTime() + owner:GetViewModel():SequenceDuration() )

        if SERVER and not owner:IsNPC() then
            self.ResetSights = CurTime() + 1.65
            owner:SetFOV( 0, 0.3 )
            self:SetIronsights( false )
        end

        timer.Simple( .65, function()
            if not IsValid( self ) then return end
            if not IsValid( owner ) then return end
            self:EmitSound( "Weapon_usas.draw" )
        end )

        timer.Simple( .8, function()
            if not IsValid( self ) then return end
            if not IsValid( owner ) then return end
            self:ReloadFinish()
        end )
    end
end

function SWEP:ReloadFinish()
    local owner = self:GetOwner()

    self:DefaultReload( ACT_SHOTGUN_RELOAD_FINISH )
    if not owner:IsNPC() then
        self.ResetSights = CurTime() + owner:GetViewModel():SequenceDuration()
    end

    if not SERVER then return end

    if self:Clip1() < self.Primary.ClipSize and not owner:IsNPC() then
        owner:SetFOV( 0, 0.3 )
        self:SetIronsights( false )
    end

    local waitdammit = owner:GetViewModel():SequenceDuration()
    timer.Simple( waitdammit + .1, function()
        if not IsValid( self ) then return end
        if not IsValid( owner ) then return end
        self:SetReloading( false )
        if owner:KeyDown( IN_ATTACK2 ) and self.Scoped == false then
            owner:SetFOV( self.Secondary.IronFOV, 0.3 )
            self.IronSightsPos = self.SightsPos
            self.IronSightsAng = self.SightsAng
            self:SetIronsights( true, owner )
            self.DrawCrosshair = false
        elseif owner:KeyDown( IN_SPEED ) then
            self:SetNextPrimaryFire( CurTime() + 0.3 )
            self.IronSightsPos = self.RunSightsPos
            self.IronSightsAng = self.RunSightsAng
            self:SetIronsights( true )
            owner:SetFOV( 0, 0.3 )
        end
    end )
end
