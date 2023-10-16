-- Variables that are used on both client and server
SWEP.Gun = ("m9k_usas") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Shotguns"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "USAS"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 29			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= true		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "ar2"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/v_usas12_shot.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_usas_12.mdl"	-- Weapon world model
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("Weapon_usas.Single")		-- Script that calls the primary fire sound
SWEP.Primary.RPM			= 260			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 20		-- Size of a clip
SWEP.Primary.DefaultClip		= 60		-- Bullets you start with
SWEP.Primary.KickUp				= 1		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.4		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.7		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= true		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "buckshot"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.SelectiveFire		= true

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.NumShots	= 10		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 7	-- Base damage per bullet
SWEP.Primary.Spread		= .048	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .048 -- Ironsight accuracy, should be the same for shotguns

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(4.519, -2.159, 1.039)
SWEP.IronSightsAng = Vector(0.072, 0.975, 0)
SWEP.SightsPos = Vector(4.519, -2.159, 1.039)
SWEP.SightsAng = Vector(0.072, 0.975, 0)
SWEP.RunSightsPos = Vector (-3.0328, 0, 1.888)
SWEP.RunSightsAng = Vector (-24.2146, -36.522, 10)

SWEP.ReloadPos = Vector (-3.0328, 0, 1.888)
SWEP.ReloadsAng = Vector (-24.2146, -36.522, 10)

SWEP.WElements = {
	["fix2"] = { type = "Model", model = "models/hunter/blocks/cube025x05x025.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.416, 2.073, -5.571), angle = Angle(0, 0, -90), size = Vector(0.899, 0.118, 0.1), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["magfix"] = { type = "Model", model = "models/XQM/cylinderx1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.482, 1.389, 0.078), angle = Angle(-8.098, 0, 0), size = Vector(0.2, 0.589, 0.589), color = Color(0, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:Reload()

	if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and (self.Owner:GetAmmoCount("buckshot") > 0 ) and not (self.Weapon:GetNWBool("Reloading")) then
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START) 
		self.Weapon:SetNWBool("Reloading", true)
		if SERVER and !self.Owner:IsNPC() then
			self.ResetSights = CurTime() + 1.65
			self.Owner:SetFOV( 0, 0.3 )
			self:SetIronsights(false)
		end
		timer.Simple(.65, function() if not IsValid(self) then return end if not IsValid(self.Owner) then return end if not IsValid(self.Weapon) then return end
			if IsValid(self.Owner) and self.Weapon:GetClass() == self.Gun then 
				self.Weapon:EmitSound(Sound("Weapon_usas.draw"))
			end
		end)
		timer.Simple(.8, function() if not IsValid(self) then return end if not IsValid(self.Owner) then return end if not IsValid(self.Weapon) then return end
		if IsValid(self.Owner) and self.Weapon != nil then self:ReloadFinish() end end)
	end

end

function SWEP:ReloadFinish()
if not IsValid(self) then return end 
	if IsValid(self.Owner) and self.Weapon != nil then
		if self.Owner:Alive() and self.Weapon:GetClass() == self.Gun then
			self.Weapon:DefaultReload(ACT_SHOTGUN_RELOAD_FINISH)
			
			if !self.Owner:IsNPC() then
				self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration() 
			end
			if SERVER and self.Weapon != nil then
				if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and !self.Owner:IsNPC() then
					self.Owner:SetFOV( 0, 0.3 )
					self:SetIronsights(false)
			end

		local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
		timer.Simple(waitdammit + .1, 
		function() if not IsValid(self) then return end if not IsValid(self.Owner) then return end if not IsValid(self.Weapon) then return end
		if self.Weapon == nil then return end
		self.Weapon:SetNWBool("Reloading", false)
		if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then 
			if CLIENT then return end
			if self.Scoped == false then
				self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
				self.IronSightsPos = self.SightsPos					-- Bring it up
				self.IronSightsAng = self.SightsAng					-- Bring it up
				self:SetIronsights(true, self.Owner)
				self.DrawCrosshair = false
			else return end
		elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then 
			self.Weapon:SetNextPrimaryFire(CurTime()+0.3)			-- Make it so you can't shoot for another quarter second
			self.IronSightsPos = self.RunSightsPos					-- Hold it down
			self.IronSightsAng = self.RunSightsAng					-- Hold it down
			self:SetIronsights(true, self.Owner)					-- Set the ironsight true
			self.Owner:SetFOV( 0, 0.3 )
		else return end
		end) 
			end
		end
	end
end

if GetConVar("M9KDefaultClip") == nil then
	print("M9KDefaultClip is missing! You may have hit the lua limit!")
else
	if GetConVar("M9KDefaultClip"):GetInt() != -1 then
		SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * GetConVar("M9KDefaultClip"):GetInt()
	end
end

if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end