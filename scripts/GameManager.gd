extends Node

# GameManager manages game levels, player, enemy, and bot spawning.

# Signals
signal level_changed(level_number)

# Properties
var levels = []
var current_level = 0
var players = []
var enemies = []
var bots = []

func _ready():
    load_levels()
    start_level(current_level)

# Load levels from a configuration or resource
func load_levels():
    # Assume levels are defined in some format.
    levels = ["level1", "level2", "level3"] 

# Start a specific level
func start_level(level_number):
    current_level = level_number
    emit_signal("level_changed", current_level)
    spawn_players()
    spawn_enemies()
    spawn_bots()

# Spawn players at the start of the level
func spawn_players():
    for i in range(2): # Assuming 2 players for example
        var player = preload("res://scripts/Player.gd").new()
        add_child(player)
        players.append(player)
        player.position = Vector2(randf() * 640, randf() * 480) # Random position

# Spawn enemies based on the level
func spawn_enemies():
    var enemy_count = 5 + current_level * 2
    for i in range(enemy_count):
        var enemy = preload("res://scripts/Enemy.gd").new()
        add_child(enemy)
        enemies.append(enemy)
        enemy.position = Vector2(randf() * 640, randf() * 480)

# Spawn bots to assist players
func spawn_bots():
    var bot_count = 3
    for i in range(bot_count):
        var bot = preload("res://scripts/Bot.gd").new()
        add_child(bot)
        bots.append(bot)
        bot.position = Vector2(randf() * 640, randf() * 480)

# Function to change the level
func change_level(new_level):
    if new_level >= 0 and new_level < levels.size():
        clear_current_level()
        start_level(new_level)

# Clear current level entities
func clear_current_level():
    for player in players:
        player.queue_free()
    players.clear()
    for enemy in enemies:
        enemy.queue_free()
    enemies.clear()
    for bot in bots:
        bot.queue_free()
    bots.clear()