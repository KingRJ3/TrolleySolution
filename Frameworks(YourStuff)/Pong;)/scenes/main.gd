extends Game

var score := [0, 99]# 0:Player, 1: CPU
const PADDLE_SPEED : int = 1000

# Called when the node enters the scene tree for the first time.
func _start_game() -> void:
	$BallTimer.start()

func _on_ball_timer_timeout() -> void:
	$Label.visible = false
	if score[1] > 99:
		emit_signal("end_game",false) # you lose
	elif score[0] > 99:
		emit_signal("end_game",true) # you win
	$Ball.new_ball()
	


func _on_score_left_body_entered(_body: Node2D) -> void:
	score[1] += 1
	$Player/CPUParticles2D.visible = true
	$Player/CPUParticles2D2.visible = true
	$Hud/CPUScore.text = str(score[1])
	$BallTimer.start()

func _on_score_right_body_entered(_body: Node2D) -> void:
	score[0] += 100
	$Hud/PlayerScore.text = str(score[0])
	$BallTimer.start()
	
func explode_enemy():
	$CPU/CollisionShape2D.queue_free()
	$CPU/ColorRect.queue_free()
	$CPU/CPUParticles2D.visible = true
