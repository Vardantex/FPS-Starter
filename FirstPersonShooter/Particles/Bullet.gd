extends Area


var speed = 30.0
var damage = 1 

func _process(delta: float) -> void:
	
	
	translation += global_transform.basis.z * speed * delta
	

func destroy():
	
	queue_free()
	

func _ready() -> void:
	pass



func _on_Bullet_body_entered(body: Node) -> void:
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
		destroy()
	
	pass # Replace with function body.
