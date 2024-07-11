extends GutTest

func test_to_creature_stats():
	# arrange
	var weapon = WeaponResource.new()
	
	var monster_resource = MonsterResource.new()
	monster_resource.name = "myName"
	monster_resource.hit_points = 1
	monster_resource.armor_class = 2
	monster_resource.damage = 3
	monster_resource.weapon = weapon
	monster_resource.max_movement = 4

	# act
	var creature_stats = monster_resource.to_creature_stats()
	
	# assert
	assert_eq(creature_stats.name, "myName")
	assert_eq(creature_stats.hit_points, 1)
	assert_eq(creature_stats.max_hit_points, 1)
	assert_eq(creature_stats.armor_class, 2)
	assert_eq(creature_stats.weapon, weapon)
	assert_eq(creature_stats.damage, 3)
	assert_eq(creature_stats.max_movement, 4)


