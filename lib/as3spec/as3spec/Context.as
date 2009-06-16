package as3spec
{
	import as3spec.*;
	import flash.events.*;

	public class Context extends EventDispatcher
	{
		private var specifications:Array; // LIFO stack: most recent spec at [0]

		public function Context (story:String)
		{
			trace('');
			trace(story);
			specifications = [];
		}


		// >>> PUBLIC METHODS
		public function describe (block:Function) :void
		{
			block.apply();
		}

		public function require (value:*) :Should
		{
			return specifications[0].require(value);
		}

		public function specify (story:String, block:Function) :void
		{
			var it:Specification = new Specification();
			specifications.unshift(it);
			it.apply(story, block);
		}
	}
}
