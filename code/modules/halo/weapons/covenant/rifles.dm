/obj/item/weapon/gun/energy/plasmarifle
	name = "Type-25 Directed Energy Rifle"
	desc = "Also known as the \"Plasma Rifle\", this weapon fires 3-shot bursts of superheated plasma."
	icon = 'code/modules/halo/icons/Covenant Weapons.dmi'
	icon_state = "Plasma Rifle"
	item_state = "plasmarifle"
	slot_flags = SLOT_BELT|SLOT_BACK
	fire_sound = 'code/modules/halo/sounds/plasrifle1shot.ogg'
	charge_meter = 1
	max_shots = 240
	projectile_type = /obj/item/projectile/bullet/covenant/plasmarifle
	screen_shake = 0
	is_heavy = 1

	//MA5 Counterpart. One less in burst, with overheat tracking, with an accuracy boon.
	fire_delay = 6
	burst = 4
	burst_delay = 1.8
	dispersion = list(0.2,0.3,0.5,0.73)
	accuracy = 1
	one_hand_penalty = 2

	overheat_capacity = 24 //6 clicks/bursts
	overheat_fullclear_delay = 30
	overheat_sfx = 'code/modules/halo/sounds/plasrifle_overheat.ogg'

	item_icons = list(
		slot_l_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_left.dmi',
		slot_r_hand_str = 'code/modules/halo/weapons/icons/Weapon_Inhands_right.dmi',
		slot_back_str = 'code/modules/halo/weapons/icons/Back_Weapons.dmi',
		slot_s_store_str = 'code/modules/halo/weapons/icons/Armor_Weapons.dmi',
		slot_s_belt_str = 'code/modules/halo/weapons/icons/Belt_Weapons.dmi',
		)

	irradiate_non_cov = 10

/obj/item/weapon/gun/energy/plasmarifle/can_use_when_prone()
	return 1

/obj/item/weapon/gun/energy/plasmarifle/proc/cov_plasma_recharge_tick()
	if(max_shots > 0)
		if(power_supply.charge < power_supply.maxcharge)
			power_supply.give(charge_cost*10)
			update_icon()
			return 1

/obj/item/weapon/gun/energy/plasmarifle/decorative
	desc = "Also known as the \"Plasma Rifle\", this weapon fires 3-shot bursts of superheated plasma. This one seems to have fused the internal components together, making it unusable."
	max_shots = 0

/obj/item/weapon/gun/energy/plasmarifle/brute
	name = "Type-25 Directed Energy Rifle (overcharged)"
	icon_state = "Brute Plasma Rifle"
	desc = "Also known as the \"Plasma Rifle\", this weapon fires 4-shot bursts of superheated plasma at an accelerated rate. This one appears to be overcharged for fire speed."
	projectile_type = /obj/item/projectile/bullet/covenant/plasmarifle/brute
	fire_delay = 6
	burst_delay = 1.8
	irradiate_non_cov = 8
