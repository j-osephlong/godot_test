extends Area3D

signal collected

# Called when the node enters the scene tree for the first time.
func _ready():
	var rotate_tween = get_tree().create_tween().set_loops()
	rotate_tween.tween_property(self, "rotation", Vector3(0, deg_to_rad((360)), 0), 2).as_relative()
	var hover_tween = get_tree()\
		.create_tween()\
		.set_loops()\
		.set_parallel((false))\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_SINE)
	hover_tween.tween_property(self, "position", Vector3(0, .1, 0), .5).as_relative()
	hover_tween.tween_property(self, "position", Vector3(0, -.1, 0), .5).as_relative()
	hover_tween.chain()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area: CollisionObject3D):
	print(typeof( area))
	if area.name == "Player":
		emit_signal("collected")
		queue_free()
