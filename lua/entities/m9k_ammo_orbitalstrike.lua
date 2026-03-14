AddCSLuaFile()

ENT.Base = "m9k_ammo_base"
ENT.PrintName = "Orbital Strike ammo"
ENT.Category = "M9K Ammunition"
ENT.IconOverride = "entities/m9k_orbital_strike.png"
ENT.Spawnable = true

if SERVER then
    ENT.Model = "models/items/item_item_crate.mdl"
    ENT.AmmoGiveWeapon = "m9k_orbital_strike"
    ENT.AmmoType = "SatCannon"
    ENT.AmmoCount = 1

    function ENT:OnTakeDamage( dmg )
        self:TakePhysicsDamage( dmg )
    end
end
