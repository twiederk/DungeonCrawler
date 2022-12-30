extends GutTest

var monster: Monster = null

func before_each():
	monster = Monster.new()
	
	
func after_each():
	monster.free()
	
	
func test_get_creature():
	# act
	var creature = monster.get_creature()
	
	# assert
	assert_not_null(creature)
	
