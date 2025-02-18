extends Node

@onready var label: Label = $"../Control/Label"
@onready var player: CharacterBody3D = $"../Player"
@onready var timer_label: Label = $"../Control/TimerLabel"

var score = 0
var state = 'new_game'
var time = 0.0
var time_stop = true

func _process(delta: float) -> void:
	if time_stop:
		return
	
	time += delta
	timer_label.text = str(round(time * 100) / 100.0)
	
	if time >= 30:
		timer_label.text = "30.00"
		label.show_game_over_text()
		player.can_move = false
		time_stop = true
		state = 'game_over'

func _ready():
	label.show_start_game_text()

func add_points(points: int):
	score += points
	label.show_score(score)
	
	if(score>=50):
		label.show_win_text()
		player.can_move = false
		time_stop = true
		state = 'game_win'
		
func _input(event: InputEvent) -> void:
	if state == 'new_game' and Input.is_action_just_pressed("game_toggle"):
		player.can_move = true
		time_stop = false
		add_points(0)
		
	if (state == 'game_win' or state == 'game_over') and Input.is_action_just_pressed("game_toggle"):
		get_tree().reload_current_scene()
