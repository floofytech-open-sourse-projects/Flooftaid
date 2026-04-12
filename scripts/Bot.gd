extends Node

# Bot script that assists the player and attacks enemies

class_name Bot

# Variables to define bot behavior
var player
var enemies = []
var detection_range = 300.0
var attack_range = 150.0
var attack_damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
    player = get_parent().get_node("Player")

# Called every frame.
func _process(delta):
    detect_enemies()
    if enemies.size() > 0:
        attack_enemy()

# Detect enemies within the specified range
func detect_enemies():
    enemies.clear()
    for enemy in get_tree().get_nodes():
        if enemy.is_in_group("enemies") and position.distance_to(enemy.position) < detection_range:
            enemies.append(enemy)

# Attack the nearest enemy
func attack_enemy():
    var nearest_enemy = enemies[0]
    for enemy in enemies:
        if position.distance_to(enemy.position) < position.distance_to(nearest_enemy.position):
            nearest_enemy = enemy
    if position.distance_to(nearest_enemy.position) < attack_range:
        nearest_enemy.take_damage(attack_damage)
        print("Attacked enemy:", nearest_enemy)
