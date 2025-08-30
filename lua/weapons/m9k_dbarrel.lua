-- Variables that are used on both client and server
SWEP.Gun = "m9k_dbarrel" -- must be the name of your swep but NO CAPITALS!

SWEP.Category               = "M9K Shotguns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Double Barrel Shotgun" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3
SWEP.SlotPos                = 21
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30
SWEP.AutoSwitchTo           = true
SWEP.AutoSwitchFrom         = true
SWEP.HoldType               = "shotgun"



SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_doublebarrl.mdl"
SWEP.WorldModel             = "models/weapons/w_double_barrel_shotgun.mdl"
SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true

SWEP.Primary.Sound          = "Double_Barrel.Single"
SWEP.Primary.RPM            = 180 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 2
SWEP.Primary.DefaultClip    = 30 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 10 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "buckshot" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal piercing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.ShellTime              = .5

SWEP.Primary.NumShots       = 18 -- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage         = 10 -- Base damage per bullet
SWEP.Primary.SpreadHip         = .03 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.SpreadIronSights   = .03 -- Ironsight accuracy, should be the same for shotguns

SWEP.SightsPos              = Vector( 0, 0, 0 )
SWEP.SightsAng              = Vector( 0, 0, 0 )
SWEP.RunSightsPos           = Vector( 11.475, -7.705, -2.787 )
SWEP.RunSightsAng           = Vector( 0.574, 51.638, 5.737 )

SWEP.Secondary.Sound        = "dbarrel_dblast"

local dmgMultCvar = GetConVar( "M9KDamageMultiplier" )
local damageMultiplier = dmgMultCvar:GetFloat()

local function dmgMultCallback( _, _, new )
    damageMultiplier = tonumber( new )
end
cvars.AddChangeCallback( "M9KDamageMultiplier", dmgMultCallback, "dbarrel" )

function SWEP:SecondaryAttack()
    if not self:CanPrimaryAttack() then return end

    local owner = self:GetOwner()

    local timerName = "ShotgunReload_" .. owner:UniqueID()
    if timer.Exists( timerName ) then return end

    if owner:IsPlayer() then
        if self:Clip1() == 2 then
            if not owner:KeyDown( IN_SPEED ) and not owner:KeyDown( IN_RELOAD ) then
                self:ShootBulletInformation2()
                self:TakePrimaryAmmo( 2 )
                self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
                self:EmitSound( self.Secondary.Sound )
                --owner:ViewPunch(Angle(-15, math.Rand(-20,-25), 0))

                local fx = EffectData()
                fx:SetEntity( self )
                fx:SetOrigin( owner:M9K_GetShootPos() )
                fx:SetNormal( owner:GetAimVector() )
                fx:SetAttachment( self.MuzzleAttachment )

                owner:SetAnimation( PLAYER_ATTACK1 )
                owner:MuzzleFlash()
                self:SetNextSecondaryFire( CurTime() + 1 / ((self.Primary.RPM / 2) / 60) )
                self:CheckWeaponsAndAmmo()
                self.RicochetCoin = (math.random( 1, 8 ))
                if self.BoltAction then self:BoltBack() end
            end
        elseif self:Clip1() == 1 then
            self:PrimaryAttack()
            self:SetNextSecondaryFire( CurTime() + 1 / ((self.Primary.RPM / 2) / 60) )
        end

        self:Reload()
    end
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end

    local owner = self:GetOwner()

    local timerName = "ShotgunReload_" .. owner:UniqueID()
    if timer.Exists( timerName ) then return end

    if owner:IsPlayer() then
        if not owner:KeyDown( IN_SPEED ) and not owner:KeyDown( IN_RELOAD ) then
            self:ShootBulletInformation()
            self:TakePrimaryAmmo( 1 )

            self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
            self:EmitSound( self.Primary.Sound )

            local fx = EffectData()
            fx:SetEntity( self )
            fx:SetOrigin( owner:M9K_GetShootPos() )
            fx:SetNormal( owner:GetAimVector() )
            fx:SetAttachment( self.MuzzleAttachment )

            owner:SetAnimation( PLAYER_ATTACK1 )
            owner:MuzzleFlash()
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            self:CheckWeaponsAndAmmo()
            self.RicochetCoin = (math.random( 1, 4 ))
            if self.BoltAction then self:BoltBack() end
        end
    elseif owner:IsNPC() then
        self:ShootBulletInformation()
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self:EmitSound( self.Primary.Sound )
        owner:SetAnimation( PLAYER_ATTACK1 )
        owner:MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        self.RicochetCoin = math.random( 1, 4 )
    end
end

function SWEP:ShootBulletInformation2()
    local CurrentDamage
    local basedamage
    local damagedice = math.Rand( 0.95, 1.05 )

    basedamage = damageMultiplier * self.Primary.Damage
    CurrentDamage = basedamage * damagedice

    self:ShootBullet( CurrentDamage, 31, .06 )
end

--[[---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
-----------------------------------------------------------]]
function SWEP:Reload()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    local maxcap = self.Primary.ClipSize
    local spaceavail = self:Clip1()
    local shellz = maxcap - spaceavail + 1

    if timer.Exists( "ShotgunReload" ) or owner.NextReload > CurTime() or maxcap == spaceavail then return end

    if owner:IsPlayer() then
        self:SetNextPrimaryFire( CurTime() + 3 )
        self:SetNextSecondaryFire( CurTime() + 3 )

        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
        owner:SetAnimation( PLAYER_RELOAD )

        owner.NextReload = CurTime() + 1

        if SERVER then
            owner:SetFOV( 0, 0.15 )
            self:SetIronsights( false )
        end

        if SERVER and owner:Alive() then
            local timerName = "ShotgunReload_" .. owner:UniqueID()
            timer.Create( timerName, self.ShellTime + .05, shellz, function()
                if not IsValid( self ) or not IsValid( owner ) then return end
                if owner:Alive() then
                    self:InsertShell()
                end
            end )
        end
    elseif owner:IsNPC() then
        self:DefaultReload( ACT_VM_RELOAD )
    end
end

function SWEP:Think()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end
    if owner.NextReload == nil then owner.NextReload = CurTime() + 1 end

    if self.InsertingShell == true and owner:Alive() then
        vm = owner:GetViewModel() -- its a messy way to do it, but holy shit, it works!
        vm:ResetSequence( vm:LookupSequence( "after_reload" ) ) -- Fuck you, garry, why the hell can't I reset a sequence in multiplayer?
        vm:SetPlaybackRate( .01 ) -- or if I can, why does facepunch have to be such a shitty community, and your wiki have to be an unreadable goddamn mess?
        self.InsertingShell = false -- You get paid for this, what's your excuse?
    end
end

function SWEP:InsertShell()
    local owner = self:GetOwner()

    if not IsValid( owner ) then return end
    if not owner:IsPlayer() then return end

    local timerName = "ShotgunReload_" .. owner:UniqueID()
    if owner:Alive() then
        local curwep = owner:GetActiveWeapon()
        if not IsValid( curwep ) or curwep:GetClass() ~= self.Gun then
            timer.Remove( timerName )
            return
        end

        if self:Clip1() >= self.Primary.ClipSize or owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
            -- if clip is full or ammo is out, then...
            self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH ) -- send the pump anim
            timer.Remove( timerName ) -- kill the timer
            self:SetNextPrimaryFire( CurTime() + .55 )
            self:SetNextSecondaryFire( CurTime() + .55 )
        elseif (self:Clip1() <= self.Primary.ClipSize and owner:GetAmmoCount( self.Primary.Ammo ) >= 0) then
            self.InsertingShell = true --well, I tried!
            timer.Simple( .05, function()
                if not IsValid( self ) then return end
                self:ShellAnimCaller()
            end )
            owner:RemoveAmmo( 1, self.Primary.Ammo, false ) -- out of the frying pan
            self:SetClip1( self:Clip1() + 1 ) --  into the fire
        end
    else
        timer.Remove( timerName ) -- kill the timer
    end
end
