extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		apply_impulse(Vector3(0, 10, 0))

func _on_body_entered(body):
	var tween = get_tree().create_tween();
	tween.tween_method(set_shader_value, 1.0, 0.0, 0.5)

func set_shader_value(value: float):
	print(value)
	($MeshInstance3D as MeshInstance3D).mesh.material.set_shader_parameter("blend_value", value)
