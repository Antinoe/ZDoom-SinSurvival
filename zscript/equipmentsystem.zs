
//	Dummy items.
//	Check if these are within the inventory when equipping slot-specific items.
//	Example:
/*
Class ExampleBoots : SinTool{
	let bootSlot = owner.FindInventory("BootsSlot",1);
	//	If nothing is in the Boots slot.
	If(!bootSlot){owner.GiveInventory("ExampleBoots",1);}
}
*/
//	I need to get this working.
Class EquipmentSlot : Inventory{Default{Inventory.Amount 1;Inventory.MaxAmount 1;}}
Class FeetSlot : EquipmentSlot{}
Class LegsSlot : EquipmentSlot{}
Class ChestSlot : EquipmentSlot{}
Class HeadSlot : EquipmentSlot{}

Class SinApparel : SinTool abstract{
	//	Primary, Secondary and Tertiary powers granted when the apparel is equipped.
	string power1; property Power1 : power1;
	string power2; property Power2 : power2;
	string power3; property Power3 : power3;
	//	What slot the item accompanies.
	enum SinSlot{
		SLOT_FEET = 0,
		SLOT_LEGS = 1,
		SLOT_CHEST = 2,
		SLOT_HEAD = 3
	}
	int slot; property Slot : slot; //	The slot this item goes in, refer to SinSlot.
	int insulation; property Insulation : insulation;
	Default{
		Inventory.Icon "STIMA0";
		Tag "Sin Apparel";
		Inventory.PickupMessage "You shouldn't see this.";
		SinItem.Description "You shouldn't see this.";
		SinItem.RemoveWhenEmpty 1;
		//SinApparel.Power1 "PowerProtection";
		//SinApparel.Slot SLOT_CHEST;
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		let feet = owner.FindInventory("FeetSlot",1);
		let legs = owner.FindInventory("LegsSlot",1);
		let chest = owner.FindInventory("ChestSlot",1);
		let head = owner.FindInventory("HeadSlot",1);
		//	If not active, equip.
		If(!active){
			//	If slot is #### and lack ####...
			If(slot==0&&!feet){active=1;}
			If(slot==1&&!legs){active=1;}
			If(slot==2&&!chest){active=1;}
			If(slot==3&&!head){active=1;}
		}
		//	Otherwise, if it *is* active, unequip.
		Else{active=0;}
		HandleSprite();
		Return 0;
	}
	Override void DoEffect(){
		//	Equipping.
		If(active){
			owner.GiveInventory(power1,1);
			owner.GiveInventory(power2,1);
			owner.GiveInventory(power3,1);
		}
		//	Unequipping.
		Else{
			owner.TakeInventory(power1,1);
			owner.TakeInventory(power2,1);
			owner.TakeInventory(power3,1);
		}
	}
	//	Discarding.
	Override void DetachFromOwner(){
		active=0;
		owner.TakeInventory(power1,1);
		owner.TakeInventory(power2,1);
		owner.TakeInventory(power3,1);
		HandleSprite();
	}
}

//	A backup, just in case the WIP one is irrepairable.
/*
Class SinApparel : SinTool{
	//	Primary, Secondary and Tertiary powers granted when the apparel is equipped.
	string power1; property Power1 : power1;
	string power2; property Power2 : power2;
	string power3; property Power3 : power3;
	//	What slot the item accompanies.
	enum SinSlot{
		SLOT_FEET = 0,
		SLOT_LEGS = 1,
		SLOT_CHEST = 2,
		SLOT_HEAD = 3
	}
	int slot; property Slot : slot; //	The slot this item goes in, refer to SinSlot.
	int insulation; property Insulation : insulation;
	Default{
		Inventory.Icon "STIMA0";
		Tag "Sin Apparel";
		Inventory.PickupMessage "You shouldn't see this.";
		SinItem.Description "You shouldn't see this.";
		SinItem.RemoveWhenEmpty 1;
		//SinApparel.Power1 "PowerClothes";
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		If(!active){active=1;}
		Else{active=0;}
		HandleSprite();
		Return 0;
	}
	Override void DoEffect(){
		If(active){
			owner.GiveInventory(power1,1);
			owner.GiveInventory(power2,1);
			owner.GiveInventory(power3,1);
		}
		Else{
		owner.TakeInventory(power1,1);
		owner.TakeInventory(power2,1);
		owner.TakeInventory(power3,1);
		}
	}
	Override void DetachFromOwner(){
		active=0;
		owner.TakeInventory(power1,1);
		owner.TakeInventory(power2,1);
		owner.TakeInventory(power3,1);
		HandleSprite();
	}
}
*/
