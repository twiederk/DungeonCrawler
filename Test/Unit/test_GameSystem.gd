extends GutTest

var game_system: GameSystem = null


func before_each():
	game_system = GameSystem.new()


func test_attack_missed():
	# arrange
	seed(1)
	var attacker: Creature = Creature.new()
	attacker.set_name("myName")

	var defender: Creature = Creature.new()
	defender.set_hit_points(5)
	defender.set_armor_class(10)

	# act
	game_system.attack(attacker, defender)

	# assert
	assert_eq(defender.get_hit_points(), 5, "Should have same number of hit points when attack misses")


func test_attack_hit():
	# arrange
	seed(1000)
	var attacker: Creature = Creature.new()
	attacker.set_name("myName")
	attacker.set_damage(2)

	var defender: Creature = Creature.new()
	defender.set_hit_points(5)
	defender.set_armor_class(10)

	# act
	game_system.attack(attacker, defender)

	# assert
	assert_eq(defender.get_hit_points(), 3, "Should hit points reduced by damage when attack hits")



