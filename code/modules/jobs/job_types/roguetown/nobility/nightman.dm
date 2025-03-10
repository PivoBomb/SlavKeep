/datum/job/roguetown/niteman
	title = "Niteman"
	flag = NIGHTMAN
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	f_title = "Nitematron"

	allowed_races = list(
		"Humen",
		"Dwarf",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)

	tutorial = "You are renting out the bath-house in a joint operation with the Innkeep. Providing security for the bathwenches and helping them find work, or a troublemaking rake that the others hate to tolerate."

	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/niteman
	display_order = JDO_NITEMAN
	give_bank_account = 120
	min_pq = 0
	bypass_lastclass = TRUE

/datum/outfit/job/roguetown/niteman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/brown
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/niteman
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/webs
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	belt = /obj/item/storage/belt/rogue/leather/nitemaster
	beltr = /obj/item/rogueweapon/knife/dagger/steel/special
	beltl = /obj/item/keyring/niteman
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/forgery_nitmaiden)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/niteman
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
			if(H.dna.species.id == "elf")
				armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/niteman
			if(H.dna.species.id == "dwarf")
				armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/niteman
	else
		pants = /obj/item/clothing/under/roguetown/tights
/*	.................   Unique Nitemaster recipes   ................... */
/datum/crafting_recipe/forgery_nitmaiden
	name = "Forge nitemaiden license"
	time = 4 SECONDS
	reqs = list(/obj/item/paper = 1,
		/obj/item/natural/feather = 1)
	result = /obj/item/paper/feldsher_certificate/fake
	category = CAT_NONE

