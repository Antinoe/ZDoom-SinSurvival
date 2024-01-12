
Class SinFood : SinConsumable{
	string ingest; property Ingest : ingest; //Sound of consuming the food/drink.
	
	//	All properties below currently have no function.
	//	(Numbers are measured in grams.)
	int calories; property Calories : calories;
	int nutrients; property Nutrients : nutrients;
	
	//	The 7 Essential Nutrient Groups
	int carbohydrates; property Carbohydrates : carbohydrates;
	int proteins; property Proteins : proteins;
	int fats; property Fats : fats;
	int vitamins; property Vitamins : vitamins;
	int minerals; property Minerals : minerals;
	int fiber; property Fiber : fiber;
	int water; property Water : water;
	
	//	Basic Groups
	int grains; property Grains : grains;
	int meats; property Meats : meats;
	int vegetables; property Vegetables : vegetables;
	int fruits; property Fruits : fruits;
	int sugars; property Sugars : sugars;
	
	Default{
		Inventory.Icon "STIMA0";
		SinItem.Stackable 1;
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Tag "You shouldn't see this.";
		Inventory.PickupMessage "You shouldn't see this.";
		SinItem.Description "You shouldn't see this.";
		//	Using a Dwelling Sin sound because I can't find the path to Doom 2's sounds.
		SinFood.Ingest "weapons/load";
		//	Nutrients don't work yet, so this will be commented out.
		//SinFood.Calories 0;
	}
	Override bool Use(bool pickup){
		If(owner){
			let playe = SinPlayer(owner);
			If(playe&&playe.health<playe.maxhealth){owner.GiveBody(health,playe.maxhealth);}
			owner.A_StartSound(ingest,CHAN_AUTO,CHANF_OVERLAP);
			//	Yes, this method of applying nutrients is messy, but it'll do for now.
			//	(If I can even get it to work..)
			/*if (calories > 0) {owner.GiveInventory("Calories",calories);}
			if (calories < 0) {owner.TakeInventory("Calories",calories);}
			
			if (nutrients > 0) {owner.GiveInventory("Nutrients",nutrients);}
			if (nutrients < 0) {owner.TakeInventory("Nutrients",nutrients);}*/
			Amount--;
			If(Amount<1&&delempty){
				let invman = SinInvManager(owner.FindInventory("SinInvManager"));
				int index = invman.items.Find(self);
				If(index!=invman.items.Size()){
					invman.DeleteFrom(index);
					Destroy();
				}
			}
			Return 1;
		}
		//	This might be unnecessary.
		Return Super.Use(pickup);
		Return 0;
	}
	States{Spawn: STIM A -1; Stop;}
}

Class SinExampleFood : SinFood{
	Default{
		Inventory.Icon "STIMA0";
		Tag "Example Food";
		Health 40;
		Inventory.PickupMessage "Picked up a food package.";
		SinItem.Description "This will heal 40 HP and grant Regeneration for 10 seconds.";
	}
	//	Here, we grant a powerup upon ingesting the food item.
	Override bool Use(bool pickup){
		owner.GiveInventory("SinExamplePowerFood",1);
		//	"Super" is used to call the code of parent functions.
		//	Always include it when overriding Use().
		Return Super.Use(pickup);
		Return 0;
	}
	States{Spawn: STIM A -1; Stop;}
}

Class SinExamplePowerFood : PowerRegeneration{
	Default{
		Inventory.Icon "STIMA0";
		Powerup.Strength 1;
		Powerup.Duration -10;
	}
}

Class SinExampleFoodSpawner : RandomSpawner{
	Default{
		DropItem "SinExampleFood",255,1;
		DropItem "SinExampleFoodWeapon",255,1;
	}
}

//	Meals.

Class SinFoodWeapon : SinWeapon{
	Default{
		Inventory.Icon "MEDIA0";
		Tag "Food Weapon";
		Inventory.PickupSound "misc/i_pkup";
		AttackSound "Eatstim";
		Inventory.Amount 2;
		Inventory.MaxAmount 2;
		Inventory.PickupMessage "You shouldn't see this.";
		SinItem.Description "You shouldn't see this.";
		SinItem.RemoveWhenEmpty 1;
		SinWeapon.FireType FIRE_AUTO;
		SinWeapon.AttackType ATTACK_PROJECTILE;
		SinWeapon.FireMode1 1,60;
		//SinItem.BigItem 0;
	}
	States{Spawn: MEDI A -1; Stop;}
	Override void WeaponFire(SinPlayer shooter, SinHands gun){
		shooter.GiveInventory("Health",5);
		Super.WeaponFire(shooter,gun);
	}
}

Class SinExampleFoodWeapon : SinFoodWeapon{
	Default{
		Inventory.Icon "STIMA0";
		Tag "You shouldn't see this";
		AttackSound "items/eatapple";
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
