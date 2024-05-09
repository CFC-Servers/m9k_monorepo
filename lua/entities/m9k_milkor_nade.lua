AddCSLuaFile()

ENT.Type              = "anim"
ENT.Base              = "m9k_launched_projectile_base"
ENT.PrintName         = "Milkor MGL Grenade"

ENT.FlightDrop = ( 75 * 52.5 ) / 66

ENT.ExplosionEffectScale = 1.1
ENT.ExplosionEffectMagnitude = 12

ENT.ExplosionRadius = 175
ENT.ExplosionDamage = 200

if SERVER then
    function ENT:GetFlightRand()
        return Vector( math.Rand( -0.1, 0.1 ), math.Rand( -0.1, 0.1 ), math.Rand( -0.1, 0.1 ) ) + Vector( 0, 0, -0.035 )
    end
end
