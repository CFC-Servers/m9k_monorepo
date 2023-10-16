/*------------------------------------------------------

If you're reading this, then that mean's you've extracted this addon, probably with intentions 
of editing it for your own needs, or that you're using a legacy addon.

I have no problem with that, but you must understand that I cannot offer support for legacy addons.
If you've extracted this addon, I cannot offer any help fixing problems that come up. It's impossible
to know what you've changed, and thus impossible to know what to fix.

"But Bob!" you might say. "I only changed one thing!" 

Well, that's a shame. Everybody is going to say this, and I know that some of those people will be
lying to me. The only thing I can do is to refuse support to everyone using legacy addons.

So, by using a legacy addon, you accept the fact that I cannot help fix anything that might be broken.

I know it's tough love, but that's the way it's got to be.

------------------------------------------------------*/
local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then
	killicon.Add( "m9k_1887winchester", "vgui/hud/m9k_1887winchester", icol  )
	killicon.Add( "m9k_1897winchester", "vgui/hud/m9k_1897winchester", icol  )
	killicon.Add( "m9k_ares_shrike", "vgui/hud/m9k_ares_shrike", icol  )
	killicon.Add( "m9k_aw50", "vgui/hud/m9k_aw50", icol  )
	killicon.Add( "m9k_barret_m82", "vgui/hud/m9k_barret_m82", icol  )
	killicon.Add( "m9k_browningauto5", "vgui/hud/m9k_browningauto5", icol  )
	killicon.Add( "m9k_contender", "vgui/hud/m9k_contender", icol  )
	killicon.Add( "m9k_dbarrel", "vgui/hud/m9k_dbarrel", icol  )
	killicon.Add( "m9k_dragunov", "vgui/hud/m9k_dragunov", icol  )
	killicon.Add( "m9k_fg42", "vgui/hud/m9k_fg42", icol  )
	killicon.Add( "m9k_intervention", "vgui/hud/m9k_intervention", icol  )
	killicon.Add( "m9k_ithacam37", "vgui/hud/m9k_ithacam37", icol  )
	killicon.Add( "m9k_jackhammer", "vgui/hud/m9k_jackhammer", icol  )
	killicon.Add( "m9k_m3", "vgui/hud/m9k_m3", icol  )
	killicon.Add( "m9k_m24", "vgui/hud/m9k_m24", icol  )
	killicon.Add( "m9k_m60", "vgui/hud/m9k_m60", icol  )
	killicon.Add( "m9k_m98b", "vgui/hud/m9k_m98b", icol  )
	killicon.Add( "m9k_m249lmg", "vgui/hud/m9k_m249lmg", icol  )
	killicon.Add( "m9k_m1918bar", "vgui/hud/m9k_m1918bar", icol  )
	killicon.Add( "m9k_minigun", "vgui/hud/m9k_minigun", icol  )
	killicon.Add( "m9k_mossberg590", "vgui/hud/m9k_mossberg590", icol  )
	killicon.Add( "m9k_psg1", "vgui/hud/m9k_psg1", icol  )
	killicon.Add( "m9k_remington870", "vgui/hud/m9k_remington870", icol  )
	killicon.Add( "m9k_remington7615p", "vgui/hud/m9k_remington7615p", icol  )
	killicon.Add( "m9k_sl8", "vgui/hud/m9k_sl8", icol  )
	killicon.Add( "m9k_svu", "vgui/hud/m9k_svu", icol  )
	killicon.Add( "m9k_usas", "vgui/hud/m9k_usas", icol  )
	killicon.Add( "m9k_spas12", "vgui/hud/m9k_spas12", icol  )
	killicon.Add( "m9k_svt40", "vgui/hud/m9k_svt40", icol  )
	killicon.Add( "m9k_striker12", "vgui/hud/m9k_striker12", icol  )
	killicon.Add( "m9k_pkm", "vgui/hud/m9k_pkm", icol  )

end

--I'm pretty sure we don't need these anymore...
--Almost 99 percent sure that's I'm 100 percent sure...
	
-- if GetConVar("M9KDisableHolster") == nil then
	-- CreateConVar("M9KDisableHolster", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable my totally worthless and broken holster system? Won't hurt my feelings any. 1 for true, 2 for false. A map change may be required.")
	-- print("Holster Disable con var created")
-- end

if GetConVar("DebugM9K") == nil then
	CreateConVar("DebugM9K", "0", { FCVAR_REPLICATED, FCVAR_ARCHIVE }, "Debugging for some m9k stuff, turning it on won't change much.")
end

if GetConVar("M9KWeaponStrip") == nil then
	CreateConVar("M9KWeaponStrip", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Allow empty weapon stripping? 1 for true, 0 for false")
	print("Weapon Strip con var created")
end
	
if GetConVar("M9KDisablePenetration") == nil then
	CreateConVar("M9KDisablePenetration", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Disable Penetration and Ricochets? 1 for true, 0 for false")
	print("Penetration/ricochet con var created")
end
	
if GetConVar("M9KDynamicRecoil") == nil then
	CreateConVar("M9KDynamicRecoil", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use Aim-modifying recoil? 1 for true, 0 for false")
	print("Recoil con var created")
end
	
if GetConVar("M9KAmmoDetonation") == nil then
	CreateConVar("M9KAmmoDetonation", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Enable detonatable M9K Ammo crates? 1 for true, 0 for false.")
	print("Ammo crate detonation con var created")
end

if GetConVar("M9KDamageMultiplier") == nil then
	CreateConVar("M9KDamageMultiplier", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Multiplier for M9K bullet damage.")
	print("Damage Multiplier con var created")
end

if GetConVar("M9KDefaultClip") == nil then
	CreateConVar("M9KDefaultClip", "-1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "How many clips will a weapon spawn with? Negative reverts to default values.")
	print("Default Clip con var created")
end
	
if GetConVar("M9KUniqueSlots") == nil then
	CreateConVar("M9KUniqueSlots", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Give M9K Weapons unique slots? 1 for true, 2 for false. A map change may be required.")
	print("Unique Slots con var created")
end
	
if !game.SinglePlayer() then

	if GetConVar("M9KClientGasDisable") == nil then
		CreateConVar("M9KClientGasDisable", "0", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Turn off gas effect for all clients? 1 for yes, 0 for no. ")
	end
	
	if SERVER then
	
		function ClientSideGasDisabler()
			timer.Create("ClientGasBroadcastTimer", 15, 0, 
				function() BroadcastLua("RunConsoleCommand(\"M9KGasEffect\", \"0\")") end )
		end
	
		if GetConVar("M9KClientGasDisable"):GetBool() then
			ClientSideGasDisabler()
		end

		function M9K_Svr_Gas_Change_Callback(cvar, previous, new)
			if tobool(new) == true then
				ClientSideGasDisabler()
				BroadcastLua("print(\"Gas effects disabled on this server!\")")
			elseif tobool(new) == false then
				BroadcastLua("print(\"Gas effects re-enabled on this server.\")")
				BroadcastLua("print(\"You may turn on M9KGasEffect if you wish.\")")
				if timer.Exists("ClientGasBroadcastTimer") then
					timer.Destroy("ClientGasBroadcastTimer")
				end
			end				
		end
		cvars.AddChangeCallback("M9KClientGasDisable", M9K_Svr_Gas_Change_Callback)
	
	end
	
	if CLIENT then
		if GetConVar("M9KGasEffect") == nil then
			CreateClientConVar("M9KGasEffect", "1", true, true)
			print("Client-side Gas Effect Con Var created")
		end		
	end

else
	if GetConVar("M9KGasEffect") == nil then
		CreateConVar("M9KGasEffect", "1", { FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE }, "Use gas effect when shooting? 1 for true, 0 for false")
		print("Gas effect con var created")
	end
end

//PKM
sound.Add({
	name = 			"pkm.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		{"weapons/pkm/pkm-1.wav",
					"weapons/pkm/pkm-2.wav",
					"weapons/pkm/pkm-3.wav",
					"weapons/pkm/pkm-4.wav",
					"weapons/pkm/pkm-5.wav"}
})

sound.Add({
	name = 			"Weapon_PKM.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_cloth.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Coverup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_coverup.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Bullet",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_bullet.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Boxout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_boxout.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Boxin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_boxin.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Chain",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_chain.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Coverdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_coverdown.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Coversmack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_coversmack.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_bolt.mp3"
})

sound.Add({
	name = 			"Weapon_PKM.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/pkm/pkm_draw.mp3"
})

//SVT40
sound.Add({
	name = 			"Weapon_SVT40.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1-1.wav"
})

sound.Add({
	name = 			"Weapon_SVT40.Cloth1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_cloth1.mp3"
})

sound.Add({
	name = 			"Weapon_SVT40.Cloth2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_cloth2.mp3"
})

sound.Add({
	name = 			"Weapon_SVT40.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_SVT40.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_clipin.mp3"
})

sound.Add({
	name = 			"Weapon_SVT40.ClipTap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_cliptap.mp3"
})

sound.Add({
	name = 			"Weapon_SVT40.SlideBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_slide_b.mp3"
})

sound.Add({
	name = 			"Weapon_SVT40.SlideForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svt40/g3sg1_slide_f.mp3"
})

//spas12
sound.Add({
	name = 			"spas_12_shoty.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/spas_12/xm1014-1.wav"
})

sound.Add({
	name = 			"spas_12_shoty.insert",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/spas_12/xm_insert.mp3"
})

sound.Add({
	name = 			"spas_12_shoty.cock",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/spas_12/xm_cock.mp3"
})

//USAS
sound.Add({
	name = 			"Weapon_usas.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/usas12/xm1014-1.wav"
})

sound.Add({
	name = 			"Weapon_usas.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usas12/magin.mp3"
})

sound.Add({
	name = 			"Weapon_usas.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usas12/magout.mp3"
})

sound.Add({
	name = 			"Weapon_usas.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/usas12/draw.mp3"
})


//remington 7615P
sound.Add({
	name = 			"7615p_remington.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/7615p/scout_fire-1.wav" 
})
  
  sound.Add({
	name = 			"7615p_bob.pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/7615p/m3_pump.mp3" 
})


sound.Add({
	name = 			"Weapon_7615P.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/7615p/sg550_clipout.mp3" 
})


sound.Add({
	name = 			"Weapon_7615P.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/7615p/sg550_clipin.mp3" 
})


// Dragunov SVU
  sound.Add({
	name = 			"Weapon_SVU.Single",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svu/g3sg1-1.wav"
})
  
    sound.Add({
	name = 			"Weapon_svuxx.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svu/g3sg1_clipin.mp3"
})

  sound.Add({
	name = 			"Weapon_svuxx.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svu/g3sg1_clipout.mp3"
})

  sound.Add({
	name = 			"Weapon_svuxx.Slide",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/svu/g3sg1_slide.mp3"
})


//Winchester model 94
  sound.Add({
	name = 			"Weapon_Win94.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/win94/scout_fire-1.wav"
})

sound.Add({
	name = 			"Weapon_Win94.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/win94/scout_bolt.mp3"
})

sound.Add({
	name = 			"weapons/hamburgpling.wav",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/win94/hamburgpling.mp3"
})

sound.Add({
	name = 			"Weapon_Win94.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/win94/scout_clipout.mp3"
})

//Striker 12
sound.Add({
	name = 			"ShotStriker12.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/striker12/xm1014-1.wav"
})

sound.Add({
	name = 			"ShotStriker12.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/striker12/deploy.mp3"
})

sound.Add({
	name = 			"ShotStriker12.InsertShell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/striker12/m3_insertshell.mp3"
})

//AW50
sound.Add({
	name =			"Weaponaw50.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1.0,
	sound =			"weapons/aw50/awp_fire.wav"
})

sound.Add({
	name =			"Weaponaw50.clipin",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/awp_magin.mp3"
})

sound.Add({
	name =			"Weaponaw50.clipout",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/awp_magout.mp3"
})
	
sound.Add({
	name =			"Weaponaw50.boltback",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/m24_boltback.mp3"
})

sound.Add({
	name =			"Weaponaw50.boltforward",
	channel =		CHAN_ITEM,
	volume =		1.0,
	sound =			"weapons/aw50/m24_boltforward.mp3"
})

//PSG-1

sound.Add({
	name =			"Weapon_psg_1.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1,
	sound =			"weapons/psg1/g3sg1-1.wav" 
})


sound.Add({
	name =			"Weapon_psg_1.Back",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/psg1/psg_boltpull.mp3" 
})

sound.Add({
	name =			"Weapon_psg_1.Clipout",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/psg1/psg_clipout.mp3" 
})

sound.Add({
	name =			"Weapon_psg_1.Clipin",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/psg1/psg_clipin.mp3" 
})

sound.Add({
	name =			"Weapon_psg_1.Forward",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/psg1/psg_boltrelease.mp3" 

})

sound.Add({
	name =			"Weapon_psg_1.Deploy",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/psg1/deploy1.mp3" 
})

//contender
sound.Add({
	name =			"contender_g2.Single",
	channel =		CHAN_USER_BASE+10,
	volumel =		1.0,
	sound = 		{"weapons/g2contender/scout-1.wav",
					"weapons/g2contender/scout-2.wav",
					"weapons/g2contender/scout-3.wav"}
})

sound.Add({
	name =			"contender_g2.Draw",
	channel =		CHAN_ITEM,
	volumel =		1.0,
	sound =			"weapons/g2contender/Draw.mp3"
})


sound.Add({
	name =			"contender_g2.Hammer",
	channel =		CHAN_USER_BASE+1,
	volumel =		1.0,
	sound =			{"weapons/g2contender/Cock-1.mp3",
					"weapons/g2contender/Cock-2.mp3"}
})


sound.Add({
	name =			"contender_g2.Open",
	channel =		CHAN_ITEM,
	volumel =		1.0,
	sound =			"weapons/g2contender/open_chamber.mp3"
})


sound.Add({
	name =			"contender_g2.Shellout",
	channel =		CHAN_USER_BASE+1,
	volumel =		1.0,
	sound =			"weapons/g2contender/Bullet_out.mp3"
})


sound.Add({
	name =			"contender_g2.Shellin",
	channel =		CHAN_ITEM,
	volumel =		1.0,
	sound =			"weapons/g2contender/Bullet_in.mp3"
})


sound.Add({
	name =			"contender_g2.Close",
	channel =		CHAN_ITEM,
	volumel =		1.0,
	sound =			"weapons/g2contender/close_chamber.mp3"
})


sound.Add({
	name =			"contender_g2.Shell",
	channel =		CHAN_USER_BASE+2,
	volumel =		1.0,
	sound =			{"weapons/g2contender/pl_shell1.mp3",
					"weapons/g2contender/pl_shell2.mp3",
					"weapons/g2contender/pl_shell3.mp3",
					"weapons/g2contender/pl_shell4.mp3"}
})
//Barret M98B
sound.Add({

	name = 		"M98.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/M98/shot-1.wav"
})

sound.Add({
	name = 		"M98_Bolt",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/bolt.mp3"
})


sound.Add({
	name = 		"M98_Handle",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/handle.mp3"
})

sound.Add({
	name = 		"M98_Deploy",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/draw.mp3"
})

sound.Add({
	name = 		"M98_Draw",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/draw_2.mp3"
})

sound.Add({
	name = 		"M98_Foley",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/foley.mp3"
})

sound.Add({
	name = 		"M98_Clipout",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/clipout.mp3"
})

sound.Add({
	name = 		"M98_Clipin",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/clipin.mp3"
})

sound.Add({
	name = 		"M98_Boltback",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/boltback.mp3"
})

sound.Add({
	name = 		"M98_Boltforward",
channel = 	CHAN_ITEM,
volume = 	1.0,
sound = 	"weapons/M98/boltforward.mp3"
})

//barret m82 50 cal
sound.Add({
	name = 			"BarretM82.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/M82/barret50-1.wav"
})


sound.Add({
	name = 			"Weapon_M82.Boltup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M82/boltup.mp3"
})

sound.Add({
	name = 			"Weapon_M82.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M82/clipin.mp3"
})

sound.Add({
	name = 			"Weapon_M82.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M82/clipout.mp3"
})

sound.Add({
	name = 			"Weapon_M82.Boltdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/M82/boltdown.mp3"
})

//m24
sound.Add({
	name = 			"Dmgfok_M24SN.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/dmg_m24/awp1.wav"
})

sound.Add({
	name = 			"Dmgfok_M24SN.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_m24/m24_magin.mp3"
})

sound.Add({
	name = 			"Dmgfok_M24SN.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_m24/m24_magout.mp3"
})

sound.Add({
	name = 			"Dmgfok_M24SN.Boltback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_m24/m24_boltback.mp3"
})

sound.Add({
	name = 			"Dmgfok_M24SN.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dmg_m24/m24_boltforward.mp3"
})

//svd dragunov
sound.Add({
	name = 			"Weapon_svd01.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/SVD/g3sg1-1.wav"
})

sound.Add({
	name = 			"Weapon_SVD.Foley",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/foley.mp3"	
})

sound.Add({
	name = 			"Weapon_SVD.Handle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/handle.mp3"	
})

sound.Add({
	name = 			"Weapon_SVD.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/Clipout.mp3"
})

sound.Add({
	name = 			"Weapon_SVD.Cliptap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/Cliptap.mp3"
	
})

sound.Add({
	name = 			"Weapon_SVD.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/ClipIn.mp3"
	
})

sound.Add({
	name = 			"Weapon_SVD.Slideback",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/SlideBack.mp3"
	
})

sound.Add({
	name = 			"Weapon_SVD.SlideForward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/SlideForward.mp3"	
})

sound.Add({
	name = 			"Weapon_SVD.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/SVD/Draw.mp3"
	
})

//sl8
sound.Add({
	name = 			"Weapon_hksl8.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = {"weapons/hksl8/SG552-1.wav",
			"weapons/hksl8/SG552-2.wav",
			"weapons/hksl8/SG552-3.wav",
			"weapons/hksl8/SG552-4.wav"}
})

sound.Add({
	name = 			"sl8.Draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/draw.mp3"
})

sound.Add({
	name = 			"sl8.Safety",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/safety.mp3"
})

sound.Add({
	name = 			"sl8.Magout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/magout.mp3"
})

sound.Add({
	name = 			"sl8.MagFiddle",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/magfiddle.mp3"
})

sound.Add({
	name = 			"sl8.MagIn",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/magin.mp3"
})

sound.Add({
	name = 			"sl8.BoltBack",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/boltback.mp3"
})

sound.Add({
	name = 			"sl8.Boltforward",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/hksl8/boltforward.mp3"
})


//intervention
sound.Add({
	name = 			"Weapon_INT.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_intrv/int1.wav"
})

sound.Add({
	name = 			"Weapon_INT.Deploy",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_intrv/int_deploy.mp3"
})

sound.Add({
	name = 			"Weapon_INT.Bolt",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_intrv/int_bolt.mp3"
})

sound.Add({
	name = 			"Weapon_INT.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_intrv/int_clipout.mp3"
})

sound.Add({
	name = 			"Weapon_INT.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fokku_tc_intrv/int_clipin.mp3"
})


//winchester 1887
sound.Add({
	name = 			"1887winch.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/1887winchester/1887-1.wav" 
})

sound.Add({
	name = 			"1887winch.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1887winchester/1887_insertshell.mp3" 
})

sound.Add({
	name = 			"1887winch.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1887winchester/1887pump1.mp3" 
})

sound.Add({
	name = 			"1887pump2.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1887winchester/1887pump2.mp3" 
})

//winchester 1897
sound.Add({
	name = 			"Trench_97.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/1897trench/m3-1.wav"
})

sound.Add({
	name = 			"Trench_97.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1897trench/m3_insertshell.mp3"
})

sound.Add({
	name = 			"Trench_97.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1897trench/m3_pump.mp3"
})

sound.Add({
	name = 			"Trench_07.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/1897trench/1897_deploy.mp3"
})

//browning auto 5
sound.Add({
	name = 			"Weapon_a5.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/browninga5/xm1014-1.wav"
})

sound.Add({
	name = 			"Weapon_bauto5.InsertShell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/browninga5/xm1014_insertshell.mp3"
})

sound.Add({
	name = 			"Weapon_a5.back",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/browninga5/xm1014_check.mp3"
})

sound.Add({
	name = 			"Weapon_a5.draw",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/browninga5/xm1014_deploy.mp3"
})

//double barrel shotgun
sound.Add({
	name = 			"Double_Barrel.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/xm1014-1.wav"
})

sound.Add({
	name = 			"dbarrel_dblast",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/dblast.wav"
})

sound.Add({
	name = 			"Double_Barrel.InsertShell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/xm1014_insertshell.mp3"
})

sound.Add({
	name = 			"Double_Barrel.barreldown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/barreldown.mp3"
})

sound.Add({
	name = 			"Double_Barrel.barrelup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/dbarrel/barrelup.mp3"
})

//pancor jackhammer
sound.Add({
	name = 			"Weapon_Jackhammer.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		.65,
	sound = 			"weapons/jackhammer/xm1014-1.wav"
})

sound.Add({
	name = 			"Weapon_Jackhammer.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		.65,
	sound = 			"weapons/jackhammer/clipout.mp3"
})

sound.Add({
	name = 			"Weapon_Jackhammer.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		.65,
	sound = 			"weapons/jackhammer/magtap.mp3"
})

sound.Add({
	name = 			"Weapon_Jackhammer.Forearm",
	channel = 		CHAN_ITEM,
	volume = 		.45,
	sound = 			"weapons/jackhammer/boltcatch.mp3"
})


sound.Add({
	name = 			"Weapon_Jackhammer.Cloth",
	channel = 		CHAN_ITEM,
	volume = 		1,
	sound = 			"weapons/jackhammer/cloth.mp3"
})

//Ithaca M37
sound.Add({
	name =			"IthacaM37.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1,
	sound =			"weapons/m37/m3-1.wav"
})

sound.Add({
	name =			"IthacaM37.Insertshell",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/m37/m3_insertshell.mp3"
})

sound.Add({
	name =			"IthacaM37.Pump",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/m37/m3_pump.mp3"
})

//Mossberg 590
sound.Add({
	name =			"Mberg_590.Single",
	channel =		CHAN_USER_BASE+10,
	volume =		1,
	sound =			"weapons/590/m3-1.wav"
})

sound.Add({
	name =			"Mberg_590.Insertshell",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/590/m3_insertshell.mp3"
})

sound.Add({
	name =			"Mberg_590.Pump",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/590/m3_pump.mp3"
})

sound.Add({
	name =			"Mberg_590.Bullet",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/590/m3_bullet.mp3"
})

sound.Add({
	name =			"Mberg_590.Draw",
	channel =		CHAN_ITEM,
	volume =		1,
	sound =			"weapons/590/m3_draw.mp3"
})

//Ares Shrike
sound.Add({
	name = 			"Weapon_shrk.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/shrike/shrike-1.wav" 
})

sound.Add({
	name = 			"Weapon_shrk.bOut",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/boxout.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.Button",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/button.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.cUp",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/coverup.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.Bullet1",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/bullet.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.bIn",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/boxin.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.Bullet2",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/bullet.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.cDown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/coverdown.mp3" 
})

sound.Add({
	name = 			"Weapon_shrk.Ready",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/shrike/ready.mp3" 
})


//m60
sound.Add({
	name = 			"Weapon_M_60.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		")weapons/m60/m60-1.wav"
})

sound.Add({
	name = 			"Weapon_M_60.Coverup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m60/m60_coverup.mp3"
})

sound.Add({
	name = 			"Weapon_M_60.Boxout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m60/m60_boxout.mp3"
})

sound.Add({
	name = 			"Weapon_M_60.Boxin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m60/m60_boxin.mp3"
})

sound.Add({
	name = 			"Weapon_M_60.Chain",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m60/m60_chain.mp3"
})

sound.Add({
	name = 			"Weapon_M_60.Coverdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/m60/m60_coverdown.mp3"
})

//m249
sound.Add({
	name = 			"Weapon_249M.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/m249-1.wav"
})

sound.Add({
	name = 			"Weapon_249M.Coverdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/m249_coverdown.mp3"
})

sound.Add({
	name = 			"Weapon_249M.Chain",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/m249_chain.mp3"
})

sound.Add({
	name = 			"Weapon_249M.Coverup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/m249_coverup.mp3"
})

sound.Add({
	name = 			"Weapon_249M.Boxout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/m249_boxout.mp3"
})

sound.Add({
	name = 			"Weapon_Flakk249.Magin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/magin.mp3"
})

sound.Add({
	name = 			"Weapon_Flakk249.Boltpull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/boltpull.mp3"
})

sound.Add({
	name = 			"Weapon_Flakk249.Boltrel",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/schmung.M249/boltrel.mp3"
})

//m134 minigun
sound.Add({
	name = 			"BlackVulcan.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 		")weapons/minigun/mini-1.wav"
})

sound.Add({
	name = 			"BlackVulcan.Boxout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 		")weapons/minigun/mini_boxout.mp3"
})


sound.Add({
	name = 			"BlackVulcan.Coverup",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 		")weapons/minigun/mini_coverup.mp3"
})

sound.Add({
	name = 			"BlackVulcan.Boxin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 		")weapons/minigun/mini_boxin.mp3"
})

sound.Add({
	name = 			"BlackVulcan.Chain",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 		")weapons/minigun/mini_chain.mp3"
})

sound.Add({
	name = 			"BlackVulcan.Coverdown",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 		")weapons/minigun/mini_coverdown.mp3"
})

//fg42
sound.Add({
	name = 			"FG42_weapon.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/fg42/ak47-1.wav"
})

sound.Add({
	name = 			"FG42_weapon.Clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fg42/ak47_clipout.mp3"
})

sound.Add({
	name = 			"FG42_weapon.Clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fg42/ak47_clipin.mp3"
})

sound.Add({
	name = 			"FG42_weapon.BoltPull",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/fg42/ak47_boltpull.mp3"
})

//m1918 bar
sound.Add({
	name = 			"Weapon_bar1.clipin",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/jen.ak/mag.in.mp3"
})

sound.Add({
	name = 			"Weapon_bar1.clipout",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/jen.ak/mag.out.mp3"
})

sound.Add({
	name = 			"Weapon_bar1.mag.tap",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/jen.ak/mag.tap.mp3"
})

sound.Add({
	name = 			"Weapon_bar1.boltpull",
	channel = 		CHAN_ITEM,
	volume = 		.7,
	sound = 			"weapons/jen.ak/bolt.pull.mp3"
})

sound.Add({
	name = 			"Weapon_bar1.bolt.rel",
	channel = 		CHAN_ITEM,
	volume = 		.5,
	sound = 			"weapons/jen.ak/bolt.rel.mp3"	
})

sound.Add({
	name = 			"Weapon_bar1.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/jen.ak/fire.wav"
})

sound.Add({
	name = 			"3rd_Weapon_bar1.Single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/jen.ak/fire.wav"	
})

//Tactical 870
sound.Add({
	name = 			"WepRem870.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/tact870/m3-1.wav"
})

sound.Add({
	name = 			"WepRem870.pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tact870/m3_pump.mp3"
})

sound.Add({
	name = 			"WepRem870.Insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/tact870/m3_insertshell.mp3"
})

//Benelli M3
sound.Add({
	name = 			"BenelliM3.single",
	channel = 		CHAN_USER_BASE+10,
	volume = 		1.0,
	sound = 			"weapons/BenelliM3/m3-1.wav"
})

sound.Add({
	name = 			"BenelliM3.insertshell",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/BenelliM3/m3_insertshell.mp3"
})

sound.Add({
	name = 			"BenelliM3.Pump",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/BenelliM3/m3_pump.mp3"
})

m9knpw = {}
table.insert(m9knpw, "m9k_davy_crockett_explo")
table.insert(m9knpw, "m9k_gdcwa_matador_90mm")
table.insert(m9knpw, "m9k_gdcwa_rpg_heat")
table.insert(m9knpw, "m9k_improvised_explosive")
table.insert(m9knpw, "m9k_launched_davycrockett")
table.insert(m9knpw, "m9k_launched_ex41")
table.insert(m9knpw, "m9k_launched_m79")
table.insert(m9knpw, "m9k_m202_rocket")
table.insert(m9knpw, "m9k_mad_c4")
table.insert(m9knpw, "m9k_milkor_nade")
table.insert(m9knpw, "m9k_nervegasnade")
table.insert(m9knpw, "m9k_nitro_vapor")
table.insert(m9knpw, "m9k_oribital_cannon")
table.insert(m9knpw, "m9k_poison_parent")
table.insert(m9knpw, "m9k_proxy")
table.insert(m9knpw, "m9k_released_poison")
table.insert(m9knpw, "m9k_sent_nuke_radiation")
table.insert(m9knpw, "m9k_thrown_harpoon")
table.insert(m9knpw, "m9k_thrown_knife")
table.insert(m9knpw, "m9k_thrown_m61")
table.insert(m9knpw, "m9k_thrown_nitrox")
table.insert(m9knpw, "m9k_thrown_spec_knife")
table.insert(m9knpw, "m9k_thrown_sticky_grenade")
table.insert(m9knpw, "bb_dod_bazooka_rocket")
table.insert(m9knpw, "bb_dod_panzershreck_rocket")
table.insert(m9knpw, "bb_garand_riflenade")
table.insert(m9knpw, "bb_k98_riflenade")
table.insert(m9knpw, "bb_planted_dod_tnt")
table.insert(m9knpw, "bb_thrownalliedfrag")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_thrownsmoke_axis")
table.insert(m9knpw, "bb_thrownaxisfrag")
table.insert(m9knpw, "bb_planted_alt_c4")
table.insert(m9knpw, "bb_planted_css_c4")
table.insert(m9knpw, "bb_throwncssfrag")
table.insert(m9knpw, "bb_throwncsssmoke")
table.insert(m9knpw, "m9k_ammo_40mm")
table.insert(m9knpw, "m9k_ammo_40mm_single")
table.insert(m9knpw, "m9k_ammo_357")
table.insert(m9knpw, "m9k_ammo_ar2")
table.insert(m9knpw, "m9k_ammo_buckshot")
table.insert(m9knpw, "m9k_ammo_c4")
table.insert(m9knpw, "m9k_ammo_frags")
table.insert(m9knpw, "m9k_ammo_ieds")
table.insert(m9knpw, "m9k_ammo_nervegas")
table.insert(m9knpw, "m9k_ammo_nuke")
table.insert(m9knpw, "m9k_ammo_pistol")
table.insert(m9knpw, "m9k_ammo_proxmines")
table.insert(m9knpw, "m9k_ammo_rockets")
table.insert(m9knpw, "m9k_ammo_smg")
table.insert(m9knpw, "m9k_ammo_sniper_rounds")
table.insert(m9knpw, "m9k_ammo_stickynades")
table.insert(m9knpw, "m9k_ammo_winchester")

function PocketM9KWeapons(ply, wep)

	if not IsValid(wep) then return end
	class = wep:GetClass()
	m9knopocket = false
	
	for k, v in pairs(m9knpw) do
		if v == class then
			m9knopocket = true
			break
		end
	end
	
	if m9knopocket then
		return false
	end
	
	--goddammit i hate darkrp
	
end
hook.Add("canPocket", "PocketM9KWeapons", PocketM9KWeapons )

heavy_autorun_mounted = true