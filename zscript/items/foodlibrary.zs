
Class SinFood : SinConsumable{
	string ingest; property Ingest : ingest; //	Sound Sequence upon consuming food/drink.
	string ingestbasic; property IngestBasic : ingestbasic; //	Single sound of consuming food/drink.
	string power1; property Power1 : power1;
	string power2; property Power2 : power2;
	string power3; property Power3 : power3;
	int bonushealth; property BonusHealth : bonushealth; //	Similar to SinHealing's healmax, except this can be used on its own.
	int maxbonushealth; property BonusHealthMax : maxbonushealth;
	
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
		//SinFood.IngestBasic "weapons/load";
		//	Nutrients don't work yet, so this will be commented out.
		//SinFood.Calories 0;
		SinFood.BonusHealthMax 50;
	}
	Override bool Use(bool pickup){
		If(owner){
			let playe = SinPlayer(owner);
			//If(playe&&playe.health<playe.maxhealth){owner.GiveBody(health,playe.maxhealth);}
			//	Bonus Health scales with Player Max Health. (50 * 50 / 8 = 312)
			//	I think I'll use the 9999 formula instead for now.
			//owner.GiveBody(bonushealth,maxbonushealth*playe.maxhealth/8);
			//	Food will never go to waste.
			owner.GiveBody(bonushealth,9999);
			owner.GiveInventory(ingest,1);
			owner.A_StartSound(ingestbasic,CHAN_AUTO,CHANF_OVERLAP);
			owner.GiveInventory(power1,1);
			owner.GiveInventory(power2,1);
			owner.GiveInventory(power3,1);
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
		HandleSprite(pickup);
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

//
//	Meals
//

Class SinMeal : SinWeapon{
	
	Default{
		Inventory.Icon "MEDIA0";
		Tag "Meal";
		Inventory.PickupSound "misc/i_pkup";
		AttackSound "weapons/load";
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

//
//	Eating/Drinking Sound Sequences
//

Class PowerEating : PowerRegeneration
{
	string sound; property Sound : sound;
	Default
	{
		Powerup.Duration -2;
		Powerup.Strength 0;
		//Inventory.Icon "STIMA0";
		//PowerEating.Sound "items/food/chew";
	}
	Virtual void Bite(){
		owner.GiveBody(random(sinfood_bitehealmin,sinfood_bitehealmax),9999);
		owner.A_StartSound(sound,CHAN_AUTO,CHANF_OVERLAP);
	}
	Virtual void Swallow(){
		owner.GiveBody(random(sinfood_bitehealmin,sinfood_bitehealmax),9999);
		owner.A_StartSound("items/food/swallow",CHAN_AUTO,CHANF_OVERLAP);
	}
	Override void DoEffect(){
		//Super.DoEffect();
		//owner.A_StartSound("items/food/chew",CHAN_AUTO,CHANF_OVERLAP);
		If(EffectTics == 70){Swallow();}
	}
}
Class PowerEatingDouble : PowerEating
{
	Override void DoEffect(){
		//Super.DoEffect();
		If(EffectTics == 70){Bite();}
		If(EffectTics == 55){Swallow();}
	}
}
Class PowerEatingTriple : PowerEating
{
	Override void DoEffect(){
		//Super.DoEffect();
		If(EffectTics == 70){Bite();}
		If(EffectTics == 55){Bite();}
		If(EffectTics == 40){Swallow();}
	}
}
Class PowerEatingQuadruple : PowerEating
{
	Override void DoEffect(){
		//Super.DoEffect();
		If(EffectTics == 70){Bite();}
		If(EffectTics == 55){Bite();}
		If(EffectTics == 40){Bite();}
		If(EffectTics == 25){Swallow();}
	}
}
Class EatGenericSingle : PowerEating	{Default{PowerEating.Sound "items/food/chew";}}
Class EatGeneric : PowerEatingTriple	{Default{PowerEating.Sound "items/food/chew";}}
Class EatApple : PowerEatingQuadruple	{Default{PowerEating.Sound "items/food/apple";}}
Class EatCarrot : PowerEatingQuadruple	{Default{PowerEating.Sound "items/food/carrot";}}
Class EatCelery : PowerEatingDouble	{Default{PowerEating.Sound "items/food/celery";}}
Class EatPeach : PowerEatingQuadruple	{Default{PowerEating.Sound "items/food/peach";}}
Class EatPear : PowerEatingQuadruple	{Default{PowerEating.Sound "items/food/pear";}}
