extends Area2D
signal hit

@export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float):
	var velocity = Vector2.ZERO

	# Utiliser is_action_pressed pour détecter le maintien des touches
	if Input.is_action_pressed("mouve_right"):
		velocity.x += 1
	if Input.is_action_pressed("mouve_left"):
		velocity.x -= 1
	if Input.is_action_pressed("mouve_down"):
		velocity.y += 1
	if Input.is_action_pressed("mouve_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	# Gérer les animations
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false;
