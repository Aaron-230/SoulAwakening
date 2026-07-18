extends Node

var MaxHealth: int = 1000
var CurrentHealth = MaxHealth
var Points: int = 0
var Coins: int = 0

signal Health(NewHealth)
signal ChangedPoints(NewPoints)
signal ChangedCoins(CoinsAdded)
signal PlayerDied()

func takeDamage(Amount):
	CurrentHealth -= Amount
	CurrentHealth = clamp(CurrentHealth, 0, MaxHealth)
	Health.emit(CurrentHealth)
	
	if CurrentHealth <= 0:
		PlayerDied.emit()

func Heal(Amount):
	CurrentHealth += Amount
	CurrentHealth = clamp(CurrentHealth, 0, MaxHealth)
	Health.emit(CurrentHealth)

func addPoints(Amount):
	Points += Amount
	ChangedPoints.emit(Points)

func addCoins(Amount):
	Coins += Amount
	ChangedCoins.emit(Coins)

func ResetHealth():
	CurrentHealth = MaxHealth
	Health.emit(CurrentHealth)

func RestartGame():
	CurrentHealth = MaxHealth
	Points = 0
	Coins = 0 
	Health.emit(CurrentHealth)
	ChangedPoints.emit(Points)
	ChangedCoins.emit(Coins)
