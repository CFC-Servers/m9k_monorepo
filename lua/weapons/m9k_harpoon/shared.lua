-- Variables that are used on both client and server
SWEP.Gun = ("m9k_harpoon") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Specialties"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Harpoon"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 23			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 1			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "melee"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
--SWEP.ViewModel				= "models/weapons/v_invisib.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_harpooner.mdl"	-- Weapon world model
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater 		= false
SWEP.ShowWorldModel			= true

SWEP.Primary.Sound			= Sound("")		-- Script that calls the primary fire sound
SWEP.Primary.RPM				= 60		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with
SWEP.Primary.KickUp				= 0		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "Harpoon"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("m9k_thrown_harpoon")	--NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV			= 60		-- How much you 'zoom' in. Less is more! 	

SWEP.Primary.NumShots	= 0		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 0	-- Base damage per bullet
SWEP.Primary.Spread		= 0	-- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(0, -12.952, -2.951)
SWEP.IronSightsAng = Vector(64.835, 0, 0)
SWEP.SightsPos = Vector(0, -12.952, -2.951)
SWEP.SightsAng = Vector(64.835, 0, 0)
SWEP.RunSightsPos = Vector(0, 12.295, 10.656)
SWEP.RunSightsAng = Vector(-145, 3.5, 0)



-- SWEP.WElements = {
	-- ["harpoon"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.413, 5.945, -0.894), angle = Angle(-5.52, -71.026, -122.169), size = Vector(0.578, 0.578, 0.578), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
-- }

if file.Exists( "models/weapons/v_knife_t.mdl", "GAME" ) then
	SWEP.ViewModel				= "models/weapons/v_knife_t.mdl"	-- Weapon view model
	SWEP.VElements = {
		["harpoon"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "v_weapon.knife_Parent", rel = "", pos = Vector(6.3, -6.481, -5.825), angle = Angle(128.731, -17.442, -142.782), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
		SWEP.ViewModelBoneMods = {
		["v_weapon.Knife_Handle"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 30, -30), angle = Angle(0, 0, 0) },
		["v_weapon.Right_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 30, 30), angle = Angle(0, 0, 0) }
		}
else
	SWEP.ViewModel				= "models/weapons/v_invisib.mdl"	-- Weapon view model
	SWEP.VElements = {
		["harpoon"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "Da Machete", rel = "", pos = Vector(-9.362, 2.611, 12.76), angle = Angle(60.882, 128.927, 105.971), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
		SWEP.ViewModelBoneMods = {
		["l-upperarm"] = { scale = Vector(1, 1, 1), pos = Vector(-7.286, 1.628, 7.461), angle = Angle(7.182, 0, 0) },
		["r-upperarm-movement"] = { scale = Vector(1, 1, 1), pos = Vector(-30, -30, -30), angle = Angle(0, 0, 0) },
		["l-upperarm-movement"] = { scale = Vector(1, 1, 1), pos = Vector(3.615, 0.547, 4.635), angle = Angle(-45.929, -39.949, -76.849) },
		["l-forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.932, -42.389, 171.466) },
		["r-upperarm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.336, 0, 0) },
		["lwrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-47.502, -5.645, 0.551) }
		}

end


function SWEP:PrimaryAttack()
	self:FireRocket()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))	
	self.Weapon:EmitSound(Sound("Weapon_Knife.Slash"))
	self.Weapon:TakePrimaryAmmo(1)
	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self:CheckWeaponsAndAmmo()
end

function SWEP:FireRocket()
	pos = self.Owner:GetShootPos()
	if SERVER then
	local rocket = ents.Create(self.Primary.Round)
	if !rocket:IsValid() then return false end
	rocket:SetAngles(self.Owner:GetAimVector():Angle())
	rocket:SetPos(pos)
	rocket:SetOwner(self.Owner)
	rocket:Spawn()
	rocket.Owner = self.Owner
	rocket:Activate()
	eyes = self.Owner:EyeAngles()
		local phys = rocket:GetPhysicsObject()
			phys:SetVelocity(self.Owner:GetAimVector() * 2000)
	end
		if SERVER and !self.Owner:IsNPC() then
		local anglo = Angle(-10, -5, 0)		
		self.Owner:ViewPunch(anglo)
		end

end

function SWEP:CheckWeaponsAndAmmo()

	if SERVER and self.Weapon != nil and ((gmod.GetGamemode().Name == "Murderthon 9000") or GetConVar("DebugM9K"):GetBool()) then 
		timer.Simple(.1, function() 
			if SERVER then 
				if not IsValid(self) then return end
				if self.Owner == nil then return end
				self.Owner:StripWeapon(self.Gun)
			end
		end)
	return end

	if SERVER and self.Weapon != nil then 
		if self.Weapon:Clip1() == 0 && self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
			timer.Simple(.1, function() if SERVER then if not IsValid(self) then return end
				if self.Owner == nil then return end
				self.Owner:StripWeapon(self.Gun)
			end end)
		else
			self:Reload()
		end
	end
end

function SWEP:Reload()
	if not IsValid(self) then return end if not IsValid(self.Owner) then return end
	
	if self.Owner:IsNPC() then
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	return end
	
	if self.Owner:KeyDown(IN_USE) then return end
		self.Weapon:DefaultReload(ACT_VM_DRAW) 
	
	if !self.Owner:IsNPC() then
		if self.Owner:GetViewModel() == nil then self.ResetSights = CurTime() + 3 else
		self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration() 
		end
	end
end

function SWEP:SecondaryAttack()
return false
end	

function SWEP:Think()
end

if (gmod.GetGamemode().Name == "Murderthon 9000") or GetConVar("DebugM9K"):GetBool() then
	SWEP.Primary.ClipSize			= -1		-- Size of a clip
	SWEP.Primary.DefaultClip		= -1		-- Bullets you start with
	SWEP.Primary.Ammo			= "none"
end

if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end