
Class SinSurvivalHotkeys : EventHandler{
	Override bool InputProcess(InputEvent e){
		For(int i=0; i<MAXPLAYERS; i++){
			If(!playeringame[i]||!players[i].mo){Continue;}
			let invman=SinInvManager(players[i].mo.FindInventory("SinInvManager"));
			If(!invman){Return 0;}
			If(e.Type!=InputEvent.Type_KeyDown||!cvar.GetCVar("sinsurvival_hotkeys").getbool()){Return 0;}
			int slotIndex=-1;
			If(bindings.GetBinding(e.KeyScan)~=="slot 1"){slotIndex=0;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 2"){slotIndex=1;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 3"){slotIndex=2;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 4"){slotIndex=3;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 5"){slotIndex=4;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 6"){slotIndex=5;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 7"){slotIndex=6;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 8"){slotIndex=7;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 9"){slotIndex=8;}
			Else If(bindings.GetBinding(e.KeyScan)~=="slot 0"){slotIndex=9;}
			If(slotIndex>=0&&slotIndex<invman.items.Size()){
				EventHandler.SendNetworkEvent("Equip",slotIndex);
				Return 1;
			}
		}
		Return Super.InputProcess(e);
	}
}
