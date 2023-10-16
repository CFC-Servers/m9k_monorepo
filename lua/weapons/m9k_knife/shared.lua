-- Variables that are used on both client and server
SWEP.Gun = ("m9k_knife") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Specialties"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ("Left click to slash".."\n".."Right click to stab.")
SWEP.PrintName				= "Knife"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 24			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= true		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "knife"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_knife_x.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_extreme_ratio.mdl"	-- Weapon world model
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

SWEP.Secondary.IronFOV			= 55		-- How much you 'zoom' in. Less is more! 	

SWEP.data 				= {}				--The starting firemode
SWEP.data.ironsights			= 1

SWEP.Primary.Damage		= 30	-- Base damage per bullet
SWEP.Primary.Spread		= .02	-- Define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .01 -- Ironsight accuracy, should be the same for shotguns

//Enter iron sight info and bone mod info below
-- SWEP.IronSightsPos = Vector(-2.652, 0.187, -0.003)
-- SWEP.IronSightsAng = Vector(2.565, 0.034, 0) 		//not for the knife
-- SWEP.SightsPos = Vector(-2.652, 0.187, -0.003)		//just lower it when running
-- SWEP.SightsAng = Vector(2.565, 0.034, 0)
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-25.577, 0, 0)

SWEP.Slash = 1

-- SWEP.Primary.Sound	= Sound("Weapon_Knife.Slash") //woosh
-- SWEP.KnifeShink = ("Weapon_Knife.HitWall")
-- SWEP.KnifeSlash = ("Weapon_Knife.Hit")
-- SWEP.KnifeStab = ("Weapon_Knife.Stab")

SWEP.Primary.Sound	= Sound("weapons/blades/woosh.mp3") //woosh
SWEP.KnifeShink = Sound("weapons/blades/hitwall.mp3")
SWEP.KnifeSlash = Sound("weapons/blades/slash.mp3")
SWEP.KnifeStab = Sound("weapons/blades/nastystab.mp3")

function SWEP:Deploy()
	self:SetHoldType(self.HoldType)
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:EmitSound("weapons/knife/knife_draw_x.mp3", 50, 100)
	return true
end

function SWEP:PrimaryAttack()
	vm = self.Owner:GetViewModel()
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			if self.Slash == 1 then
				vm:SetSequence(vm:LookupSequence("midslash1"))
				self.Slash = 2
			else
				vm:SetSequence(vm:LookupSequence("midslash2"))
				self.Slash = 1
			end --if it looks stupid but works, it aint stupid!
			self.Weapon:EmitSound(self.Primary.Sound)//slash in the wind sound here
			if CLIENT then return end
			timer.Create("cssslash", .15, 1, function() 
			if not IsValid(self) then return end
			if IsValid(self.Owner) 
			
			and IsValid(self.Weapon) 
			
			then self:PrimarySlash() end end)

			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
		end
	end
end

function SWEP:PrimarySlash()

	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	damagedice = math.Rand(.85,1.25)
	pain = self.Primary.Damage * damagedice
	self.Owner:LagCompensation(true)
	if IsValid(self.Owner) and IsValid(self.Weapon) then
		if self.Owner:Alive() then if self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			local slash = {}
			slash.start = pos
			slash.endpos = pos + (ang * 32)
			slash.filter = self.Owner
			slash.mins = Vector(-10, -5, 0)
			slash.maxs = Vector(10, 5, 5)
			local slashtrace = util.TraceHull(slash)
			if slashtrace.Hit then
				targ = slashtrace.Entity
				if targ:IsPlayer() or targ:IsNPC() then
					//find a way to splash a little blood
					self.Weapon:EmitSound(self.KnifeSlash)//stab noise
					paininfo = DamageInfo()
					paininfo:SetDamage(pain)
					paininfo:SetDamageType(DMG_SLASH)
					paininfo:SetAttacker(self.Owner)
					paininfo:SetInflictor(self.Weapon)
					paininfo:SetDamageForce(slashtrace.Normal *35000)
					if SERVER then targ:TakeDamageInfo(paininfo) end
				else
					self.Weapon:EmitSound(self.KnifeShink)//SHINK!
					look = self.Owner:GetEyeTrace()
					util.Decal("ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
				end
			end
		end end
	end
	self.Owner:LagCompensation(false)
end


function SWEP:SecondaryAttack()
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()
	vm = self.Owner:GetViewModel()
	if self:CanPrimaryAttack() and self.Owner:IsPlayer() then
	self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		if !self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_RELOAD) then
			local stab = {}
			stab.start = pos
			stab.endpos = pos + (ang * 24)
			stab.filter = self.Owner
			stab.mins = Vector(-10,-5, 0)
			stab.maxs = Vector(10, 5, 5)
			local stabtrace = util.TraceHull(stab)
			if stabtrace.Hit then
				vm:SetSequence(vm:LookupSequence("stab"))
			else
				vm:SetSequence(vm:LookupSequence("stab_miss"))
			end
			
			timer.Create("cssstab", .33, 1 , function() if not IsValid(self) then return end
			if IsValid(self.Owner) and IsValid(self.Weapon) then 
				if self.Owner:Alive() and self.Owner:GetActiveWeapon():GetClass() == self.Gun then 
					self:Stab() end
				end
			end)

			self.Owner:SetAnimation( PLAYER_ATTACK1 )
			self.Weapon:SetNextPrimaryFire(CurTime()+1/(self.Primary.RPM/60))
			self.Weapon:SetNextSecondaryFire(CurTime()+1.25)
		end
	end
end

function SWEP:Stab()

	pos2 = self.Owner:GetShootPos()
	ang2 = self.Owner:GetAimVector()
	damagedice = math.Rand(.85,1.25)
	pain = 100 * damagedice
	self.Owner:LagCompensation(true)
	local stab2 = {}
	stab2.start = pos2
	stab2.endpos = pos2 + (ang2 * 24)
	stab2.filter = self.Owner
	stab2.mins = Vector(-10,-5, 0)
	stab2.maxs = Vector(10, 5, 5)
	local stabtrace2 =  util.TraceHull(stab2)

	if IsValid(self.Owner) and IsValid(self.Weapon) then
		if self.Owner:Alive() then if self.Owner:GetActiveWeapon():GetClass() == self.Gun then
			if stabtrace2.Hit then
			targ = stabtrace2.Entity
				if targ:IsPlayer() or targ:IsNPC() then
					paininfo = DamageInfo()
					paininfo:SetDamage(pain)
					paininfo:SetDamageType(DMG_SLASH)
					paininfo:SetAttacker(self.Owner)
					paininfo:SetInflictor(self.Weapon)
					paininfo:SetDamageForce(stabtrace2.Normal *75000)
					if SERVER then targ:TakeDamageInfo(paininfo) end
					self.Weapon:EmitSound(self.KnifeStab)//stab noise
				else
					self.Weapon:EmitSound(self.KnifeShink)//SHINK!
					look = self.Owner:GetEyeTrace()
					util.Decal("ManhackCut", look.HitPos + look.HitNormal, look.HitPos - look.HitNormal )
				end
			else
				self.Weapon:EmitSound(self.Primary.Sound)
			end
		end end
	end
	self.Owner:LagCompensation(false)
end


function SWEP:IronSight()

	if !self.Owner:IsNPC() then
	if self.ResetSights and CurTime() >= self.ResetSights then
	self.ResetSights = nil
	self:SendWeaponAnim(ACT_VM_IDLE)
	end end
	
	
	
	if self.Owner:KeyPressed(IN_RELOAD) then
		if !self.Owner:KeyDown(IN_ATTACK) and !self.Owner:KeyDown(IN_ATTACK2) and !self.Owner:KeyDown(IN_SPEED) then
			self:ThrowKnife()
			self.Weapon:NextThink(CurTime() + 1)
			return true
		end
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
	
end

function SWEP:Reload()
end


function SWEP:ThrowKnife()
	if IsFirstTimePredicted() then
		self.Weapon:EmitSound(self.Primary.Sound)
		if (SERVER) then
			local knife = ents.Create("m9k_thrown_spec_knife")
			if IsValid(knife) then
				knife:SetAngles(self.Owner:EyeAngles())
				knife:SetPos(self.Owner:GetShootPos())
				knife:SetOwner(self.Owner)
				knife:SetPhysicsAttacker(self.Owner)
				knife:Spawn()
				knife:Activate()
				knife:SetNWString("WeaponToGive", self.Gun)
				self.Owner:SetAnimation(PLAYER_ATTACK1)
				local phys = knife:GetPhysicsObject()
				phys:SetVelocity(self.Owner:GetAimVector() * 1500)
				phys:AddAngleVelocity(Vector(0, 500, 0))
				self.Owner:StripWeapon(self.Gun)
				
			end
		end
	end
end




if GetConVar("M9KUniqueSlots") != nil then
	if not (GetConVar("M9KUniqueSlots"):GetBool()) then 
		SWEP.SlotPos = 2
	end
end