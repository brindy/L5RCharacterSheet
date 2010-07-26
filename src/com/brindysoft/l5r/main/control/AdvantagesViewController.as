package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Advantage;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.events.CollectionEvent;
	
	[Bindable]
	public class AdvantagesViewController
	{
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function AdvantagesViewController()
		{
		}
		
		public function addAdvantage() : void {
			
			if (!sheet.currentSheet.advantages) { 
				sheet.currentSheet.advantages = new ArrayCollection();
			}
			
			sheet.currentSheet.advantages.addItemAt(new Advantage(), 0);
			sheet.dirty = true;
		}
		
		
		public function deleteAdvantage(advantage:Advantage) : void {
			
			Alert.show("Are you sure you want to delete this advantage?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.advantages.getItemIndex(advantage);
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