extends GutTest

var battler: Battler = null

func before_each():
	battler = Battler.new()


func after_each():
	battler.free()


func test_get_creature():
	# act
	var creature = battler.get_creature()

	# assert
	assert_not_null(creature)


func test_get_set_name():

	# assert
	assert_accessors(battler, "creature_name", "", "myName")


func test_get_set_hit_points():

	# assert
	assert_accessors(battler, "hit_points", 0, 10)


func test_get_set_armor_class():

	# assert
	assert_accessors(battler, "armor_class", 0, 10)


func test_get_set_movement():

	# assert
	assert_accessors(battler, "movement", 0, 1)


func test_get_set_max_movement():

	# assert
	assert_accessors(battler, "max_movement", 0, 1)


func test_roll_attack():

	# arrange
	seed(1)

	# act
	var result = battler.roll_attack()

	# assert
	assert_eq(result, 18, "Should roll attack of 10 when no bonus applied")




func test_step():

	# arrange
	battler.set_movement(2)

	# act
	battler.step()

	# assert
	assert_eq(battler.get_movement(), 3, "Should increase movement by 1 when creature does a step")


func test_start_turn():

	# arrange
	var battlefield = Battlefield.new()
	var turn_indicator = Node2D.new()
	battler._battle_state = Battler.BattleState.DONE
	battler.set_movement(4)
	battler.set_max_movement(4)
	battler.turn_indicator = turn_indicator

	# act
	battler.start_turn()

	# assert
	assert_eq(battler.get_movement(), 0, "Should set movement to zero when battle round starts")
	assert_eq(battler._battle_state, Battler.BattleState.READY, "Should set battle state to READY when battle round starts")

	# tear down
	turn_indicator.free()
	battlefield.free()


func test_get_damage():
	# arrange
	seed(1)
	var damage = Damage.new()
	damage.number_of_dice = 1
	damage.die = DiceBox.Die.D6
	var weapon = WeaponResource.new()
	weapon.damage = damage
	var creature_stats = CreatureStats.new()
	creature_stats.action = weapon
	battler.set_creature(creature_stats)
	
	# act
	var result = battler.get_damage()
	
	# assert
	assert_eq(result, 4)


func test_is_melee_weapon_with_ranged_weapon():
	# arrange
	var weapon = WeaponResource.new()
	weapon.weapon_type = WeaponResource.WeaponType.RANGED_WEAPON
	battler.set_action(weapon)
	
	# act
	var result = battler.is_melee_weapon()
	
	# assert
	assert_false(result)


func test_is_melee_weapon_with_melee_weapon():
	# arrange
	var weapon = WeaponResource.new()
	weapon.weapon_type = WeaponResource.WeaponType.MELEE_WEAPON
	battler.set_action(weapon)
	
	# act
	var result = battler.is_melee_weapon()
	
	# assert
	assert_true(result)


func test_is_melee_weapon_with_spell():
	# arrange
	var spell = SpellResource.new()
	battler.set_action(spell)
	
	# act
	var result = battler.is_melee_weapon()
	
	# assert
	assert_false(result)
