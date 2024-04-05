
Class SurvivalMechanics : EventHandler{
	Override void WorldThingSpawned(WorldEvent e){
		If(!e.Thing) return;
		//If(cvar.GetCVar('survivallibrary_needs').getbool()){GiveNeeds(e.Thing);}
		If(survivallibrary_needs){GiveNeeds(e.Thing);}
	}
	static bool IsVoodooDoll(PlayerPawn mo){return !mo.player || !mo.player.mo || mo.player.mo != mo;}
	void GiveNeeds(Actor mo){
		bool isPlayer = (mo is "PlayerPawn");
		//	I need to get this working.
		//	The very first map of Doom 2 In City Only features Voodoo Dolls.
		//bool isVoodoo = IsVoodooDoll(mo);
		bool isMonster = mo.bIsMonster;
		bool isBoss = mo.bBoss;
		If(isPlayer){
			let hunger = mo.FindInventory("HungerAmount",1);If(!hunger){mo.A_GiveInventory("HungerAmount",100);}
			let thirst = mo.FindInventory("ThirstAmount",1);If(!thirst){mo.A_GiveInventory("ThirstAmount",100);}
			let sleep = mo.FindInventory("SleepAmount",1);If(!sleep){mo.A_GiveInventory("SleepAmount",100);}
			let blood = mo.FindInventory("BloodAmount",1);If(!blood){mo.A_GiveInventory("BloodAmount",100);}
			let resolve = mo.FindInventory("ResolveAmount",1);If(!resolve){mo.A_GiveInventory("ResolveAmount",100);}
			let blink = mo.FindInventory("Blink",1);If(!blink){mo.A_GiveInventory("Blink",100);}
			//let stress = mo.FindInventory("Stress",1);If(!stress){mo.A_GiveInventory("Stress",1);}
			//let sanity = mo.FindInventory("Sanity",1);If(!sanity){mo.A_GiveInventory("Sanity",100);}
			//let urine = mo.FindInventory("Urine",1);If(!urine){mo.A_GiveInventory("Urine",1);}
			//let heartBeat = mo.FindInventory("HeartBeat",1);If(!heartBeat){mo.A_GiveInventory("HeartBeat",1);}
		}
	}
	Override void WorldThingDamaged(WorldEvent e){
		//	If thing has Blink, give IsBlinking.
		//Actor mo;
		//let blink = mo.FindInventory("Blink",1);
		//If(blink){mo.GiveInventory("IsBlinking",1);}
	}
}

Class SurvivalAmount : Inventory abstract{
	Default{
		+Inventory.UNDROPPABLE;
		+Inventory.UNTOSSABLE;
		Inventory.Amount 1;
		Inventory.MaxAmount 100;
		//Powerup.Duration 0x7FFFFFFF;
		//Powerup.Duration 70;
	}
	Override bool TryPickup(in out Actor toucher){Return Super.TryPickup(toucher);}
	Override void Tick(){
		If(owner){
			If(Amount<=100){}
			If(Amount<=75){}
			If(Amount<=50){}
			If(Amount<=25){}
		}
	}
	Override void DetachFromOwner(){
		If(owner){
		}
	}
}
Class HungerAmount : SurvivalAmount{
}
Class ThirstAmount : SurvivalAmount{
}
Class SweatAmount : SurvivalAmount{
}
Class SleepAmount : SurvivalAmount{
}
Class BloodAmount : SurvivalAmount{
}
Class ResolveAmount : SurvivalAmount{
}
//	Blinking ability.
Class Blink : SurvivalAmount{
	Default{
		Inventory.Amount 350;
		Inventory.MaxAmount 350;
		//Powerup.Duration 0x7FFFFFFF;
		//Powerup.Color "";
	}
	Override bool TryPickup(in out Actor toucher){
		If(owner){
			Amount=35;
		}
		Return Super.TryPickup(toucher);
	}
	Override void Tick(){
		If(owner){
			Amount--;
			If(Amount==1){
				Blink();
				Amount=random(175,350);
			}
		}
	}
	Override void DetachFromOwner(){If(owner){}}
	Virtual bool Blink(){
		owner.GiveInventory("IsBlinking",1);
		Return true;
	}
}
Class IsBlinking : Powerup{
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Powerup.Duration 2;
	}
	Override void InitEffect(){owner.A_SetBlend("Black",1,15);}
}
