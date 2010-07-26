package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Kata;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	[Bindable]
	public class KataViewController
	{
		
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function KataViewController()
		{
		}
		
		public function addKata() : void {
			
			if (!sheet.currentSheet.katas) {
				sheet.currentSheet.katas = new ArrayCollection();
			}
			
			sheet.currentSheet.katas.addItemAt(new Kata(), 0);
			sheet.dirty = true;
		}
		
		public function deleteKata(kata:Kata) : void {
			
			Alert.show("Are you sure you want to delete this kata?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.katas.getItemIndex(kata);
						sheet.currentSheet.katas.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.katas.length == 0) {
							sheet.currentSheet.katas = null;
						}
						
					}
				});
			
			
		}
		
	}
}