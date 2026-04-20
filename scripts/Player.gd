extends CharacterBody2D

# Player properties
var speed = 200
var jump_force = 400
var health = 100
var max_health = 100
var weapon_damage = 10

# Called every frame
func _process(delta):
    movement(delta)
    mouse_look()

# Handle player movement
func movement(delta):
    var direction = Vector2.ZERO
    if Input.is_action_pressed("ui_right"):
        direction.x += 1
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1
    if Input.is_action_pressed("ui_down"):
        direction.y += 1
    if Input.is_action_pressed("ui_up"):
        direction.y -= 1

    if direction.length() > 0:
        direction = direction.normalized()
        move_and_slide(direction * speed)

# Handle mouse look
func mouse_look():
    var mouse_movement = Input.get_last_mouse_velocity()
    rotation_degrees -= mouse_movement.x * 0.1

# Handle jumping
func _input(event):
    if event.is_action_pressed("ui_select") and is_on_floor():
        jump()

func jump():
    velocity.y = -jump_force

# Health management
func take_damage(amount):
    health -= amount
    if health <= 0:
        die()

func die():
    queue_free() # Remove player from the scene

# Weapon mechanics
func attack():
    # Attack logic (e.g., reduce enemy health)
    pass

# Call this function to heal the player
func heal(amount):
    health = clamp(health + amount, 0, max_health)