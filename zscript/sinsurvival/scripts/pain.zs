
Class SinSurvivalPain : EventHandler{
	Override void WorldThingDamaged(WorldEvent e){
		If(e.damage>0&&e.thing&&e.thing.health>0&&e.thing.player&&e.thing.player.mo){
			let playe = e.thing.player.mo;
			let analgesic = playe.FindInventory("SinAnalgesic");
			let poise = playe.FindInventory("SinPoise");
			let posture = playe.FindInventory("SinPosture");
			/*
			let poiseFormula1 = (e.damage*(1-(poise.amount/(poise.amount+50))));
			let poiseFormula2 = (-e.damage*(1-(poise.amount/(poise.amount+50))));
			*/
			If(!analgesic){
				playe.A_SetBlend("DarkRed",1,10);
				If(poise&&posture){
					let poiseFormula = (e.damage-poise.amount);
					playe.A_Quake(poiseFormula,5,0,100,0);
					playe.A_SetAngle(playe.angle+frandom[flashx](-poiseFormula,poiseFormula));
					playe.A_SetPitch(playe.pitch+frandom[flashy](-poiseFormula,poiseFormula));
					playe.TakeInventory("SinPosture",e.damage);
					playe.A_Log("Remaining Posture: "..posture.amount);
				}
				Else{
					playe.A_Quake(e.damage,5,0,100,0);
					playe.A_SetAngle(playe.angle+frandom[flashx](-e.damage,e.damage));
					playe.A_SetPitch(playe.pitch+frandom[flashy](-e.damage,e.damage));
					playe.A_Log("No Poise left!");
				}
			}
		}
	}
}
