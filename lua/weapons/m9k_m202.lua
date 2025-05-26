-- Variables that are used on both client and server
SWEP.Gun = "m9k_m202" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Specialties"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "M202" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 4 -- Slot in the weapon selection menu
SWEP.SlotPos                = 32 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative to other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "rpg" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_M202.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_rocket_launcher.mdl" -- Weapon world model
SWEP.ShowWorldModel         = false
SWEP.Base                   = "bobs_gun_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true
SWEP.FiresUnderwater        = false

SWEP.Primary.Sound          = "" -- Script that calls the primary fire sound
SWEP.Primary.RPM            = 300 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 4 -- Size of a clip
SWEP.Primary.DefaultClip    = 4 -- Bullets you start with
SWEP.Primary.KickUp         = 0 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 0 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 0 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = true -- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo           = "m202_rocket"
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal piercing shotgun slug

SWEP.Primary.Round          = "m9k_m202_rocket" --NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV      = 40 -- How much you 'zoom' in. Less is more!

SWEP.Primary.NumShots       = 0 -- How many bullets to shoot per trigger pull
SWEP.Primary.Damage         = 0 -- Base damage per bullet
SWEP.Primary.SpreadHip         = 0 -- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

SWEP.SightsPos              = Vector( -4.7089, 1.2661, -0.3572 )
SWEP.SightsAng              = Vector( -0.1801, 0.985, 0 )
SWEP.RunSightsPos           = Vector( 7.3256, 6.8881, -4.8875 )
SWEP.RunSightsAng           = Vector( -15.596, 53.0059, -11.98 )

SWEP.WElements              = {
    ["m202"] = { type = "Model", model = "models/weapons/w_m202.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector( 13.255, 1.021, -2.869 ), angle = Angle( 180, 90, -11.981 ), size = Vector(
        1, 1, 1 ), color = Color( 255, 255, 255, 255 ), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

--and now to the nasty parts of this swep...

function SWEP:PrimaryAttack()
    if self:CanPrimaryAttack() and not self:GetOwner():KeyDown( IN_SPEED ) then
        self:FireRocket()
        self:EmitSound( "M202F.single" )
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
    end
    self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
    local aim = self:GetOwner():GetAimVector()
    local side = aim:Cross( Vector( 0, 0, 1 ) )
    local up = side:Cross( aim )
    local pos = self:GetOwner():M9K_GetShootPos() + side * 5 + up * .5

    if SERVER then
        local rocket = ents.Create( self.Primary.Round )
        if not rocket:IsValid() then return false end
        rocket:SetAngles( aim:Angle() + Angle( 0, 0, 0 ) )
        rocket:SetPos( pos )
        rocket:SetOwner( self:GetOwner() )
        rocket:Spawn()
        rocket:Activate()
    end
end

function SWEP:Reload()
    self:DefaultReload( ACT_VM_DRAW )

    if not self:GetOwner():IsNPC() then
        self.ResetSights = CurTime() + self:GetOwner():GetViewModel():SequenceDuration()
    end
    if SERVER then
        if (self:Clip1() < self.Primary.ClipSize) and not self:GetOwner():IsNPC() then
            self:GetOwner():SetFOV( 0, 0.3 )
            self:SetIronsights( false )
            self:SetReloading( true )
        end
        local waitdammit = (self:GetOwner():GetViewModel():SequenceDuration())
        timer.Simple( waitdammit + .1,
            function()
                if IsValid( self ) and IsValid( self:GetOwner() ) then
                    if self:GetOwner():Alive() and self:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
                        self:SetReloading( false )
                        if self:GetOwner():KeyDown( IN_ATTACK2 ) then
                            if CLIENT then return end
                            if self.Scoped == false then
                                self:GetOwner():SetFOV( self.Secondary.IronFOV, 0.3 )
                                self.IronSightsPos = self.SightsPos -- Bring it up
                                self.IronSightsAng = self.SightsAng -- Bring it up
                                self:SetIronsights( true )
                                self.DrawCrosshair = false
                            else
                                return
                            end
                        elseif self:GetOwner():KeyDown( IN_SPEED ) then
                            self:SetNextPrimaryFire( CurTime() + 0.3 ) -- Make it so you can't shoot for another quarter second
                            self.IronSightsPos = self.RunSightsPos -- Hold it down
                            self.IronSightsAng = self.RunSightsAng -- Hold it down
                            self:SetIronsights( true )
                            self:GetOwner():SetFOV( 0, 0.3 )
                        else
                            return
                        end
                    end
                end
            end )
    end
end

function SWEP:SecondaryAttack()
end
