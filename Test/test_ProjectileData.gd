extends GutTest

const stone_sprite_frames: SpriteFrames = preload("res://World/Projectile/Stone_SpriteFrames.tres")

var projectile_data: ProjectileData = null


func before_each():
	projectile_data = ProjectileData.new()


func test_init():
	# act
	projectile_data.init()
	
	# assert
	assert_not_null(projectile_data._projectile_dictionary)


func test_get_projectile():
	# arrange
	projectile_data.init()
	
	# act
	var projectile = projectile_data.get_projectile(1)
	
	# assert
	assert_eq(projectile, stone_sprite_frames)
