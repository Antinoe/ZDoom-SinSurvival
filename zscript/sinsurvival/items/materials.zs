
Class SinSteel : SinMisc{
	Default{
		Scale 1.0;
		Tag "Steel";
		Inventory.Icon "POT2A0";
		Inventory.Amount 1;
		Inventory.MaxAmount 10;
		SinItem.Description "A durable alloy made primarily of iron and carbon, known for its strength, versatility, and resistance to deformation. It is widely used in construction, manufacturing, and tools, forming the backbone of modern infrastructure and industrial applications.";
		SinItem.Stackable 1;
		SinItem.SpawnSaveDrives 0;
	}
	States{Spawn: POT2 A -1; Stop;}
}
