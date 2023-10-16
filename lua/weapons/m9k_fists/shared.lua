-- Variables that are used on both client and server
SWEP.Gun = ("m9k_fists") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Specialties"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ("Right click, right jab.".. "\n".. "Left Click, Left Jab." .. "\n" .. "Hold Reload to put up your guard.")
SWEP.PrintName				= "Fists"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 22			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "fist"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_punchy.mdl"	-- Weapon view model
SWEP.WorldModel				= ""	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "bobs_gun_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Primary.RPM			= 180			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 30		-- Size of a clip
SWEP.Primary.DefaultClip		= 60		-- Bullets you start with
SWEP.Primary.KickUp				= 0.4		-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.3		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.3		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= ""			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.IronFOV			= 0		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 25	-- Base damage per bullet
SWEP.Primary.Spread		= .02	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

//Enter iron sight info and bone mod info below
SWEP.IronSightsPos = Vector(-0.094, -6.755, 1.003)
SWEP.IronSightsAng = Vector(36.123, 0, 0)
SWEP.SightsPos = Vector(-0.094, -6.755, 1.003)
SWEP.SightsAng = Vector(36.123, 0, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-25.577, 0, 0)

SWEP.Slash = 1

SWEP.Primary.Sound	= Sound("Weapon_Knife.Slash") //woosh
punchtable = {"punchies/1.mp3","punchies/2.mp3","punchies/3.mp3","punchies/4.mp3","punchies/5.mp3",}
woosh = {"punchies/miss1.mp3", "punchies/miss2.mp3"}


function SWEP:PrimaryAttack()

	vm = self.Owner:GetViewModel()
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			self.Owner:ViewPunch(Angle(math.random(-5,5),-10,5))
			vm:SetSequence(vm:LookupSequence("punchmiss2")) //left
			vm:SetPlaybackRate( 1.5 )
			self.Weapon:EmitSound(Sound(table.Random(woosh)))//slash in the wind sound here
			timer.Create("LeftJab", .1, 1, function() if not IsValid(self) then return end
			
			if IsValid(self.Owner) and	
			
			IsValid(self.Weapon) then 
			
			if self.Owner:Alive() and self.Owner:GetActiveWeapon():GetClass() == self.Gun then  
			self:LeftJab() end end end)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
			self.Weapon:SetNextSecondaryFire((CurTime()+1/(self.Primary.RPM/60)))
		end
	end
end

function SWEP:LeftJab()

	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	damagedice = math.Rand(.95,1.95)
	pain = self.Primary.Damage * damagedice
	self.Owner:LagCompensation(true)
	if SERVER and IsValid(self.Owner) and IsValid(self.Weapon) then
		if self.Owner:Alive() then if self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			local slash = {}
			slash.start = pos
			slash.endpos = pos + (ang * 30)
			slash.filter = self.Owner
			slash.mins = Vector(-5, -3, 0)
			slash.maxs = Vector(3, 3, 3)
			local slashtrace = util.TraceHull(slash)
			if slashtrace.Hit then
				targ = slashtrace.Entity
				if targ:IsPlayer() or targ:IsNPC() then
					//find a way to splash a little blood
					
					self.Weapon:EmitSound(Sound(table.Random(punchtable)))//stab noise
					paininfo = DamageInfo()
					paininfo:SetDamage(pain)
					paininfo:SetDamageType(DMG_CLUB)
					paininfo:SetAttacker(self.Owner)
					paininfo:SetInflictor(self.Weapon)
					paininfo:SetDamageForce(slashtrace.Normal *5000)
					if SERVER then 
						targ:TakeDamageInfo(paininfo) 
						if targ:IsPlayer() then targ:ViewPunch(Angle(math.random(-5, 5), math.random(-25,25), math.random(-50,50))) end
					end
				else
					self.Weapon:EmitSound("Weapon_Crowbar.Melee_Hit")//thunk
				end
			end
		end end
	end
	self.Owner:LagCompensation(false)
end

function SWEP:SecondaryAttack()

	vm = self.Owner:GetViewModel()
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			self.Owner:ViewPunch(Angle(math.random(-5,5),10,-5))
			vm:SetSequence(vm:LookupSequence("punchmiss1")) //right
			vm:SetPlaybackRate( 1.5 )
			self.Weapon:EmitSound(Sound(table.Random(woosh)))//slash in the wind sound here
			
			timer.Create("RightJab", .1, 1, function() if not IsValid(self) then return end 
				if IsValid(self.Owner) and IsValid(self.Weapon) then 
				if self.Owner:Alive() and self.Owner:GetActiveWeapon():GetClass() == self.Gun then 
				self:RightJab()  end end end)
			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SetNextSecondaryFire(CurTime()+1/(self.Primary.RPM/60))
			self.Weapon:SetNextPrimaryFire((CurTime()+1/(self.Primary.RPM/60)))
		end
	end
end

function SWEP:RightJab()

	rpos = self.Owner:GetShootPos()
	rang = self.Owner:GetAimVector()
	damagedice = math.Rand(.95,1.95)
	pain = self.Primary.Damage * damagedice
	self.Owner:LagCompensation(true)
	if SERVER and IsValid(self.Owner) and IsValid(self.Weapon)  then
		if self.Owner:Alive() then if self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			local rslash = {}
			rslash.start = rpos
			rslash.endpos = rpos + (rang * 30)
			rslash.filter = self.Owner
			rslash.mins = Vector(-3, -3, 0)
			rslash.maxs = Vector(3, 5, 3)
			local rslashtrace = util.TraceHull(rslash)
			if rslashtrace.Hit then
				rtarg = rslashtrace.Entity
				if rtarg:IsPlayer() or rtarg:IsNPC() then
					//find a way to splash a little blood
					self.Weapon:EmitSound(Sound(table.Random(punchtable)))//stab noise
					paininfo = DamageInfo()
					paininfo:SetDamage(pain)
					paininfo:SetDamageType(DMG_CLUB)
					paininfo:SetAttacker(self.Owner)
					paininfo:SetInflictor(self.Weapon)
					paininfo:SetDamageForce(rslashtrace.Normal *5000)
					if SERVER then 
						rtarg:TakeDamageInfo(paininfo) 
						if rtarg:IsPlayer() then rtarg:ViewPunch(Angle(math.random(-5, 5), math.random(-25,25), math.random(-50,50))) end
					end
				else
					self.Weapon:EmitSound("Weapon_Crowbar.Melee_Hit")//thunk
				end
			end
		end end
	end
	self.Owner:LagCompensation(false)

end

function SWEP:Reload()
end

--[[ function DukesUp(victim, info)

	if !IsValid(victim) then return end
	if victim:IsPlayer() and victim:Alive() then
		-- if victim:GetActiveWeapon() != nil then
			-- if victim:GetActiveWeapon():GetClass() == "m9k_fists" then
				if victim:GetNWBool("DukesAreUp", false) and info:GetDamageType() == DMG_CLUB then
					victim:SetHealth(victim:Health() + (info:GetDamage()))
					victim:SetHealth(victim:Health() - (info:GetDamage()/4))
				end 
			--end
		--end
	end
end
hook.Add("EntityTakeDamage", "DukesUp", DukesUp ) ]]
--This hook has been moved to Autorun

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) and not self.Owner:IsNPC() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	self.Owner:SetNWBool("DukesAreUp", false)
	return true
end

function SWEP:IronSight()

	if !self.Owner:IsNPC() then
		if self.Owner:GetNWBool("DukesAreUp") == nil then
			self.Owner:SetNWBool("DukesAreUp", false)
		end
		if self.ResetSights and CurTime() >= self.ResetSights then
			self.ResetSights = nil
			self:SendWeaponAnim(ACT_VM_IDLE)
		end 
	end
	
	if self.Owner:KeyDown(IN_RELOAD) and self.Owner:KeyPressed(IN_SPEED) then
		self.Owner:SetNWBool("DukesAreUp", false)
	end
	
	if self.Owner:KeyDown(IN_SPEED) and not (self.Weapon:GetNWBool("Reloading")) then		-- If you are running
	self.Weapon:SetNextPrimaryFire(CurTime()+0.3)				-- Make it so you can't shoot for another quarter second
	self.IronSightsPos = self.RunSightsPos					-- Hold it down
	self.IronSightsAng = self.RunSightsAng					-- Hold it down
	self:SetIronsights(true, self.Owner)					-- Set the ironsight true
	self.Owner:SetFOV( 0, 0.3 )
	end								

	if self.Owner:KeyReleased (IN_SPEED) then	-- If you release run then
	self:SetIronsights(false, self.Owner)					-- Set the ironsight true
	self.Owner:SetFOV( 0, 0.3 )
	end								-- Shoulder the gun
	
	if !self.Owner:KeyDown(IN_USE) and !self.Owner:KeyDown(IN_SPEED) then
	-- If the key E (Use Key) is not pressed, then

		if self.Owner:KeyPressed(IN_RELOAD) then 
			self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
			self.IronSightsPos = self.SightsPos					-- Bring it up
			self.IronSightsAng = self.SightsAng					-- Bring it up
			self:SetIronsights(true, self.Owner)
			self.Owner:SetNWBool("DukesAreUp", true)
			-- Set the ironsight true

			if CLIENT then return end
 		end
	end

	if self.Owner:KeyReleased(IN_RELOAD) and !self.Owner:KeyDown(IN_USE) and !self.Owner:KeyDown(IN_SPEED) then
	-- If the right click is released, then
		self.Owner:SetFOV( 0, 0.3 )
		self:SetIronsights(false, self.Owner)
		self.Owner:SetNWBool("DukesAreUp", false)
		-- Set the ironsight false

		if CLIENT then return end
	end
	
end



if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end