package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Weapon;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class WeaponViewController
	{
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function WeaponViewController()
		{
		}
		
		public function addWeapon() : void {
			
			if (!sheet.currentSheet.weapons) { 
				sheet.currentSheet.weapons = new ArrayCollection();
			}
			
			sheet.currentSheet.weapons.addItemAt(new Weapon(), 0);
			sheet.dirty = true;
		}
		
		
		public function deleteWeapon(weapon:Weapon) : void {
			
			Alert.show("Are you sure you want to delete this weapon?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.weapons.getItemIndex(weapon);
						sheet.currentSheet.weapons.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.weapons.length == 0) {
							sheet.currentSheet.weapons = null;
						}
					}
				});
			
		}
		
	}
}