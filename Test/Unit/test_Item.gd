extends GutTest

var item : Item = null

func before_each():
	item = Item.new()


func after_each():
	item.free()


func test_can_create_Item():
	# act
	var myItem = Item.new()

	# assert
	assert_not_null(myItem)

	# tear down
	myItem.free()


func test_on_Item_body_entered():
	# arrange
	watch_signals(item)
	var character = Character.new()

	# act
	item._on_Item_body_entered(character)

	# assert
	assert_signal_emitted(item, "picked")

	# tear down
	character.free()
