
Class SinSurvivalStats : EventHandler{
	Override void WorldThingSpawned(WorldEvent e){
		If(e.thing&&e.thing is "SinPlayer"){
			let playe = SinPlayer(e.thing);
			int vigor = playe.health/5;
			int endurance = playe.maxstamin/5;
			playe.GiveInventory("SinVigor",vigor);
			playe.GiveInventory("SinEndurance",endurance);
			playe.GiveInventory("SinFocus",50);
			playe.GiveInventory("SinHunger",100);
			playe.GiveInventory("SinThirst",100);
		}
	}
}
