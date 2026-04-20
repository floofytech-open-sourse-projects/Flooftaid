extends Node2D

# Enemy AI Behavior Script

var detection_range = 300 # Range within which the enemy can detect the player
var chase_speed = 150 # Speed of the enemy when chasing the player
var melee_attack_range = 50 # Range within which the enemy can perform a melee attack
var is_chasing = false # Flag to check if the enemy is currently chasing
var target 

# Called every frame
func _process(delta):
    if is_chasing:
        chase_player(delta)
        if target and position.distance_to(target.position) <= melee_attack_range:
            melee_attack()

# Function to detect the player
func detect_player(player):
    if position.distance_to(player.position) <= detection_range:
        target = player
        is_chasing = true
    else:
        is_chasing = false
        target = null

# Function to chase the player
func chase_player(delta):
    if target:
        var direction = (target.position - position).normalized()
        position += direction * chase_speed * delta

# Function to perform a melee attack
func melee_attack():
    print("Enemy attacks! Consider implementing health reduction logic here.")