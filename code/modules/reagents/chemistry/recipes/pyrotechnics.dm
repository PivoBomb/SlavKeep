/datum/chemical_reaction/reagent_explosion
	name = "Generic explosive"
	id = "reagent_explosion"
	var/strengthdiv = 10
	var/modifier = 0

/datum/chemical_reaction/reagent_explosion/proc/do_explosion(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/lastkey = holder.my_atom.fingerprintslast
	log_game("Reagent explosion reaction occurred at [AREACOORD(T)]. Last Fingerprint: [lastkey ? lastkey : "N/A"]." )
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(modifier + round(created_volume/strengthdiv, 1), T, 0, 0)
	e.start()
	holder.clear_reagents()

/datum/chemical_reaction/reagent_explosion/on_reaction(datum/reagents/holder, created_volume)
	do_explosion()

/datum/chemical_reaction/reagent_explosion/nitroglycerin
	name = "Nitroglycerin"
	id = /datum/reagent/nitroglycerin
	results = list(/datum/reagent/nitroglycerin = 2)
	required_reagents = list(/datum/reagent/glycerol = 1, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/toxin/acid = 1)
	strengthdiv = 2

/datum/chemical_reaction/reagent_explosion/nitroglycerin/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/nitroglycerin, created_volume*2)
	..()

/datum/chemical_reaction/reagent_explosion/nitroglycerin_explosion
	name = "Nitroglycerin explosion"
	id = "nitroglycerin_explosion"
	required_reagents = list(/datum/reagent/nitroglycerin = 1)
	required_temp = 474
	strengthdiv = 2

/datum/chemical_reaction/reagent_explosion/rdx
	name = "RDX"
	id = /datum/reagent/rdx
	results = list(/datum/reagent/rdx= 2)
	required_reagents = list(/datum/reagent/phenol = 2, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/acetone_oxide = 1 )
	required_temp = 404
	strengthdiv = 8

/datum/chemical_reaction/reagent_explosion/rdx/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/rdx, created_volume*2)
	..()

/datum/chemical_reaction/reagent_explosion/rdx_explosion
	name = "Heat RDX explosion"
	id = "rdx_explosion"
	required_reagents = list(/datum/reagent/rdx = 1)
	required_temp = 474
	strengthdiv = 8

/datum/chemical_reaction/reagent_explosion/rdx_explosion2 //makes rdx unique , on its own it is a good bomb, but when combined with liquid electricity it becomes truly destructive
	name = "Electric RDX explosion"
	id = "rdx_explosion2"
	required_reagents = list(/datum/reagent/rdx = 1 , /datum/reagent/consumable/liquidelectricity = 1)
	strengthdiv = 4
	modifier = 2

/datum/chemical_reaction/reagent_explosion/rdx_explosion2/on_reaction(datum/reagents/holder, created_volume)
	var/fire_range = round(created_volume/100)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(fire_range,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 500
	..()

/datum/chemical_reaction/reagent_explosion/rdx_explosion3
	name = "Teslium RDX explosion"
	id = "rdx_explosion3"
	required_reagents = list(/datum/reagent/rdx = 1 , /datum/reagent/teslium = 1)
	modifier = 4
	strengthdiv = 4

/datum/chemical_reaction/reagent_explosion/rdx_explosion3/on_reaction(datum/reagents/holder, created_volume)
	var/fire_range = round(created_volume/50)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(fire_range,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 750
	..()

/datum/chemical_reaction/reagent_explosion/tatp
	name = "TaTP"
	id = /datum/reagent/tatp
	results = list(/datum/reagent/tatp= 1)
	required_reagents = list(/datum/reagent/acetone_oxide = 1, /datum/reagent/toxin/acid/nitracid = 1, /datum/reagent/pentaerythritol = 1 )
	required_temp = 450
	strengthdiv = 3

/datum/chemical_reaction/reagent_explosion/tatp/New()
	SSticker.OnRoundstart(CALLBACK(src,PROC_REF(UpdateInfo))) //method used by secret sauce.

/datum/chemical_reaction/reagent_explosion/tatp/proc/UpdateInfo()
	required_temp = 450 + rand(-49,49)  //this gets loaded only on round start


/datum/chemical_reaction/reagent_explosion/tatp/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/tatp, created_volume)
	..()

/datum/chemical_reaction/reagent_explosion/tatp_explosion
	name = "TaTP explosion"
	id = "tatp_explosion"
	required_reagents = list(/datum/reagent/tatp = 1)
	required_temp = 550 // this makes making tatp before pyro nades, and extreme pain in the ass to make
	strengthdiv = 3

/datum/chemical_reaction/reagent_explosion/tatp_explosion/New()
	SSticker.OnRoundstart(CALLBACK(src,PROC_REF(UpdateInfo)))


/datum/chemical_reaction/reagent_explosion/tatp_explosion/proc/UpdateInfo()
	required_temp = 550 + rand(-49,49)


/datum/chemical_reaction/reagent_explosion/penthrite_explosion
	name = "Penthrite explosion"
	id = "penthrite_explosion"
	required_reagents = list(/datum/reagent/medicine/C2/penthrite = 1, /datum/reagent/phenol = 1, /datum/reagent/acetone_oxide = 1)
	required_temp = 315
	strengthdiv = 5

/datum/chemical_reaction/reagent_explosion/potassium_explosion
	name = "Explosion"
	id = "potassium_explosion"
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/potassium = 1)
	strengthdiv = 20

/datum/chemical_reaction/reagent_explosion/potassium_explosion/holyboom
	name = "Holy Explosion"
	id = "holyboom"
	required_reagents = list(/datum/reagent/water/holywater = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/reagent_explosion/potassium_explosion/holyboom/on_reaction(datum/reagents/holder, created_volume)
	if(created_volume >= 150)
		playsound(get_turf(holder.my_atom), 'sound/blank.ogg', 80, FALSE, round(created_volume/48))
		strengthdiv = 8
		for(var/mob/living/simple_animal/revenant/R in get_hearers_in_view(7,get_turf(holder.my_atom)))
			var/deity
			if(GLOB.deity)
				deity = GLOB.deity
			else
				deity = "Christ"
			to_chat(R, "<span class='danger'>The power of [deity] compels you!</span>")
			R.stun(20)
			R.reveal(100)
			R.adjustHealth(50)
	..()


/datum/chemical_reaction/gunpowder
	name = "Gunpowder"
	id = /datum/reagent/gunpowder
	results = list(/datum/reagent/gunpowder = 3)
	required_reagents = list(/datum/reagent/saltpetre = 1, /datum/reagent/medicine/C2/multiver = 1, /datum/reagent/sulfur = 1)

/datum/chemical_reaction/reagent_explosion/gunpowder_explosion
	name = "Gunpowder Kaboom"
	id = "gunpowder_explosion"
	required_reagents = list(/datum/reagent/gunpowder = 1)
	required_temp = 474
	strengthdiv = 6
	modifier = 1
	mix_message = "<span class='boldannounce'>Sparks start flying around the gunpowder!</span>"

/datum/chemical_reaction/reagent_explosion/gunpowder_explosion/on_reaction(datum/reagents/holder, created_volume)
	addtimer(CALLBACK(src, PROC_REF(do_explosion), holder, created_volume), rand(5 SECONDS, 10 SECONDS))

/datum/chemical_reaction/thermite
	name = "Thermite"
	id = /datum/reagent/thermite
	results = list(/datum/reagent/thermite = 3)
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/iron = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/emp_pulse
	name = "EMP Pulse"
	id = "emp_pulse"
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/iron = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense

/datum/chemical_reaction/emp_pulse/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	empulse(location, round(created_volume / 12), round(created_volume / 7), 1)
	holder.clear_reagents()

/datum/chemical_reaction/stabilizing_agent
	name = /datum/reagent/stabilizing_agent
	id = /datum/reagent/stabilizing_agent
	results = list(/datum/reagent/stabilizing_agent = 3)
	required_reagents = list(/datum/reagent/iron = 1, /datum/reagent/oxygen = 1, /datum/reagent/hydrogen = 1)

/datum/chemical_reaction/clf3
	name = "Chlorine Trifluoride"
	id = /datum/reagent/clf3
	results = list(/datum/reagent/clf3 = 4)
	required_reagents = list(/datum/reagent/chlorine = 1, /datum/reagent/fluorine = 3)
	required_temp = 424

/datum/chemical_reaction/clf3/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(1,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 1000 // hot as shit

/datum/chemical_reaction/reagent_explosion/methsplosion
	name = "Meth explosion"
	id = "methboom1"
	required_temp = 380 //slightly above the meth mix time.
	required_reagents = list(/datum/reagent/drug/methamphetamine = 1)
	strengthdiv = 6
	modifier = 1
	mob_react = FALSE

/datum/chemical_reaction/reagent_explosion/methsplosion/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(1,T))
		new /obj/effect/hotspot(turf)
	holder.chem_temp = 1000 // hot as shit
	..()

/datum/chemical_reaction/reagent_explosion/methsplosion/methboom2
	id = "methboom2"
	required_reagents = list(/datum/reagent/diethylamine = 1, /datum/reagent/iodine = 1, /datum/reagent/phosphorus = 1, /datum/reagent/hydrogen = 1) //diethylamine is often left over from mixing the ephedrine.
	required_temp = 300 //room temperature, chilling it even a little will prevent the explosion

/datum/chemical_reaction/sorium
	name = "Sorium"
	id = /datum/reagent/sorium
	results = list(/datum/reagent/sorium = 4)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/oxygen = 1, /datum/reagent/nitrogen = 1, /datum/reagent/carbon = 1)

/datum/chemical_reaction/sorium/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/sorium, created_volume*4)
	var/turf/T = get_turf(holder.my_atom)
	var/range = CLAMP(sqrt(created_volume*4), 1, 6)
	goonchem_vortex(T, 1, range)

/datum/chemical_reaction/sorium_vortex
	name = "sorium_vortex"
	id = "sorium_vortex"
	required_reagents = list(/datum/reagent/sorium = 1)
	required_temp = 474

/datum/chemical_reaction/sorium_vortex/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/range = CLAMP(sqrt(created_volume), 1, 6)
	goonchem_vortex(T, 1, range)

/datum/chemical_reaction/liquid_dark_matter
	name = "Liquid Dark Matter"
	id = /datum/reagent/liquid_dark_matter
	results = list(/datum/reagent/liquid_dark_matter = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/carbon = 1)

/datum/chemical_reaction/liquid_dark_matter/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/liquid_dark_matter, created_volume*3)
	var/turf/T = get_turf(holder.my_atom)
	var/range = CLAMP(sqrt(created_volume*3), 1, 6)
	goonchem_vortex(T, 0, range)

/datum/chemical_reaction/ldm_vortex
	name = "LDM Vortex"
	id = "ldm_vortex"
	required_reagents = list(/datum/reagent/liquid_dark_matter = 1)
	required_temp = 474

/datum/chemical_reaction/ldm_vortex/on_reaction(datum/reagents/holder, created_volume)
	var/turf/T = get_turf(holder.my_atom)
	var/range = CLAMP(sqrt(created_volume/2), 1, 6)
	goonchem_vortex(T, 0, range)

/datum/chemical_reaction/flash_powder
	name = "Flash powder"
	id = /datum/reagent/flash_powder
	results = list(/datum/reagent/flash_powder = 3)
	required_reagents = list(/datum/reagent/aluminium = 1, /datum/reagent/potassium = 1, /datum/reagent/sulfur = 1 )

/datum/chemical_reaction/flash_powder/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	var/location = get_turf(holder.my_atom)
	do_sparks(2, TRUE, location)
	var/range = created_volume/3
	if(isatom(holder.my_atom))
		var/atom/A = holder.my_atom
		A.flash_lighting_fx(_range = (range + 2), _reset_lighting = FALSE)
	for(var/mob/living/C in get_hearers_in_view(range, location))
		if(C.flash_act(affect_silicon = TRUE))
			if(get_dist(C, location) < 4)
				C.Paralyze(60)
			else
				C.Stun(100)
	holder.remove_reagent(/datum/reagent/flash_powder, created_volume*3)

/datum/chemical_reaction/flash_powder_flash
	name = "Flash powder activation"
	id = "flash_powder_flash"
	required_reagents = list(/datum/reagent/flash_powder = 1)
	required_temp = 374

/datum/chemical_reaction/flash_powder_flash/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	do_sparks(2, TRUE, location)
	var/range = created_volume/10
	if(isatom(holder.my_atom))
		var/atom/A = holder.my_atom
		A.flash_lighting_fx(_range = (range + 2), _reset_lighting = FALSE)
	for(var/mob/living/C in get_hearers_in_view(range, location))
		if(C.flash_act(affect_silicon = TRUE))
			if(get_dist(C, location) < 4)
				C.Paralyze(60)
			else
				C.Stun(100)

/datum/chemical_reaction/smoke_powder
	name = /datum/reagent/smoke_powder
	id = /datum/reagent/smoke_powder
	results = list(/datum/reagent/smoke_powder = 3)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/smoke_powder/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/smoke_powder, created_volume*3)
	var/smoke_radius = round(sqrt(created_volume * 1.5), 1)
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/smoke_spread/chem/S = new
	S.attach(location)
	playsound(location, 'sound/blank.ogg', 50, TRUE, -3)
	if(S)
		S.set_up(holder, smoke_radius, location, 0)
		S.start()
	if(holder && holder.my_atom)
		holder.clear_reagents()

/datum/chemical_reaction/smoke_powder_smoke
	name = "smoke_powder_smoke"
	id = "smoke_powder_smoke"
	required_reagents = list(/datum/reagent/smoke_powder = 1)
	required_temp = 374
	mob_react = FALSE

/datum/chemical_reaction/smoke_powder_smoke/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	var/smoke_radius = round(sqrt(created_volume / 2), 1)
	var/datum/effect_system/smoke_spread/chem/S = new
	S.attach(location)
	playsound(location, 'sound/blank.ogg', 50, TRUE, -3)
	if(S)
		S.set_up(holder, smoke_radius, location, 0)
		S.start()
	if(holder && holder.my_atom)
		holder.clear_reagents()

/datum/chemical_reaction/sonic_powder
	name = /datum/reagent/sonic_powder
	id = /datum/reagent/sonic_powder
	results = list(/datum/reagent/sonic_powder = 3)
	required_reagents = list(/datum/reagent/oxygen = 1, /datum/reagent/consumable/space_cola = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/sonic_powder/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	holder.remove_reagent(/datum/reagent/sonic_powder, created_volume*3)
	var/location = get_turf(holder.my_atom)
	playsound(location, 'sound/blank.ogg', 25, TRUE)
	for(var/mob/living/carbon/C in get_hearers_in_view(created_volume/3, location))
		C.soundbang_act(1, 100, rand(0, 5))

/datum/chemical_reaction/sonic_powder_deafen
	name = "sonic_powder_deafen"
	id = "sonic_powder_deafen"
	required_reagents = list(/datum/reagent/sonic_powder = 1)
	required_temp = 374

/datum/chemical_reaction/sonic_powder_deafen/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	playsound(location, 'sound/blank.ogg', 25, TRUE)
	for(var/mob/living/carbon/C in get_hearers_in_view(created_volume/10, location))
		C.soundbang_act(1, 100, rand(0, 5))

/datum/chemical_reaction/phlogiston
	name = /datum/reagent/phlogiston
	id = /datum/reagent/phlogiston
	results = list(/datum/reagent/phlogiston = 3)
	required_reagents = list(/datum/reagent/phosphorus = 1, /datum/reagent/toxin/acid = 1, /datum/reagent/stable_plasma = 1)

/datum/chemical_reaction/phlogiston/on_reaction(datum/reagents/holder, created_volume)
	if(holder.has_reagent(/datum/reagent/stabilizing_agent))
		return
	var/turf/open/T = get_turf(holder.my_atom)
	if(istype(T))
		T.atmos_spawn_air("plasma=[created_volume];TEMP=1000")
	holder.clear_reagents()
	return

/datum/chemical_reaction/napalm
	name = "Napalm"
	id = /datum/reagent/napalm
	results = list(/datum/reagent/napalm = 3)
	required_reagents = list(/datum/reagent/fuel/oil = 1, /datum/reagent/fuel = 1, /datum/reagent/consumable/ethanol = 1 )

/datum/chemical_reaction/cryostylane
	name = /datum/reagent/cryostylane
	id = /datum/reagent/cryostylane
	results = list(/datum/reagent/cryostylane = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/stable_plasma = 1, /datum/reagent/nitrogen = 1)

/datum/chemical_reaction/cryostylane/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp = 20 // cools the fuck down
	return

/datum/chemical_reaction/cryostylane_oxygen
	name = "ephemeral cryostylane reaction"
	id = "cryostylane_oxygen"
	results = list(/datum/reagent/cryostylane = 1)
	required_reagents = list(/datum/reagent/cryostylane = 1, /datum/reagent/oxygen = 1)
	mob_react = FALSE

/datum/chemical_reaction/cryostylane_oxygen/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp = max(holder.chem_temp - 10*created_volume,0)

/datum/chemical_reaction/pyrosium_oxygen
	name = "ephemeral pyrosium reaction"
	id = "pyrosium_oxygen"
	results = list(/datum/reagent/pyrosium = 1)
	required_reagents = list(/datum/reagent/pyrosium = 1, /datum/reagent/oxygen = 1)
	mob_react = FALSE

/datum/chemical_reaction/pyrosium_oxygen/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp += 10*created_volume

/datum/chemical_reaction/pyrosium
	name = /datum/reagent/pyrosium
	id = /datum/reagent/pyrosium
	results = list(/datum/reagent/pyrosium = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/uranium/radium = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/pyrosium/on_reaction(datum/reagents/holder, created_volume)
	holder.chem_temp = 20 // also cools the fuck down
	return

/datum/chemical_reaction/teslium
	name = "Teslium"
	id = /datum/reagent/teslium
	results = list(/datum/reagent/teslium = 3)
	required_reagents = list(/datum/reagent/stable_plasma = 1, /datum/reagent/silver = 1, /datum/reagent/gunpowder = 1)
	mix_message = "<span class='danger'>A jet of sparks flies from the mixture as it merges into a flickering slurry.</span>"
	required_temp = 400

/datum/chemical_reaction/energized_jelly
	name = "Energized Jelly"
	id = /datum/reagent/teslium/energized_jelly
	results = list(/datum/reagent/teslium/energized_jelly = 2)
	required_reagents = list(/datum/reagent/toxin/slimejelly = 1, /datum/reagent/teslium = 1)
	mix_message = "<span class='danger'>The slime jelly starts glowing intermittently.</span>"

/datum/chemical_reaction/reagent_explosion/nitrous_oxide
	name = "N2O explosion"
	id = "n2o_explosion"
	required_reagents = list(/datum/reagent/nitrous_oxide = 1)
	strengthdiv = 7
	required_temp = 575
	modifier = 1

/datum/chemical_reaction/firefighting_foam
	name = "Firefighting Foam"
	id = /datum/reagent/firefighting_foam
	results = list(/datum/reagent/firefighting_foam = 3)
	required_reagents = list(/datum/reagent/stabilizing_agent = 1,/datum/reagent/fluorosurfactant = 1,/datum/reagent/carbon = 1)
	required_temp = 200
	is_cold_recipe = 1
