extends GutTest


func test_get_set_name():
	# act
	var creature = Creature.new()
	
	# assert
	assert_accessors(creature, "name", "", "myName")
	
	
func test_get_set_hit_points():
	# act
	var creature = Creature.new()
	
	# assert
	assert_accessors(creature, "hit_points", 0, 10)


func test_get_set_armor_class():
	# act
	var creature = Creature.new()
	
	# assert
	assert_accessors(creature, "armor_class", 0, 10)


func test_get_set_damage():
	# act
	var creature = Creature.new()
	
	# assert
	assert_accessors(creature, "damage", 0, 1)
	
	
func test_roll_attack():
	
	# arrange
	seed(1)
	var creature = Creature.new()
	
	# act
	var result = creature.roll_attack()
	
	# assert
	assert_eq(result, 18, "Should roll attack of 10 when no bonus applied")
	
	
func test_hurt():
	# arrange
	var creature = Creature.new()
	creature.set_hit_points(10)
	
	# act
	creature.hurt(3)
	
	# assert
	assert_eq(creature.get_hit_points(), 7, "Should reduce damage from hit point when got hurt")
