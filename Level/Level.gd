extends Spatial

export var target_score = 3

var player1_score = 0
var player2_score = 0

func _on_GoalDetector_body_entered(body, goal_id):
	get_tree().call_group("game_pieces", "freeze", goal_id)
	$Timer.start()
	update_score(goal_id)
	$Airhorn.play()

func _on_Timer_timeout():
	get_tree().call_group("game_pieces", "reset")

func update_score(player):
	var new_Score 
	
	match player:
		1:
			player1_score += 1
			new_Score = player1_score
		2: 
			player2_score += 1
			new_Score = player2_score
	
	$GUI.update_score(player, new_Score)
	check_game_over(player, new_Score)

func check_game_over(player, score):
	if score == target_score:
		$Timer.queue_free()
		$GUI.game_over(player)
