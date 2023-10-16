-- Variables that are used on both client and server
SWEP.Gun = ("m9k_contender") -- must be the name of your swep but NO CAPITALS!
if (GetConVar(SWEP.Gun.."_allowed")) != nil then
	if not (GetConVar(SWEP.Gun.."_allowed"):GetBool()) then SWEP.Base = "bobs_blacklisted" SWEP.PrintName = SWEP.Gun return end
end
SWEP.Category				= "M9K Sniper Rifles"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment			= "2" 	-- Should be "2" for CSS models or "1" for hl2 models
SWEP.PrintName				= "Thompson Contender G2"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 3				-- Slot in the weapon selection menu
SWEP.SlotPos				= 40			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- Set false if you want no crosshair from hip
SWEP.XHair					= false		-- Used for returning crosshair after scope. Must be the same as DrawCrosshair
SWEP.Weight				= 50			-- Rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.BoltAction				= true		-- Is this a bolt action rifle?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/v_contender2.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_g2_contender.mdl"	-- Weapon world model
SWEP.Base 				= "bobs_scoped_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.Primary.Sound			= Sound("contender_g2.Single")		-- script that calls the primary fire sound
SWEP.Primary.RPM				= 35		-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip			= 60	-- Bullets you start with
SWEP.Primary.KickUp				= 1				-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 1			-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 1		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false		-- Automatic/Semi Auto
SWEP.Primary.Ammo			= "ar2"	-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
-- Pistol, buckshot, and slam always ricochet. Use AirboatGun for a light metal peircing shotgun pellets

SWEP.Secondary.ScopeZoom			= 9	
SWEP.Secondary.UseACOG			= false -- Choose one scope type
SWEP.Secondary.UseMilDot		= true	-- I mean it, only one	
SWEP.Secondary.UseSVD			= false	-- If you choose more than one, your scope will not show up at all
SWEP.Secondary.UseParabolic		= false	
SWEP.Secondary.UseElcan			= false
SWEP.Secondary.UseGreenDuplex	= false	
SWEP.Secondary.UseAimpoint		= false
SWEP.Secondary.UseMatador		= false

SWEP.data 				= {}
SWEP.data.ironsights		= 1
SWEP.ScopeScale 			= 0.7
SWEP.ReticleScale 			= 0.6

SWEP.Primary.NumShots	= 1		--how many bullets to shoot per trigger pull
SWEP.Primary.Damage		= 85	--base damage per bullet
SWEP.Primary.Spread		= .01	--define from-the-hip accuracy 1 is terrible, .0001 is exact)
SWEP.Primary.IronAccuracy = .00015 -- ironsight accuracy, should be the same for shotguns

-- enter iron sight info and bone mod info below

SWEP.IronSightsPos = Vector(-3, -0.857, 0.36)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.SightsPos = Vector(-3, -0.857, 0.36)
SWEP.SightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(3.714, -1.429, 0)
SWEP.RunSightsAng = Vector(-11, 31, 0)

if (gmod.GetGamemode().Name == "Murderthon 9000") then

	SWEP.Slot		= 1				-- Slot in the weapon selection menu
	SWEP.Weight		= 3			-- rank relative ot other weapons. bigger is better

end

function SWEP:PrimaryAttack()
	if self.Owner:IsNPC() then return end
	if self:CanPrimaryAttack() and !self.Owner:KeyDown(IN_SPEED) then
		self:ShootBulletInformation()
		self.Weapon:EmitSound(self.Primary.Sound)
		self.Weapon:TakePrimaryAmmo(1)
		self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		local fx 		= EffectData()
		fx:SetEntity(self.Weapon)
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:GetAimVector())
		fx:SetAttachment(self.MuzzleAttachment)
		util.Effect("rg_muzzle_rifle",fx)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self.Owner:MuzzleFlash()
		self.Weapon:SetNextPrimaryFire(CurTime()+10)
		self.RicochetCoin = (math.random(1,4))
		self:UseBolt()
	end
end

function SWEP:UseBolt()

	if self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() ) > 0 then
		timer.Simple(.25, function() 
		if SERVER and self.Weapon != nil then 
			self.Weapon:SetNWBool("Reloading", true)
			if self.Weapon:GetClass() == self.Gun and self.BoltAction then
				self.Owner:SetFOV( 0, 0.3 )
				self:SetIronsights(false)
				self.Owner:DrawViewModel(true)
				local boltactiontime = (self.Owner:GetViewModel():SequenceDuration())
				timer.Simple(boltactiontime, 
					function() if self.Weapon and self.Owner then if IsValid(self.Weapon) and IsValid(self.Owner) then 
					self.Weapon:SetNWBool("Reloading", false)
					if SERVER and self.Weapon != nil then
						if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then 
							self.Owner:SetFOV( 75/self.Secondary.ScopeZoom, 0.15 )                      		
							self.IronSightsPos = self.SightsPos					-- Bring it up
							self.IronSightsAng = self.SightsAng					-- Bring it up
							self.DrawCrosshair = false
							self:SetIronsights(true, self.Owner)
							self.Owner:DrawViewModel(false)
						
							self.Owner:RemoveAmmo(1, self.Primary.Ammo, false) -- out of the frying pan
							self.Weapon:SetClip1(self.Weapon:Clip1() + 1) --  into the fire
							self.Weapon:SetNextPrimaryFire(CurTime() + .1)
						--well, hope this works
						elseif !self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then
							self.Owner:RemoveAmmo(1, self.Primary.Ammo, false) -- out of the frying pan
							self.Weapon:SetClip1(self.Weapon:Clip1() + 1) --  into the fire
							self.Weapon:SetNextPrimaryFire(CurTime() + .1)
						end
					end 
				end end end)
			-- else if self.Weapon:GetClass() == self.Gun and 
				-- self.BoltAction and	(self:GetIronsights() == false) then
					
			end
		end 
		end )
	else
		timer.Simple(.1, function() self:CheckWeaponsAndAmmo() end)
	end

end	

function SWEP:Reload()


//	self.Weapon:DefaultReload(ACT_VM_RELOAD)

		if not IsValid(self) then return end 
		if not IsValid(self.Owner) then return end
		if not IsValid(self.Weapon) then return end
		
		if  self.Weapon:GetNextPrimaryFire() > (CurTime() + 1) then 
			return 
		else
		   
			if self.Owner:IsNPC() then
					self.Weapon:DefaultReload(ACT_VM_RELOAD)
			return end
		   
			if self.Owner:KeyDown(IN_USE) then return end
		   
			if self.Silenced then
					self.Weapon:DefaultReload(ACT_VM_RELOAD_SILENCED)
			else
					self.Weapon:DefaultReload(ACT_VM_RELOAD)
			end
		   
			if !self.Owner:IsNPC() then
					if self.Owner:GetViewModel() == nil then self.ResetSights = CurTime() + 3 else
					self.ResetSights = CurTime() + self.Owner:GetViewModel():SequenceDuration()
					end
			end
		   
			if SERVER and self.Weapon != nil then
			if ( self.Weapon:Clip1() < self.Primary.ClipSize ) and !self.Owner:IsNPC() then
			-- //When the current clip < full clip and the rest of your ammo > 0, then
					self.Owner:SetFOV( 0, 0.3 )
					-- //Zoom = 0
					self:SetIronsights(false)
					-- //Set the ironsight to false
					self.Weapon:SetNWBool("Reloading", true)
			end
			local waitdammit = (self.Owner:GetViewModel():SequenceDuration())
			timer.Simple(waitdammit + .1,
					function()
					if self.Weapon == nil then return end
					self.Weapon:SetNWBool("Reloading", false)
					if self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:GetClass() == self.Gun then
							if CLIENT then return end
							if self.Scoped == false then
									self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
									self.IronSightsPos = self.SightsPos                                     -- Bring it up
									self.IronSightsAng = self.SightsAng                                     -- Bring it up
									self:SetIronsights(true, self.Owner)
									self.DrawCrosshair = false
							else return end
					elseif self.Owner:KeyDown(IN_SPEED) and self.Weapon:GetClass() == self.Gun then
							if self.Weapon:GetNextPrimaryFire() <= (CurTime() + .03) then
									self.Weapon:SetNextPrimaryFire(CurTime()+0.3)                   -- Make it so you can't shoot for another quarter second
							end
							self.IronSightsPos = self.RunSightsPos                                  -- Hold it down
							self.IronSightsAng = self.RunSightsAng                                  -- Hold it down
							self:SetIronsights(true, self.Owner)                                    -- Set the ironsight true
							self.Owner:SetFOV( 0, 0.3 )
					else return end
					end)
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