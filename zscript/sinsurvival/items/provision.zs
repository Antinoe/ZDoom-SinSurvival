
Class SinProvision : SinPowerup abstract{
	string consumeSound; property ConsumeSound : consumeSound;
	Class<Actor> cookItem; property CookItem : cookItem; //The item given when cooked.
	string sliceSound; property SliceSound : sliceSound; //The sound played when combining with a Knife/Dagger.
	Class<Actor> sliceItem; property SliceItem : sliceItem; //The item given when combined with a Knife/Dagger.
	int hunger; property Hunger : hunger;
	int thirst; property Thirst : thirst;
	int meats; property Meats : meats;
	int grains; property Grains : grains;
	int fruits; property Fruits : fruits;
	int vegetables; property Vegetables : vegetables;
	int salts; property Salts : salts;
	int sugars; property Sugars : sugars;
	Default{
		Inventory.PickupSound "misc/i_pkup";
		Inventory.Amount 1;
		Inventory.MaxAmount 10;
		SinItem.Stackable 1;
		SinItem.RemoveWhenEmpty 1;
		SinItem.RandomType RAND_ITEM;
		SinItem.SpawnSaveDrives 0;
	}
	Override bool Combine(SinItem other, SinInvManager invman){
		If(invman.items.Size()>=invman.MaxSlots){Return 0;}
		If(self.sliceItem==null){Return 0;}
		If(other.subtag=="Knife" || other.subtag=="Dagger"){
			let item = SinItem(owner.Spawn(sliceItem,owner.pos));
			If(item){
				//item.AttachToOwner(owner);
				item.Amount=2;
				item.SinfulPickup(invman);
			}
			owner.A_StartSound(sliceSound,CHAN_AUTO,CHANF_OVERLAP);
			If(other.amount>0){other.amount--;}
			Else{other.TakeAmount(1,invman);}
			self.TakeAmount(1,invman);
			Return 1;
		}
		Return 0;
	}
	Override bool Use(bool pickup){
		let hungerValue = owner.FindInventory("SinHunger").amount;
		let thirstValue = owner.FindInventory("SinThirst").amount;
		If(owner){
			owner.A_StartSound(consumeSound,CHAN_AUTO,CHANF_OVERLAP);
			If(hunger>0&&hungerValue<100){owner.GiveInventory("SinHunger",hunger);}
			If(thirst>0&&thirstValue<100){owner.GiveInventory("SinThirst",thirst);}
			If(meats>0){owner.GiveInventory("SinMeats",meats);}
			If(grains>0){owner.GiveInventory("SinGrains",grains);}
			If(fruits>0){owner.GiveInventory("SinFruits",fruits);}
			If(vegetables>0){owner.GiveInventory("SinVegetables",vegetables);}
			If(salts>0){owner.GiveInventory("SinSalts",salts);}
			If(sugars>0){owner.GiveInventory("SinSugars",sugars);}
		}
		Return Super.Use(pickup);
	}
}
