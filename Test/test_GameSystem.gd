extends GutTest

const MonsterScene = preload("res://Combat/Monster.tscn")
var game_system: GameSystem = null


func before_each():
	game_system = GameSystem.new()


func test_attack_missed():
	# arrange
	seed(1)
	var attacker: Battler = MonsterScene.instantiate()
	attacker.set_name("myName")
	add_child(attacker)

	var defender: Battler = MonsterScene.instantiate()
	defender.set_hit_points(5)
	defender.set_armor_class(20)
	add_child(defender)

	# act
	game_system.attack(attacker, defender)

	# assert
	assert_eq(defender.get_hit_points(), 5, "Should have same number of hit points when attack misses")

	# tear down
	attacker.free()
	defender.free()


func test_attack_hit():
	## arrange
	seed(1000)
	var attacker: Battler = MonsterScene.instantiate()
	attacker.set_creature_name("myName")
	attacker.set_damage(2)
	add_child(attacker)

	var defender: Battler = MonsterScene.instantiate()
	defender.set_hit_points(5)
	defender.set_armor_class(10)
	add_child(defender)

	# act
	game_system.attack(attacker, defender)

	# assert
	assert_eq(defender.get_hit_points(), 3, "Should hit points reduced by damage when attack hits")

	# tear down
	attacker.free()
	defender.free()
	get_node("HitEffect").free()

