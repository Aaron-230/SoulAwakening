extends CanvasLayer

func _ready():
	Game.Health.connect(_changeHealth)
	Game.ChangedCoins.connect(_changeCoins)
	Game.ChangedPoints.connect(_changePoints)

func _changeHealth(NewHealth):
	$Health/HealthBar.value = float(NewHealth)
	if NewHealth <= 0:
		Game.RestartGame()
		get_tree().reload_current_scene()

func _changeCoins(CoinsAdded):
	$Coin/Counter.text = str(CoinsAdded)

func _changePoints(PointsAdded):
	$Points.text = str(PointsAdded)
