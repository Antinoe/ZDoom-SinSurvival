
Class SinSurvivalMedicalSpawner : RandomSpawner{
	Default{
		//DropItem "SinSurvivalAlcoholWipe";
		DropItem "SinSurvivalAntibioticGlue";
		DropItem "SinSurvivalBandage";
		DropItem "SinSurvivalGelIcePack";
		DropItem "SinSurvivalSaline";
		DropItem "SinSurvivalSuture";
		DropItem "SinSurvivalTweezers";
	}
}
Class SinSurvivalPotionSpawner : RandomSpawner{
	Default{
		DropItem "SinSurvivalPotionGreen";
		DropItem "SinSurvivalPotionRed";
		DropItem "SinSurvivalPotionBlue";
		//DropItem "SinSurvivalPotionYellow";
	}
}
Class SinSurvivalRecipeStimack : SinRecipe{
	Default{
		SinRecipe.Ingredients "SinSurvivalPotionGreen", "SinSurvivalPotionRed";
		SinRecipe.Result "SinSurvivalStimpack", 1;
	}
}
Class SinSurvivalAlcoholWipe : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a stack of Alcohol Wipes.";
		Tag "Alcohol Wipes";
		SinItem.Description "Small, pre-moistened cloths saturated with isopropyl alcohol or ethanol, used to \c[green]disinfect\c[grey] skin or surfaces by killing bacteria. They are commonly used in medical settings for cleaning the skin before injections or treating \c[green]minor wounds\c[grey].";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "";
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("HealSepsis",5);
		Return Super.Use(pickup);
	}
}
Class SinSurvivalAntibioticGlue : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a bottle of Antibiotic Glue.";
		Tag "Antibiotic Glue";
		SinItem.Description "A medical adhesive infused with antimicrobial agents, used to close \c[green]minor cuts and wounds\c[grey] while preventing \c[green]infection\c[grey]. It forms a protective barrier over the injury, promoting \c[green]healing\c[grey] without the need for stitches in less severe cases.";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "";
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("HealBurn",5);
		owner.GiveInventory("HealSepsis",5);
		owner.GiveInventory("HealLaceration",5);
		Return Super.Use(pickup);
	}
}
Class SinSurvivalBandage : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a Bandage.";
		Tag "Bandage";
		SinItem.Description "Strips of fabric or gauze used to cover wounds, protect injured areas, and support healing by keeping the area clean and secure. They come in various forms, such as adhesive strips or elastic wraps, and are commonly used in first aid to stop \c[green]bleeding\c[grey] and provide \c[green]compression\c[grey].";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("HealLaceration",10);
		owner.TakeInventory("InjuryBleeding",10);
		owner.GiveBody(10);
		Return Super.Use(pickup);
	}
}
Class SinSurvivalGelIcePack : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a Gel Ice Pack.";
		Tag "Gel Ice Pack";
		SinItem.Description "A flexible, reusable pouch filled with gel that retains \c[blue]cold temperatures\c[grey] for an extended period after being chilled. It is commonly used to reduce \c[green]swelling\c[grey], alleviate \c[green]pain\c[grey], and provide cold therapy for injuries or \c[green]sore muscles\c[grey].";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("HealBluntForceTrauma",5);
		Return Super.Use(pickup);
	}
}
Class SinSurvivalSaline : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 1;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a bag of Saline.";
		Tag "Alcohol Wipes";
		SinItem.Description "A sterile solution of salt in water, commonly used in medical settings for hydration, \c[green]wound cleaning\c[grey], and as a base for intravenous medications. It helps restore \c[green]fluid balance\c[grey] in the body and is gentle enough for various therapeutic and first-aid applications.";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "";
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("HealBloodLoss",25);
		Return Super.Use(pickup);
	}
}
Class SinSurvivalSuture : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a handful of Sutures.";
		Tag "Suture";
		SinItem.Description "Surgical threads used to \c[green]close wounds\c[grey] or \c[green]incisions\c[grey], designed to naturally dissolve in the body over time. Made from materials like polyglycolic acid or catgut, they eliminate the need for removal and are commonly used in \c[green]internal surgeries\c[grey] or areas with minimal tension.";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "";
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("HealBleeding",10);
		owner.GiveInventory("HealLaceration",10);
		owner.GiveInventory("HealDeepTissueInjury",10);
		Return Super.Use(pickup);
	}
}
Class SinSurvivalTweezers : SinPowerup{
	Default{
		Inventory.Icon "STIMA0";
		Inventory.Amount 2;
		Inventory.MaxAmount 10;
		Inventory.PickupMessage "Picked up a pair of Tweezers.";
		Tag "Tweezers";
		SinItem.Description "Medical Tweezers are precision instruments used by healthcare professionals to grasp, manipulate, or remove small objects such as splinters or debris from wounds. They are typically made of stainless steel and feature fine tips for accurate and delicate handling during medical procedures.";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: STIM A -1; Stop;}
	Override bool Use(bool pickup){
		owner.GiveInventory("InjuryLaceration",1);
		owner.TakeInventory("InjuryForeignBody",1);
		owner.A_DamageSelf(1);
		Return Super.Use(pickup);
	}
}
//	Not too sure about these.
//	Analgesic
Class SinSurvivalPotionGreen : SinPowerup{
	Default{
		Inventory.Icon "POT1A0";
		Inventory.Amount 1;
		Inventory.MaxAmount 4;
		Inventory.PickupMessage "$SINITEM_POTIONGPKUP";
		Tag "$SINITEM_POTIONG";
		SinItem.Description "$SINITEM_POTIONGDESC";
		SinItem.RandomType RAND_ITEM;
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
		SinItem.RandomType RAND_ITEM;
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
		SinItem.RandomType RAND_ITEM;
		SinItem.Stackable 1;
	}
	States{Spawn: POT3 A -1; Stop;}
	Override bool Use(bool pickup){
		If(owner){
			owner.GiveInventory("HealBluntForceTrauma",5);
			owner.GiveInventory("HealLaceration",5);
			owner.GiveInventory("HealGunshotWound",5);
			owner.GiveInventory("HealDeepTissueInjury",5);
			owner.GiveInventory("HealBleeding",5);
			owner.GiveInventory("HealBurn",5);
			owner.GiveInventory("HealSepsis",5);
			owner.GiveInventory("HealForeignBody",1);
		}
		Return Super.Use(pickup);
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
		SinItem.RandomType RAND_ITEM;
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
		SinPowerup.PowerupType "SinSurvivalPowerSteroids";
	}
	States{Spawn: POT3 A -1; Stop;}
}

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
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
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
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
			owner.A_SpawnItem("SinSurvivalMedicalSpawner",1);
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
