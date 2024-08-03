extends GutTest

var armor_resource: ArmorResource = ArmorResource.new()


func test_to_String():
	# arrange
	armor_resource.armor_class = 10

	# act
	var result = armor_resource.to_string()
	
	# assert
	assert_eq(result, "RK: 10")
