extends CharacterBody2D

var hp = 100
@onready var hp_bar = $hp_bar
@export var max_hp = 100
var current_hp = 100
@onready var anim = $AnimatedSprite2D
@onready var sword = $sword
var speed = 200
var is_attacking = false

signal hp_changed(new_hp)  # <- TO MUSI BYĆ

func _physics_process(delta):
	if is_attacking:
		move_and_slide()
		return
	# ... reszta Twojego kodu od chodzenia zostaje
	var direction = Vector2()
	direction.x = Input.get_axis("left", "right")
	direction.y = Input.get_axis("up", "down")
	
	if not is_attacking:
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
	


	if direction != Vector2.ZERO:
		if not is_attacking:
			anim.play("walk")
	else:
		if not is_attacking:
			anim.play("idle")

	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		$sword.do_attack()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "attack":
		is_attacking = false

func attack():
	print("ATAKUJE!")
	$sword.monitoring = true
	$AnimatedSprite2D.play("attack")
	await get_tree().create_timer(0.2).timeout
	$sword.monitoring = false


		
func die():
	print("umarł")



func do_my_attack():
	if not is_attacking:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		$sword.do_attack()



func take_damage(dmg):
	hp -= dmg
	print("Player HP: ", hp)
	
	if hp_bar:
		hp_bar.value = hp
	
	if hp <= 0:
		print("DEAD")
		queue_free()
