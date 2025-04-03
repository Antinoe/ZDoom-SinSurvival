
//////////
//	Base Attire Class
//////////
/*
Class SlotBody : Inventory{Default{Inventory.Amount 1; Inventory.MaxAmount 1;}}
Class SlotOuterwear : Inventory{Default{Inventory.Amount 1; Inventory.MaxAmount 1;}}
Class SlotHead : Inventory{Default{Inventory.Amount 1; Inventory.MaxAmount 1;}}
*/
Class SinAttire : SinTool abstract{
	enum SinSlot{
		NONE=0,
		BODY=1,
		OUTERWEAR=2,
		HEAD=3
	}
	int slot; property Slot : slot; //Where to equip the item, refer to SinSlot.
	int defense; property Defense : defense; //How many points of Damage this subtracts.
	bool equipped;
	Default{
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		SinItem.Stackable 0;
		SinItem.RemoveWhenEmpty 1;
		SinAttire.Slot NONE;
	}
	Override bool Use(bool pickup){
		//	WORK: Optimize this. 4 lines can probably be squashed down into 1.
		//If(owner.slot==1&&self.slot==1){Return 0;}
		//If(owner.slot==2&&self.slot==2){Return 0;}
		//If(owner.slot==3&&self.slot==3){Return 0;}
		If(!equipped){Equip();}
		Else{Unequip();}
		Return 1;
	}
	Virtual void Equip(){
		equipped=1;
		//	NOTE: Failed attempt at ensuring you can't equip attire on the same slot..
		/*
		let isWearing1=owner.FindInventory("SlotBody");
		let isWearing2=owner.FindInventory("SlotOuterwear");
		let isWearing3=owner.FindInventory("SlotHead");
		If(slot==1&&!isWearing1){owner.GiveInventory("SlotBody",1); equipped=1;}
		If(slot==2&&!isWearing2){owner.GiveInventory("SlotOuterwear",1); equipped=1;}
		If(slot==3&&!isWearing3){owner.GiveInventory("SlotHead",1); equipped=1;}
		*/
	}
	Virtual void Unequip(){
		equipped=0;
	}
	Override void DetachFromOwner(){
		Unequip();
	}
}

//////////
//	Items
//////////
/*
Class SinSurvivalRadSuit : SinAttire replaces SinRadSuit{
	Default{
		Height 48;
		Inventory.Icon "I_SUIT";
		Tag "$SINITEM_RADSUIT";
		Inventory.PickupMessage "$SINITEM_RADSUITPKUP";
		SinItem.Description "$SINITEM_RADSUITDESC";
		SinItem.RandomType RAND_NONE;
		SinItem.RemoveWhenEmpty 1;
		SinItem.SpawnSaveDrives 1;
		SinAttire.Slot OUTERWEAR;
	}
	States{Spawn: SUIT A -1; Stop;}
	Override void Equip(){owner.GiveInventory("SinIronFeet",1); Super.Equip();}
	Override void Unequip(){owner.TakeInventory("SinIronFeet",999); Super.Unequip();}
	Override void DoEffect(){
		let suit=SinIronFeet(owner.FindInventory("SinIronFeet"));
		If(suit&&equipped){suit.EffectTics=255;}
		//Else{owner.GiveInventory("SinIronFeet",1);}
	}
}
Class SinSurvivalInfrared : SinAttire replaces SinInfrared{
	int delta;
	Default{
		Inventory.Icon "PVISB0";
		Tag "$SINITEM_INFRARED";
		Inventory.Amount 100;
		Inventory.MaxAmount 100;
		Inventory.PickupMessage "$SINITEM_INFRAREDPKUP";
		SinItem.Description "$SINITEM_INFRAREDDESC";
		SinItem.OnBattery 1;
		SinItem.SpawnSaveDrives 1;
		SinAttire.Slot HEAD;
	}
	States{Spawn: PVIS B -1; Stop;}
	Override void HandleSprite(int status){
		string ico = "PVIS";
		If(active){ico=ico.."A0";}
		Else{ico=ico.."B0";}
		icon=TexMan.CheckForTexture(ico,TexMan.Type_Any);
	}
	Override bool Use(bool pickup){
		let invman = SinInvManager(owner.FindInventory("SinInvManager"));
		If(!invman){Return 0;}
		For(int i=0; i<invman.items.Size(); i++){
			If(invman.items[i] is "SinInfrared"){
				If(invman.items[i]!=self){Return 0;}
				Else{Break;}
			}
		}
		If(Amount>0){
			If(!active){active=1;}
			Else{active=0;}
			HandleSprite();
		}
		Return Super.Use(pickup);
	}
	Override void DoEffect(){
		let invman = SinInvManager(owner.FindInventory("SinInvManager"));
		If(!invman){Return;}
		For(int i=0; i<invman.items.Size(); i++){
			If(invman.items[i] is "SinInfrared"){
				If(invman.items[i]!=self){active=0; HandleSprite(); Return;}
				Else{Break;}
			}
		}
		If(active){
			let amp = PowerLightAmp(owner.FindInventory("PowerLightAmp"));
			If(amp){amp.EffectTics=255;}
			Else{owner.GiveInventory("PowerLightAmp",1);}
			delta++;
			If(delta>=105){Amount--; delta=0;}
			If(Amount<1){
				active=0;
				owner.A_StartSound("tools/turnoff",CHAN_ITEM);
				HandleSprite();
			}
		}Else{owner.TakeInventory("PowerLightAmp",1);}
	}
	Override void DetachFromOwner(){
		active=0;
		owner.TakeInventory("PowerLightAmp",1);
		HandleSprite();
	}
}
*/
