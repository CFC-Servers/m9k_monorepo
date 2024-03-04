-- Variables that are used on both client and server
SWEP.Gun = ("m9k_dbarrel") -- must be the name of your swep but NO CAPITALS!
if (GetConVar( SWEP.Gun .. "_allowed" )) ~= nil then
    if not (GetConVar( SWEP.Gun .. "_allowed" ):GetBool()) then
        SWEP.Base = "bobs_blacklisted"
        SWEP.PrintName = SWEP.Gun
        return
    end
end
SWEP.Category               = "M9K Shotguns"
SWEP.Author                 = ""
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment   = "2" -- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName              = "Double Barrel Shotgun" -- Weapon name (Shown on HUD)
SWEP.Slot                   = 3 -- Slot in the weapon selection menu
SWEP.SlotPos                = 21 -- Position in the slot
SWEP.DrawAmmo               = true -- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox      = false -- Should draw the weapon info box
SWEP.BounceWeaponIcon       = false -- Should the weapon icon bounce?
SWEP.DrawCrosshair          = true -- set false if you want no crosshair
SWEP.Weight                 = 30 -- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo           = true -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom         = true -- Auto switch from if you pick up a better weapon
SWEP.HoldType               = "shotgun" -- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV           = 70
SWEP.ViewModelFlip          = false
SWEP.ViewModel              = "models/weapons/v_doublebarrl.mdl" -- Weapon view model
SWEP.WorldModel             = "models/weapons/w_double_barrel_shotgun.mdl" -- Weapon world model
SWEP.Base                   = "bobs_shotty_base"
SWEP.Spawnable              = true
SWEP.AdminSpawnable         = true

SWEP.Primary.Sound          = "Double_Barrel.Single" -- script that calls the primary fire sound
SWEP.Primary.RPM            = 180 -- This is in Rounds Per Minute
SWEP.Primary.ClipSize       = 2 -- Size of a clip
SWEP.Primary.DefaultClip    = 30 -- Default number of bullets in a clip
SWEP.Primary.KickUp         = 10 -- Maximum up recoil (rise)
SWEP.Primary.KickDown       = 5 -- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal = 5 -- Maximum up recoil (stock)
SWEP.Primary.Automatic      = false -- Automatic/Semi Auto
SWEP.Primary.Ammo           = "buckshot" -- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV      = 0 -- How much you 'zoom' in. Less is more!

SWEP.data                   = {} --The starting firemode
SWEP.data.ironsights        = 1

SWEP.ShellTime              = .5

SWEP.Primary.NumShots       = 18 -- How many bullets to shoot per trigger pull, AKA pellets
SWEP.Primary.Damage         = 10 -- Base damage per bullet
SWEP.Primary.Spread         = .03 -- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy   = .03 -- Ironsight accuracy, should be the same for shotguns
-- Because irons don't magically give you less pellet spread!

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos          = Vector( 0, 0, 0 )
SWEP.IronSightsAng          = Vector( 0, 0, 0 )
SWEP.SightsPos              = Vector( 0, 0, 0 )
SWEP.SightsAng              = Vector( 0, 0, 0 )
SWEP.RunSightsPos           = Vector( 11.475, -7.705, -2.787 )
SWEP.RunSightsAng           = Vector( 0.574, 51.638, 5.737 )

SWEP.Secondary.Sound        = "dbarrel_dblast"

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

local function NewM9KDamageMultiplierDB()
    print( "multiplier has been changed " )
    if GetConVar( "M9KDamageMultiplier" ) == nil then
        PainMulti = 1
        print( "M9KDamageMultiplier is missing! You may have hit the lua limit! Reverting multiplier to 1, you will notice no changes." )
    else
        PainMulti = GetConVar( "M9KDamageMultiplier" ):GetFloat()
        if PainMulti < 0 then
            PainMulti = PainMulti * -1
        end
    end
end
cvars.AddChangeCallback( "M9KDamageMultiplier", NewM9KDamageMultiplierDB )

function SWEP:SecondaryAttack()
    if not self:CanPrimaryAttack() then return end

    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    if timer.Exists( timerName ) then return end

    if self:GetOwner():IsPlayer() then
        if self:Clip1() == 2 then
            if not self:GetOwner():KeyDown( IN_SPEED ) and not self:GetOwner():KeyDown( IN_RELOAD ) then
                self:ShootBulletInformation2()
                self:TakePrimaryAmmo( 2 )
                self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
                self:EmitSound( self.Secondary.Sound )
                --self:GetOwner():ViewPunch(Angle(-15, math.Rand(-20,-25), 0))

                local fx = EffectData()
                fx:SetEntity( self )
                fx:SetOrigin( self:GetOwner():GetShootPos() )
                fx:SetNormal( self:GetOwner():GetAimVector() )
                fx:SetAttachment( self.MuzzleAttachment )

                self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
                self:GetOwner():MuzzleFlash()
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

    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    if timer.Exists( timerName ) then return end

    if self:GetOwner():IsPlayer() then
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

            local fx = EffectData()
            fx:SetEntity( self )
            fx:SetOrigin( self:GetOwner():GetShootPos() )
            fx:SetNormal( self:GetOwner():GetAimVector() )
            fx:SetAttachment( self.MuzzleAttachment )

            self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
            self:GetOwner():MuzzleFlash()
            self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
            self:CheckWeaponsAndAmmo()
            self.RicochetCoin = (math.random( 1, 4 ))
            if self.BoltAction then self:BoltBack() end
        end
    elseif self:GetOwner():IsNPC() then
        self:ShootBulletInformation()
        self:TakePrimaryAmmo( 1 )
        self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
        self:EmitSound( self.Primary.Sound )
        self:GetOwner():SetAnimation( PLAYER_ATTACK1 )
        self:GetOwner():MuzzleFlash()
        self:SetNextPrimaryFire( CurTime() + 1 / (self.Primary.RPM / 60) )
        self.RicochetCoin = math.random( 1, 4 )
    end
end

function SWEP:ShootBulletInformation2()
    local CurrentDamage
    local CurrentRecoil
    local basedamage
    local damagedice = math.Rand( 0.95, 1.05 )

    basedamage = PainMulti * self.Primary.Damage
    CurrentDamage = basedamage * damagedice
    CurrentRecoil = self.Primary.Recoil

    self:ShootBullet( CurrentDamage, CurrentRecoil, 31, .06 )
end

--[[---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
-----------------------------------------------------------]]
function SWEP:Reload()
    if not IsValid( self ) then return end
    if not IsValid( self:GetOwner() ) then return end
    if not self:GetOwner():IsPlayer() then return end

    local maxcap = self.Primary.ClipSize
    local spaceavail = self:Clip1()
    local shellz = maxcap - spaceavail + 1

    if timer.Exists( "ShotgunReload" ) or self:GetOwner().NextReload > CurTime() or maxcap == spaceavail then return end

    if self:GetOwner():IsPlayer() then
        self:SetNextPrimaryFire( CurTime() + 3 )
        self:SetNextSecondaryFire( CurTime() + 3 )

        self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
        self:GetOwner():SetAnimation( PLAYER_RELOAD )

        self:GetOwner().NextReload = CurTime() + 1

        if SERVER then
            self:GetOwner():SetFOV( 0, 0.15 )
            self:SetIronsights( false )
        end

        if SERVER and self:GetOwner():Alive() then
            local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
            timer.Create( timerName, self.ShellTime + .05, shellz, function()
                if not IsValid( self ) or not IsValid( self:GetOwner() ) then return end
                if self:GetOwner():Alive() then
                    self:InsertShell()
                end
            end )
        end
    elseif self:GetOwner():IsNPC() then
        self:DefaultReload( ACT_VM_RELOAD )
    end
end

function SWEP:Think()
    if not IsValid( self ) then return end
    if not IsValid( self:GetOwner() ) then return end
    if not self:GetOwner():IsPlayer() then return end
    if self:GetOwner().NextReload == nil then self:GetOwner().NextReload = CurTime() + 1 end
    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    --if the owner presses shoot while the timer is in effect, then...
    -- if (self:GetOwner():KeyPressed(IN_ATTACK)) and (timer.Exists(timerName)) and not (self:GetOwner():KeyDown(IN_SPEED)) then
    -- if self:CanPrimaryAttack() then --well first, if we actually can attack, then...
    -- timer.Destroy(timerName) -- kill the timer, and
    -- self:PrimaryAttack()-- ATTAAAAACK!
    -- end
    -- end

    if self.InsertingShell == true and self:GetOwner():Alive() then
        vm = self:GetOwner():GetViewModel() -- its a messy way to do it, but holy shit, it works!
        vm:ResetSequence( vm:LookupSequence( "after_reload" ) ) -- Fuck you, garry, why the hell can't I reset a sequence in multiplayer?
        vm:SetPlaybackRate( .01 ) -- or if I can, why does facepunch have to be such a shitty community, and your wiki have to be an unreadable goddamn mess?
        self.InsertingShell = false -- You get paid for this, what's your excuse?
    end
end

function SWEP:InsertShell()
    if not IsValid( self ) then return end
    if not IsValid( self:GetOwner() ) then return end
    if not self:GetOwner():IsPlayer() then return end

    local timerName = "ShotgunReload_" .. self:GetOwner():UniqueID()
    if self:GetOwner():Alive() then
        local curwep = self:GetOwner():GetActiveWeapon()
        if curwep:GetClass() ~= self.Gun then
            timer.Remove( timerName )
            return
        end

        if self:Clip1() >= self.Primary.ClipSize or self:GetOwner():GetAmmoCount( self.Primary.Ammo ) <= 0 then
            -- if clip is full or ammo is out, then...
            self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH ) -- send the pump anim
            timer.Remove( timerName ) -- kill the timer
            self:SetNextPrimaryFire( CurTime() + .55 )
            self:SetNextSecondaryFire( CurTime() + .55 )
        elseif (self:Clip1() <= self.Primary.ClipSize and self:GetOwner():GetAmmoCount( self.Primary.Ammo ) >= 0) then
            self.InsertingShell = true --well, I tried!
            timer.Simple( .05, function()
                if not IsValid( self ) then return end
                self:ShellAnimCaller()
            end )
            self:GetOwner():RemoveAmmo( 1, self.Primary.Ammo, false ) -- out of the frying pan
            self:SetClip1( self:Clip1() + 1 ) --  into the fire
        end
    else
        timer.Remove( timerName ) -- kill the timer
    end
end

if GetConVar( "M9KDefaultClip" ) == nil then
    print( "M9KDefaultClip is missing! You may have hit the lua limit!" )
else
    if GetConVar( "M9KDefaultClip" ):GetInt() ~= -1 then
        SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar( "M9KDefaultClip" ):GetInt()
    end
end

if GetConVar( "M9KUniqueSlots" ) ~= nil then
    if not (GetConVar( "M9KUniqueSlots" ):GetBool()) then
        SWEP.SlotPos = 2
    end
end
