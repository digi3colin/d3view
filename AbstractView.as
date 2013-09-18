package com.fastframework.module.d3view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.module.d3animate.Animator;
	import com.fastframework.module.d3animate.MCEnum;
	import flash.display.Sprite;
	import flash.utils.describeType;

	/**
	 * @author colin
	 */
	public class AbstractView extends FASTEventDispatcher implements IView{
		private var isHide:Boolean=false;
		private var ani:Animator;

//		private var motion:MotionTween;
		private var view:Sprite;

		public function setView(mc : Sprite,autoHide:Boolean=true) : IView {
			view = mc;
			if(autoHide){
				mc.visible = false;
				isHide = true;
			}
			ani = new Animator(mc, MCEnum.alpha);

			return this;
		}
		
		public function getView():Sprite{
			return view;
		}
		
		public function hide() : IView {
			if(ani==null || isHide==true)return this;
			isHide = true;
			ani.to(0);
			return this;
		}
		
		public function show() : IView {
			if(ani==null || isHide==false)return this;
			isHide = false;
			ani.to(1);
			return this;
		}
		
		public function getViewName() : String {
			return describeType(view).@name;
		}
	}
}
