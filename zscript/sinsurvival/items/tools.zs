
Class SinBundle : SinConsumable{
	Array<string> storedItems;	//	Stores item names
	Array<int> storedAmounts;	//	Stores corresponding quantities
	Default{
		Height 32;
		Scale 1.25;
		Tag "Bundle";
		Inventory.Icon "BUNDA0";
		Inventory.Amount 0;
		Inventory.MaxAmount 100;
		Inventory.PickupMessage "Picked up a Bundle.";
		Inventory.PickupSound "Bundle/Insert";
		SinItem.Description "A versatile bag for carrying supplies.";
		SinItem.Stackable 0;
	}
	States{Spawn: BUND A -1; Stop; BUND A 0; BUND B 0; BUND C 0; BUND D 0; BUND E 0; BUND F 0;}
	Override void HandleSprite(int status){
		int percentFull = int(100 * self.amount / self.maxamount);
		string ico = "BUND";
		If(percentFull == 0){ico = ico.."A0";}
		Else If(percentFull >= 1 && percentFull < 25){ico = ico.."B0";}
		Else If(percentFull >= 25 && percentFull < 50){ico = ico.."C0";}
		Else If(percentFull >= 50 && percentFull < 75){ico = ico.."D0";}
		Else If(percentFull >= 75 && percentFull < 100){ico = ico.."E0";}
		Else If(percentFull == 100){ico = ico.."F0";}
		icon = TexMan.CheckForTexture(ico,TexMan.Type_Any);
	}
	Override bool Combine(SinItem other, SinInvManager invman){
		owner.A_StartSound("Bundle/Insert", CHAN_AUTO, CHANF_OVERLAP);
		//	TODO: "other.stack == 0" will need to be added to Bundles that have a Capacity unequal to 100.
		If(other is "SinAmmoBox" || other is "SinArmor" || other is "SinBundle" || other.amount <= 0) {Return 0;}
		int stackUnits = (other.stack == 0) ? 100 : (100 / other.MaxAmount); // Unstackable items = 100 units.
		int spaceLeft = self.maxamount - self.amount; // Capacity left.
		int maxInsertable = spaceLeft / stackUnits; // Items that fit.
		int insertAmount = Min(other.amount, maxInsertable); // Items to insert.
		If(insertAmount > 0){
			int index = storedItems.Find(other.GetClassName());
			// Stack items if they don't exist.
			If(index >= 0 && index < storedAmounts.Size()){storedAmounts[index] += insertAmount;}
			Else{
				storedItems.Push(other.GetClassName());
				storedAmounts.Push(insertAmount);
			}
			self.amount += insertAmount * stackUnits;
			other.TakeAmount(insertAmount, invman);
			HandleSprite();
			UpdateDescription();
			//owner.A_Log("Inserted " .. other.GetTag() .. " x" .. insertAmount .. " into Bundle.");
			//PrintStoredItems();
			Return 1;
		}
		//owner.A_Log("Not enough space in the Bundle!");
		Return 0;
	}
	Override bool Use(bool pickup){
		owner.A_StartSound("Bundle/Dump", CHAN_AUTO, CHANF_OVERLAP);
		If(storedItems.Size() > 0){
			string itemToSpawn = storedItems[0];
			int totalAmount = storedAmounts[0];
			// We temporarily get the item's Max Stack here.
			let temp = SinItem(owner.Spawn(itemToSpawn));
			int maxStack = temp.MaxAmount;
			temp.Destroy();
			// This checks the amount to spawn based on the item's Max Stack.
			int amountToSpawn = Min(totalAmount, maxStack);
			let invman = SinInvManager(owner.FindInventory("SinInvManager"));
			let item = SinItem(owner.Spawn(itemToSpawn, owner.pos));
			If(item){
				item.AttachToOwner(owner);
				item.Amount = amountToSpawn;
				item.SinfulPickup(invman);
				// This updates the storage.
				storedAmounts[0] -= amountToSpawn;
				int stackUnits = (100 / maxStack);
				self.amount -= (amountToSpawn * stackUnits);
				// And this removes the item from the Bundle if emptied completely.
				If(storedAmounts[0] <= 0){
					storedItems.Delete(0);
					storedAmounts.Delete(0);
				}
			HandleSprite();
			UpdateDescription();
			Return 1;
			}
		}
		Return 0;
	}
	// Old Use() function. I'll keep it for reference.
	/*
	Override bool Use(bool pickup){
		owner.A_StartSound("Bundle/Dump", CHAN_AUTO, CHANF_OVERLAP);
		If(storedItems.Size() > 0){
			string itemToSpawn = storedItems[0];
			int amountToSpawn = storedAmounts[0];
			int stackUnits = (100 / SinItem(owner.Spawn(itemToSpawn)).MaxAmount);
			let invman = SinInvManager(owner.FindInventory("SinInvManager"));
			let item = SinItem(owner.Spawn(itemToSpawn, owner.pos));
			If(item){
				item.AttachToOwner(owner);
				item.Amount = amountToSpawn;
				item.SinfulPickup(invman);
				self.amount -= (amountToSpawn * stackUnits);
				HandleSprite();
				UpdateDescription();
				storedItems.Delete(0);
				storedAmounts.Delete(0);
				Return 1;
			}
		}
		Return 0;
	}
	*/
	//	Maybe these don't need to be virtualized..
	Virtual void PrintStoredItems(){
		owner.A_Log("Items in Bundle:");
		for(int i = 0; i < storedItems.Size(); i++){owner.A_Log(storedItems[i] .. " x" .. storedAmounts[i]);}
	}
	//	Might remove this..
	Virtual void UpdateDescription(){
		/*
		string desc = "";
		for (int i = 0; i < storedItems.Size(); i++){
			string tag = Class<Actor>(storedItems[i]).Default.Tag;
			int amount = storedAmounts[i];
			desc = desc .. "x" .. amount .. " " .. tag;
			If(i < storedItems.Size() - 1){desc = desc .. ", ";}
		}
		If(desc == ""){desc = "Empty.";}
		self.desc = desc;
		*/
	}
}
Class SinPouch : SinBundle{
	Default{
		Scale 1.25;
		Tag "Pouch";
		Inventory.Icon "BUNDB0";
		Inventory.MaxAmount 50;
	}
	Override void HandleSprite(int status){
		int percentFull = int(100 * self.amount / self.maxamount);
		string ico = "BUND";
		If(percentFull >= 0 && percentFull < 25){ico = ico.."B0";}
		Else If(percentFull >= 25 && percentFull < 50){ico = ico.."C0";}
		Else If(percentFull >= 50){ico = ico.."D0";}
		icon = TexMan.CheckForTexture(ico,TexMan.Type_Any);
	}
}
Class SinSack : SinBundle{
	Default{
		Scale 1.5;
		Tag "Sack";
		Inventory.MaxAmount 200;
	}
	Override void HandleSprite(int status){
		int percentFull = int(100 * self.amount / self.maxamount);
		string ico = "BUND";
		If(percentFull == 0){ico = ico.."A0";}
		Else If(percentFull >= 1 && percentFull < 50){ico = ico.."D0";}
		Else If(percentFull >= 50 && percentFull < 100){ico = ico.."E0";}
		Else If(percentFull == 100){ico = ico.."F0";}
		icon = TexMan.CheckForTexture(ico,TexMan.Type_Any);
	}
	// We no longer need this, as Unstackable Items work correctly now.
	/*
	Override bool Combine(SinItem other, SinInvManager invman){
		owner.A_StartSound("Bundle/Insert", CHAN_AUTO, CHANF_OVERLAP);
		If(other.stack == 0) {Return 0;}
		Return Super.Combine(other,invman);
	}
	*/
}
Class SinSurvivalBackpack : SinBackpack replaces SinBackpack{
	Override bool TryPickup(in out Actor toucher){
		If(!ammodrop){
			A_DropItem("SinBackpackDrop");
			A_DropItem("SinBundle");
			bYFLIP=1; ammodrop=1;
		}
		let invman = SinInvManager(toucher.FindInventory("SinInvManager"));
		If(invman){
			If(invman.maxslots<10){
				invman.maxslots=Min(invman.maxslots+CVar.GetCVar("sin_expandslots",toucher.player).GetInt(),10);
				GoAwayAndDie();
				Return 1;
			}Else{toucher.A_Print(StringTable.Localize("$SIN_MAXCAP")); Return 0;}
		}
		Return 0;
	}
}
