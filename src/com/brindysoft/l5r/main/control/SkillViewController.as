package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.model.Skill;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	[Bindable]
	public class SkillViewController
	{
		
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function SkillViewController()
		{
		}
		
		public function addSkill() : void {
			
			if (!sheet.currentSheet.skills) { 
				sheet.currentSheet.skills = new ArrayCollection();
			}
			
			sheet.currentSheet.skills.addItemAt(new Skill(), 0);
			sheet.dirty = true;
		}
		
		
		public function deleteSkill(skill:Skill) : void {
			
			Alert.show("Are you sure you want to delete this skill?", "Confirm", Alert.YES | Alert.NO, null,
				function(event:CloseEvent) : void {
					if (event.detail == Alert.YES) {
						var index:int = sheet.currentSheet.skills.getItemIndex(skill);
						sheet.currentSheet.skills.removeItemAt(index);
						sheet.dirty = true;
						
						if (sheet.currentSheet.skills.length == 0) {
							sheet.currentSheet.skills = null;
						}
						
					}
				});
			
		}
		
		public function get hasSkills() : Boolean {
			return sheet && sheet.currentSheet && sheet.currentSheet.skills && sheet.currentSheet.skills.length;
		}
		
	}
}