/datum/event/radiation_storm
	var/const/enterBelt		= 30
	var/const/radIntervall 	= 5	// Enough time between enter/leave belt for 10 hits, as per original implementation
	var/const/leaveBelt		= 80
	var/const/revokeAccess	= 165 //Hopefully long enough for radiation levels to dissipate.
	startWhen				= 2
	announceWhen			= 1
	endWhen					= revokeAccess
	var/postStartTicks 		= 0

/datum/event/radiation_storm/announce()
	command_announcement.Announce("High levels of radiation detected in proximity of the [system_name()]. Please don protective gear.", "Radiation Storm Detected", new_sound = GLOB.using_map.radiation_detected_sound)

/*/datum/event/radiation_storm/start()
	make_maint_all_access()*/

/datum/event/radiation_storm/tick()
	if(activeFor == enterBelt)
		command_announcement.Announce("[system_name()] has entered the radiation belt. Please remain in a sheltered area until we have passed the radiation belt.", "Radiation Storm Detected")
		radiate()

	if(activeFor >= enterBelt && activeFor <= leaveBelt)
		postStartTicks++

	if(postStartTicks == radIntervall)
		postStartTicks = 0
		radiate()

	else if(activeFor == leaveBelt)
		command_announcement.Announce("[system_name()] has passed the radiation belt. Please allow for up to one minute while radiation levels dissipate, and report to the infirmary if you experience any unusual symptoms.", "Radiation Storm Detected")

/datum/event/radiation_storm/proc/radiate()
	var/radiation_level = rand(1, 2) * severity
	for(var/z in GLOB.using_map.station_levels)
		radiation_repository.z_radiate(locate(1, 1, z), radiation_level, 1)

	for(var/mob/living/carbon/C in GLOB.living_mob_list_)
		var/area/A = get_area(C)
		if(!A)
			continue
		if(A.flags & AREA_RAD_SHIELDED)
			continue
		if(istype(C,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = C
			var/rad_protection = H.getarmor(null, "rad")
			H.apply_effect(radiation_level, IRRADIATE, rad_protection)
			if(prob(5 * blocked_mult(rad_protection)))
				if (prob(75))
					randmutb(H) // Applies bad mutation
					domutcheck(H,null,MUTCHK_FORCED)
				else
					randmutg(H) // Applies good mutation
					domutcheck(H,null,MUTCHK_FORCED)

/*/datum/event/radiation_storm/end()
	revoke_maint_all_access()*/

/datum/event/radiation_storm/syndicate/radiate()
	return
