AddCSLuaFile()

ENT.Type              = "anim"
ENT.Base              = "m9k_launched_projectile_base"
ENT.PrintName         = "Milkor MGL Grenade"

ENT.FlightDrop = 75 * 52.5

ENT.ExplosionEffectScale = 1.1
ENT.ExplosionEffectMagnitude = 12

ENT.ExplosionRadius = 175
ENT.ExplosionDamage = 200

ENT.FlightJitterHorizontal = 0.1
ENT.FlightJitterVertical = 0.1
ENT.FlightGravity = 0.035

if SERVER then
    function ENT:GetFlightRand()
        return Vector( math.Rand( -self.FlightJitterHorizontal, self.FlightJitterHorizontal ), math.Rand( -self.FlightJitterHorizontal, self.FlightJitterHorizontal ), math.Rand( -self.FlightJitterVertical, self.FlightJitterVertical ) ) + Vector( 0, 0, -self.FlightGravity )
    end
end
