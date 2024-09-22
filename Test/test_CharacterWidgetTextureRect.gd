extends GutTest

var character_widget_texture_rect: CharacterWidgetTextureRect = null


func before_each():
	character_widget_texture_rect = CharacterWidgetTextureRect.new()


func after_each():
	character_widget_texture_rect.free()
	
	
func test_can_drop_data_with_armor():
	# arrange
	var slot = Slot.new()
	slot.item_resource = ArmorResource.new()
	
	# act
	var result = character_widget_texture_rect._can_drop_data(Vector2.ZERO, slot)
	
	# assert
	assert_true(result, "Should accept drop data when armor is dropped")
	
	# tear down
	slot.free()


func test_can_drop_data_with_weapon():
	# arrange
	var slot = Slot.new()
	slot.item_resource = WeaponResource.new()
	
	# act
	var result = character_widget_texture_rect._can_drop_data(Vector2.ZERO, slot)
	
	# assert
	assert_true(result, "Should accept drop data when weapon is dropped")
	
	# tear down
	slot.free()


func test_can_drop_data_with_spell():
	# arrange
	var slot = Slot.new()
	slot.item_resource = SpellResource.new()
	
	# act
	var result = character_widget_texture_rect._can_drop_data(Vector2.ZERO, slot)
	
	# assert
	assert_false(result, "Should reject drop data when spell is dropped")
	
	# tear down
	slot.free()
