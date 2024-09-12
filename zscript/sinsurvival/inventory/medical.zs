
Class SinSurvivalHealing : SinHealing abstract{
	//	Need to work on this one.
	bool healAll; property HealAll : healAll; //Whether the item heals all injuries or not.
	string injury1; property Injury1 : injury1; //The primary type of injury to heal from.
	string injury2; property Injury2 : injury2; //The secondary type of injury to heal from.
	string injury3; property Injury3 : injury3; //The tertiary type of injury to heal from.
	Override bool Use(bool pickup){
		If(owner){
			let injurytype1 = owner.FindInventory(injury1);
			let injurytype2 = owner.FindInventory(injury2);
			let injurytype3 = owner.FindInventory(injury3);
			//	If not injury types 1-3, return..
			if(injurytype1 || injurytype2 || injurytype3){
				if(injurytype1){owner.GiveBody(health); owner.TakeInventory(injury1,health);}
				if(injurytype2){owner.GiveBody(health); owner.TakeInventory(injury2,health);}
				if(injurytype3){owner.GiveBody(health); owner.TakeInventory(injury3,health);}
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
		}
		Return 0;
	}
}
//
//	Analgesic
Class SinSurvivalPotionGreen : SinPowerup{
	Default{
		Inventory.Icon "POT1A0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "$SINITEM_POTIONGPKUP";
		Tag "$SINITEM_POTIONG";
		SinItem.Description "$SINITEM_POTIONGDESC";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "SinSurvivalPowerOpium";
	}
	States{Spawn: POT1 A -1; Stop;}
}
//	Adrenaline
Class SinSurvivalPotionRed : SinPowerup{
	Default{
		Inventory.Icon "POT2A0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "$SINITEM_POTIONGPKUP";
		Tag "$SINITEM_POTIONR";
		SinItem.Description "$SINITEM_POTIONGDESC";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "SinSurvivalPowerAdrenaline";
	}
	States{Spawn: POT2 A -1; Stop;}
}
//	Antidote
Class SinSurvivalPotionBlue : SinHealing{
	Default{
		Inventory.Icon "POT3A0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "$SINITEM_POTIONGPKUP";
		Tag "Blue Potion";
		Health 5;
		SinItem.Description "$SINITEM_POTIONGDESC";
		SinItem.Stackable 1;
	}
	States{Spawn: POT3 A -1; Stop;}
	Override bool Use(bool pickup){
		If(owner){
			owner.TakeInventory("InjuryBluntForceTrauma",5);
			owner.TakeInventory("InjuryLaceration",5);
			owner.TakeInventory("InjuryGunshotWound",5);
			owner.TakeInventory("InjuryDeepTissueInjury",5);
			owner.TakeInventory("InjuryBleeding",5);
			owner.TakeInventory("InjuryBurn",5);
			owner.TakeInventory("InjurySepsis",5);
			owner.TakeInventory("InjuryForeignBody",1);
		}
		return super.Use(pickup);
	}
}
//	Steroids
Class SinSurvivalPotionYellow : SinPowerup{
	Default{
		Inventory.Icon "POT3A0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "$SINITEM_POTIONGPKUP";
		Tag "Yellow Potion";
		SinItem.Description "$SINITEM_POTIONGDESC";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "SinSurvivalPowerSteroids";
	}
	States{Spawn: POT3 A -1; Stop;}
}
//
Class SinSurvivalStimpack : SinConsumable{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "Picked up a Stimpack.";
		Tag "Stimpack";
		SinItem.Description "A small pouch containing some essential medical supplies.";
		SinItem.Stackable 1;
	}
	Override bool Use(bool pickup){
		If(owner){
			owner.A_SpawnItem("SinSurvivalGelIcePack",1);
			owner.A_SpawnItem("SinSurvivalBandage",1);
			owner.A_SpawnItem("SinSurvivalSuture",1);
			owner.A_SpawnItem("SinSurvivalBurnSalve",1);
			owner.A_SpawnItem("SinSurvivalTweezers",1);
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
		Return 0;
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalMedikit : SinConsumable{
	Default{
		Inventory.Icon "MEDIA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "Picked up a Medikit.";
		Tag "Medical Kit";
		SinItem.Description "A trauma kit containing essential medical supplies.";
		SinItem.Stackable 1;
	}
	Override bool Use(bool pickup){
		If(owner){
			owner.A_SpawnItem("SinSurvivalGelIcePack",1);
			owner.A_SpawnItem("SinSurvivalGelIcePack",1);
			owner.A_SpawnItem("SinSurvivalBandage",1);
			owner.A_SpawnItem("SinSurvivalBandage",1);
			owner.A_SpawnItem("SinSurvivalSuture",1);
			owner.A_SpawnItem("SinSurvivalSuture",1);
			owner.A_SpawnItem("SinSurvivalBurnSalve",1);
			owner.A_SpawnItem("SinSurvivalBurnSalve",1);
			owner.A_SpawnItem("SinSurvivalTweezers",1);
			owner.A_SpawnItem("SinSurvivalTweezers",1);
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
		Return 0;
	}
	States{Spawn: MEDI A -1; Stop;}
}
Class SinSurvivalGelIcePack : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 16;
		Inventory.PickupMessage "Picked up an Ice Pack.";
		Tag "Gel Ice Pack";
		Health 10;
		SinItem.Description "A very cold pack of ice. Mild relief when applied to bruises.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjuryBluntForceTrauma";
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalTweezers : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 4;
		Inventory.MaxAmount 32;
		Inventory.PickupMessage "Picked up a pair of Tweezers.";
		Tag "Tweezers";
		Health 1;
		SinItem.Description "A pair of tweezers. Used in the extraction of bullets and loose fragments.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjuryForeignBody";
	}
	Override bool Use(bool pickup){
		owner.GiveInventory("InjuryLaceration",1);
		//if(owner.health == 1){A_DamageSelf(1);}
		//else{owner.A_SetHealth(owner.health -= 1);}
		A_DamageSelf(1);
		return super.Use(pickup);
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalSuture : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 16;
		Inventory.PickupMessage "Picked up a Suture.";
		Tag "Suture";
		Health 10;
		SinItem.Description "Bio-degradable stitches meant for closing up wounds.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjuryLaceration";
		SinSurvivalHealing.Injury2 "InjuryGunshotWound";
		SinSurvivalHealing.Injury3 "InjuryDeepTissueInjury";
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalBandage : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 8;
		Inventory.PickupMessage "Picked up a Bandage.";
		Tag "Bandage";
		Health 10;
		SinItem.Description "Basic medical bandages for the purpose of stanching the flow of bleeding, to protect against bacterial infection, and for the application of casts.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjuryBleeding";
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalBurnSalve : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 8;
		Inventory.PickupMessage "Picked up a plastic jar of burn ointment.";
		Tag "Burn Salve";
		Health 10;
		SinItem.Description "A small, plastic jar of ointment, useful in the treatment of burns.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjuryBurn";
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalAlcoholBottle : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 4;
		Inventory.MaxAmount 16;
		Inventory.PickupMessage "Picked up a plastic bottle of alcohol.";
		Tag "Alcohol Bottle";
		Health 10;
		SinItem.Description "A plastic bottle of Isopropanol Alcohol. Combine with Bandages to make Alcohol Wipes.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjurySepsis";
	}
	States{Spawn: STIM A -1; Stop;}
}
Class SinSurvivalAlcoholWipe : SinSurvivalHealing{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 16;
		Inventory.PickupMessage "Picked up a roll of alcohol wipes.";
		Tag "Alcohol Wipe";
		Health 10;
		SinItem.Description "A sliver of cloth, soaked in Isopropanol Alcohol. Useful for the treatment and prevention of infection.";
		SinItem.Stackable 1;
		SinSurvivalHealing.Injury1 "InjurySepsis";
	}
	States{Spawn: STIM A -1; Stop;}
}
//
Class SinSurvivalMedicalSpawner : RandomSpawner{
	Default{
		DropItem "SinSurvivalGelIcePack";
		DropItem "SinSurvivalBandage";
		DropItem "SinSurvivalSuture";
		DropItem "SinSurvivalBurnSalve";
		DropItem "SinSurvivalTweezers";
	}
}
Class SinSurvivalPotionSpawner : RandomSpawner{
	Default{
		DropItem "SinSurvivalPotionGreen";
		DropItem "SinSurvivalPotionRed";
		DropItem "SinSurvivalPotionBlue";
		DropItem "SinSurvivalPotionYellow";
	}
}
Class SinSurvivalRecipeStimack : SinRecipe{
	Default{
		SinRecipe.Ingredients "SinSurvivalPotionGreen", "SinSurvivalPotionRed";
		SinRecipe.Result "SinSurvivalStimpack", 1;
	}
}