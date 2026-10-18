extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var sword = $Sword
var speed = 200

func _physics_process(delta: float) -> void:
	var direction = Vector2()
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	$AnimatedSprite2D.play("walk")
	
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	velocity = direction * speed
	move_and_slide()
	
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
	if direction != Vector2.ZERO and anim.animation != "attack":
		anim.play("walk")
	elif anim.animation!= "attack":
		anim.play("idle")
		
	if Input.is_action_just_pressed("attack"):
		attack()
		
func attack():
	if anim.animation == "attack":
		return
	anim.play("atack")
	sword.enable()
	await anim.animation_finished
	sword.disable()
	anim.play("idle")
