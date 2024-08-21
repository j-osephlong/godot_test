extends Area3D

var texture_size = 10

var collision_texture: ImageTexture
var collision_data: Image


# Called when the node enters the scene tree for the first time.
func _ready():
	collision_texture = ImageTexture.new()
	collision_data = Image.new()
	collision_data.create(512, 512, false, Image.FORMAT_RGB8)
	
	
	# Set the texture on the plane
	var material = $MeshInstance3D.mesh.material as ShaderMaterial
	material.set_shader_parameter("collision_texture", collision_texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_area_entered(area: CollisionObject3D):
	var collision_pos = area.global_transform.origin
	# Transform world coordinates to plane's local coordinates
	var plane_transform = ($MeshInstance3D as MeshInstance3D).transform
	var local_pos = plane_transform * collision_pos
	# Convert collision position to texture coordinates
	var plane_size = plane_transform.basis.get_scale()
	var uv = (Vector2(local_pos.x, local_pos.z) + Vector2(plane_size.x / 2, plane_size.z / 2)) / Vector2(plane_size.x, plane_size.z)
	uv = uv * texture_size
	
	print("colliding", collision_pos, local_pos, uv)

	# Ensure uv is within bounds
	uv = clamp(uv, Vector2(0, 0), Vector2(texture_size - 1, texture_size - 1))
	# Update the collision texture
	collision_data.set_pixelv(uv, Color(0, 1, 0))  # Mark collision in red
	collision_texture.set_image(collision_data)
