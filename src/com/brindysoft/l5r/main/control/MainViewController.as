package com.brindysoft.l5r.main.control
{
	import com.brindysoft.l5r.main.messages.SelectSheetElementMessage;
	

	[Bindable]
	public class MainViewController
	{
		
		public var selectedElementIndex:int;
		
		[Inject]
		public var sheet:CharacterSheetController;
		
		public function MainViewController()
		{
		}
		
		[MessageHandler]
		public function handleSheetElementSelected(message:SelectSheetElementMessage) : void {
			selectedElementIndex = message.index;
		}
		
	}
}