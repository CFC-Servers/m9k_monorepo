-- Variables that are used on both client and server
SWEP.Gun = ("m9k_suicide_bomb") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Specialties"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ("Right click to select delay".."\n".."Left click to plant.")
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Timed C4"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 4				-- Slot in the weapon selection menu
SWEP.SlotPos				= 27			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "slam"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and ar2 make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_sb.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_sb.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater 		= true

SWEP.Primary.Sound			= Sound("")		-- Script that calls the primary fire sound
SWEP.Primary.RPM				= 10		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip		= 1		-- Bullets you start with
SWEP.Primary.KickUp				= 0		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "C4Explosive"				
-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a metal peircing shotgun slug

SWEP.Primary.Round 			= ("m9k_mad_c4")	--NAME OF ENTITY GOES HERE

SWEP.Secondary.IronFOV			= 0		-- How much you 'zoom' in. Less is more! 

SWEP.Timer				= 0	

SWEP.Primary.NumShots	= 0		-- How many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 0	-- Base damage per bullet
SWEP.Primary.Spread		= 0	-- Define from-the-hip accuracy (1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = 0 -- Ironsight accuracy, should be the same for shotguns
--none of this matters for IEDs and other ent-tossing sweps

-- Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(0, 0, 0)	-- These are the same as IronSightPos and IronSightAng
SWEP.SightsAng = Vector(0, 0, 0)	-- No, I don't know why
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(0, 0, 0)

-- SWEP.WElements = {
	-- ["c4"] = { type = "Model", model = "models/weapons/w_sb.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.337, 2.444, -5.351), angle = Angle(-170.318, 7.367, 14.25), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
-- }

--and now to the nasty parts of this swep...

function SWEP:PrimaryAttack()
	local tr = {}
	tr.start = self.Owner:GetShootPos()
	tr.endpos = self.Owner:GetShootPos() + 100 * self.Owner:GetAimVector()
	tr.filter = {self.Owner}
	local trace = util.TraceLine(tr)
	
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function()
	if SERVER and self.Weapon != nil then if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == self.Gun then
	if self.Timer == 0 then
		if self:CanPrimaryAttack() then
			self.Owner:SetAnimation(PLAYER_ATTACK1)
			self.Weapon:TakePrimaryAmmo(1)
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
			self:Suicide()
		end

	elseif self.Timer >= 5 	then

		if self:CanPrimaryAttack() then
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
			self.Owner:SetAnimation(PLAYER_ATTACK1)
	
			self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	
			local tr = {}
			tr.start = self.Owner:GetShootPos()
			tr.endpos = self.Owner:GetShootPos() + 100 * self.Owner:GetAimVector()
			tr.filter = {self.Owner}
			local trace = util.TraceLine(tr)

			self:TakePrimaryAmmo(1)

			if (CLIENT) then return end
	
			C4 = ents.Create(self.Primary.Round)
			C4:SetPos(trace.HitPos + trace.HitNormal)
			trace.HitNormal.z = -trace.HitNormal.z
			C4:SetAngles(trace.HitNormal:Angle() - Angle(90, 180, 0))
			C4.Owner = self.Owner
			C4.Timer = self.Timer
			C4:Spawn()
			
			local boxes
			parentme = {}
			parentme[1] = "m9k_ammo_40mm"
			parentme[2] = "m9k_ammo_c4"
			parentme[3] = "m9k_ammo_frags"
			parentme[4] = "m9k_ammo_ieds"
			parentme[5] = "m9k_ammo_nervegas"
			parentme[6] = "m9k_ammo_nuke"
			parentme[7] = "m9k_ammo_proxmines"
			parentme[8] = "m9k_ammo_rockets"
			parentme[9] = "m9k_ammo_stickynades"
			parentme[10] = "m9k_ammo_357"
			parentme[11] = "m9k_ammo_ar2"
			parentme[12] = "m9k_ammo_buckshot"
			parentme[13] = "m9k_ammo_pistol"
			parentme[14] = "m9k_ammo_smg"
			parentme[15] = "m9k_ammo_sniper_rounds"
			parentme[16] = "m9k_ammo_winchester"
			
			if trace.Entity != nil and trace.Entity:IsValid() then
				for k, v in pairs (parentme) do
					if trace.Entity:GetClass() == v then
						boxes = trace.Entity
					end
				end
			end
			
			if trace.Entity and trace.Entity:IsValid() then
				if boxes and trace.Entity:GetPhysicsObject():IsValid() then
				C4:SetParent(trace.Entity)
				trace.Entity.Planted = true
			elseif not trace.Entity:IsNPC() and not trace.Entity:IsPlayer() and trace.Entity:GetPhysicsObject():IsValid() then
					constraint.Weld(C4, trace.Entity)
				end
			else
				C4:SetMoveType(MOVETYPE_NONE)
			end
			
			if not trace.Hit then
				C4:SetMoveType(MOVETYPE_VPHYSICS)
			end

			end
		end
	end end end)
	local wait = self.Owner:GetViewModel():SequenceDuration() + .75 
	self:CheckWeaponsAndAmmo(wait)
end

function SWEP:Suicide()
	if SERVER and self.Weapon != nil then
	if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == self.Gun and self.Owner:Alive() then

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Owner:GetPos())
	util.Effect("ThumperDust", effectdata)
	util.Effect("Explosion", effectdata)

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Owner:GetPos())			// Where is hits
		effectdata:SetNormal(Vector(0,0,1))		// Direction of particles
		effectdata:SetEntity(self.Owner)		// Who done it?
		effectdata:SetScale(1.3)			// Size of explosion
		effectdata:SetRadius(67)		// What texture it hits
		effectdata:SetMagnitude(18)			// Length of explosion trails
		util.Effect( "m9k_gdcw_cinematicboom", effectdata )

	util.ScreenShake(self.Owner:GetPos(), 2000, 255, 2.5, 1250		)
	util.BlastDamage(self.Weapon, self.Owner, self.Owner:GetPos(), 500, 500	)

	self.Owner:EmitSound(Sound("C4.Explode"))

	self.BetterBeDead = true
	end
	end
end

function SWEP:SecondaryAttack()

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.1)

	if self.Timer == 5 then
		if (SERVER) then
			self.Owner:PrintMessage(HUD_PRINTTALK, "10 Seconds.")
		end
		self.Timer = 10
		self.Owner:EmitSound("C4.PlantSound")

	elseif self.Timer == 10 then
		if (SERVER) then
			self.Owner:PrintMessage(HUD_PRINTTALK, "15 Seconds.")
		end
		self.Timer = 15
		self.Owner:EmitSound("C4.PlantSound")
		
	elseif self.Timer == 15 then
		if (SERVER) then
			self.Owner:PrintMessage(HUD_PRINTTALK, "20 Seconds.")
		end
		self.Timer = 20
		self.Owner:EmitSound("C4.PlantSound")
		
	elseif self.Timer == 20 then
		if (SERVER) then
			self.Owner:PrintMessage(HUD_PRINTTALK, "WARNING! TIMER REDUCED TO ZERO!")
		end
		self.Timer = 0
		self.Owner:EmitSound("C4.PlantSound")
		
	elseif self.Timer == 0 then
		if (SERVER) then
			self.Owner:PrintMessage(HUD_PRINTTALK, "5 Seconds.")
		end
		self.Timer = 5
		self.Owner:EmitSound("C4.PlantSound")
			
	end
end

function SWEP:Think()

	if self.BetterBeDead then
		self.Owner:Kill()
	end

end

function SWEP:CheckWeaponsAndAmmo(wait)
	timer.Simple(wait, function()
	if self.Weapon != nil then if self.Weapon:GetOwner():GetActiveWeapon():GetClass() == self.Gun then 
		if self.Weapon:Clip1() == 0 && self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) == 0 then
			timer.Simple(.01, function() if SERVER then
				if self.Owner == nil then return end
				self.Owner:StripWeapon(self.Gun)
				end end)
		else timer.Simple(.25, function()
			self:Reload()
			self.Weapon:SendWeaponAnim( ACT_VM_DRAW ) end)
		end
	end end
	end)
end



if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end