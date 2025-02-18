extends Label

func show_start_game_text():
	text = "SCORE 50 POINTS TO WIN\nYOU HAVE 30 SECONDS\nPress enter to start!"
	add_theme_font_size_override("font_size", 70)
	horizontal_alignment = 1
	vertical_alignment = 1
	
func show_score(score: int):
	text = "Score: " + str(score)
	add_theme_font_size_override("font_size", 30)
	horizontal_alignment = 0
	vertical_alignment = 0
	
func show_game_over_text():
	text = "GAME OVER!\nPress enter to start a new game!"
	add_theme_font_size_override("font_size", 70)
	horizontal_alignment = 1
	vertical_alignment = 1

func show_win_text():
	text = "YOU WON!\nPress enter to start a new game!"
	add_theme_font_size_override("font_size", 70)
	horizontal_alignment = 1
	vertical_alignment = 1
