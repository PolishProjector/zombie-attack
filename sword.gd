extends Area2D

var damage = 25 

func _ready():
	monitoring = false
	
func enable():
		monitoring = true
		
func disable():
	monitoring = false 
	
func _on_body_entered(body):
	if body.is_in_group("zombie"):
		body.queue_free()
		
		
		
