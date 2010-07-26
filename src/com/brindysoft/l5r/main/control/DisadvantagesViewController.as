package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Advantage;
	import com.brindysoft.l5r.main.model.Disadvantage;
	import com.brindysoft.l5r.main.model.Weapon;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class DisadvantagesViewController
	{
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function DisadvantagesViewController()
		{
		}
		
		public function addDisadvantage() : void {
			
			if (!sheet.currentSheet.disadvantages) { 
				sheet.currentSheet.disadvantages = new ArrayCollection();
			}
			
			sheet.currentSheet.disadvantages.addItemAt(new Disadvantage(), 0);
			sheet.dirty = true;
		}
		
		
		public function deleteDisadvantage(disadvantage:Disadvantage) : void {
			
			Alert.show("Are you sure you want to delete this disadvantage?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.advantages.getItemIndex(disadvantage);
						sheet.currentSheet.advantages.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.advantages.length == 0) {
							sheet.currentSheet.advantages = null;
						}
					}
				});
			
		}
		
	}
}