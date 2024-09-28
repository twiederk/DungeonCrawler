extends GutTest

var item_data: ItmData = null


func before_each():
	item_data = ItmData.new()


func after_each():
	item_data.free()


func test_ready():
	
	# act
	item_data._ready()
	
	# assert
	assert_not_null(item_data._weapon_data)
	assert_not_null(item_data._armor_data)
	assert_not_null(item_data._spell_data)
	assert_not_null(item_data._projectile_data)
