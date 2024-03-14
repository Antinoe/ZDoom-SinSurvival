
Class SinExampleFood : SinFood{
	Default{
		Inventory.Icon "STIMA0";
		Tag "Example Food";
		Inventory.PickupMessage "Picked up example food.";
		SinFood.BonusHealth 20;
		SinFood.Ingest "EatGeneric";
		SinItem.Description "[+20 BNS HP]\n[-0% DMG]\n[+120 REG]\n[+50% SPD]";
		SinFood.Power1 "PowerProtection";
		SinFood.Power2 "PowerRegeneration";
		SinFood.Power3 "PowerSpeed";
	}
	//	In case 3 wasn't enough, we grant a 4th additional powerup upon ingesting the food item.
	Override bool Use(bool pickup){
		owner.GiveInventory("PowerBuddha",1);
		//	"Super" is used to call the code of parent functions.
		//	Always include it when overriding hooks.
		Return Super.Use(pickup);
		Return 0;
	}
	States{Spawn: STIM A -1; Stop;}
}

Class SinExampleFoodSpawner : RandomSpawner{
	Default{
		DropItem "SinExampleFood",255,1;
		DropItem "SinExampleFoodWeapon",255,1;
	}
}

Class SinExampleFoodWeapon : SinMeal{
	Default{
		Inventory.Icon "STIMA0";
		Tag "You shouldn't see this";
		AttackSound "weapons/load";
		Inventory.Amount 16;
		Inventory.MaxAmount 16;
		Inventory.PickupMessage "You shouldn't see this.";
		SinItem.Description "You shouldn't see this.";
	}
	States{Spawn: STIM A -1; Stop;}
	Override void WeaponFire(SinPlayer shooter, SinHands gun){
		Super.WeaponFire(shooter,gun);
	}
}
