extends GutTest

const stone_sprite_frames: SpriteFrames = preload("res://World/Projectile/Stone_SpriteFrames.tres")

var projectile_data: ProjectileData = null


func before_each():
	projectile_data = ProjectileData.new()


func test_get_sprite_frame():
	
	# act
	var sprite_frames = projectile_data.get_sprite_frames(1)
	
	# assert
	assert_eq(sprite_frames, stone_sprite_frames)
