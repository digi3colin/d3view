package com.fastframework.module.d3view {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.module.d3animate.Animator;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.describeType;





	/**
	 * @author colin
	 */
	public class ShowHideView extends FASTEventDispatcher implements IView{
		private var isHide:Boolean=false;

		private var view:Sprite;
		private var btnClose:ButtonClip;
		private var motionDur:Number;
		private var an:Animator;

		public function ShowHideView(mc:Sprite,autoHide:Boolean = true,elapseMS:Number=1000){
			this.motionDur = elapseMS;
			this.setView(mc, autoHide);

			try{
				if(mc['btn_close']!=null){
					btnClose = new ButtonClip(mc['btn_close']);
					btnClose.when(ButtonClipEvent.CLICK, onClose);
				}
			}catch(e:Error){
			
			}
		}

		private function onClose(e:Event):void{
			this.hide();
		}

		public function setView(mc : Sprite,autoHide:Boolean=true) : IView {
			if(autoHide){
				mc.alpha=0;
				mc.visible = false;
				isHide = true;
			}

			an = new Animator(view = mc,'alpha',motionDur);
			an.when(Animator.EVENT_END, onMotionEnd);

			return this;
		}
		
		public function getView():Sprite{
			return view;
		}
		
		public function hide() : IView {
			if(an==null || isHide==true)return this;
			isHide = true;
			an.to(0);

			dispatchEvent(new Event(ShowHideEvent.EVENT_HIDE));
			return this;
		}
		
		public function show() : IView {
			if(an==null || isHide==false)return this;
			isHide = false;
			an.to(1);

			dispatchEvent(new Event(ShowHideEvent.EVENT_SHOW));
			return this;
		}
		
		public function getViewName() : String {
			return describeType(view).@name;
		}

		private function onMotionEnd(e:Event):void{
			var type:String = (isHide)?ShowHideEvent.EVENT_HIDE_ANIMATION_END:ShowHideEvent.EVENT_SHOW_ANIMATION_END;
			dispatchEvent(new Event(type));
		}
	}
}
