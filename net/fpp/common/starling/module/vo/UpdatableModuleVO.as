package net.fpp.common.starling.module.vo
{
	import net.fpp.common.starling.module.IUpdatableModule;

	public class UpdatableModuleVO
	{
		public var moduleReference:IUpdatableModule;
		public var lastUpdateTime:Number = 0;

		public function UpdatableModuleVO( moduleReference:IUpdatableModule )
		{
			this.moduleReference = moduleReference;
		}
	}
}