/************************************************
这是一个游戏开始前经常用到的CG
* 过程：“准备（一秒）-> 空白（0.2秒）-> 开始（一秒） 共2.2秒
*author: Orange
*site: www.liketocode.com
*注意：用法看下一段注释
***********************************************/
package  orangeUI.ReadyAndGoTips {
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ReadyAndGoTips extends MovieClip{
		
		public var is_finished:Boolean = false;
		/***********************************************
		* #is_finished解释：
		*  预留标志位，用于判断是否播放完毕。在其他程序中中可以这样调用 ：
		*   var tips:ReadyAndGoTips = new ReadyAndGoTips();
		*   while (!is_finished){} 
		*   otherOperation();//执行其他操作
		* 这样可以阻塞程序继续执行，直到本CG播放完
		***********************************************/
		
		private var repeat:uint = 220;
        private var timer:Timer = new Timer(10,repeat);
		private var readyMC:MovieClip= new ready();
		private var goMC:MovieClip= new go();
		private var initReadyMCWidth:Number =  readyMC.width;
		private	var initReadyMCHeight:Number = readyMC.height ;
		private	var initGoMCWidth:Number =  goMC.width;
		private	var initGoMCHeight:Number =  goMC.height;
		
		public function ReadyAndGoTips() {
			readyMC.width = 0;
			readyMC.height = 0;
			goMC.width = 0;
			goMC.height = 0;
			
			timer.addEventListener(TimerEvent.TIMER,loadTips);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,setFinished);
			addChild(readyMC);
			addChild(goMC);
			timer.start();
		}
		private function loadTips(e:TimerEvent){//渐变效果
			repeat--;
			if (repeat>120){
				readyMC.alpha -= 0.01;
				readyMC.width += initReadyMCWidth * 0.01;
				readyMC.height += initReadyMCHeight * 0.01;
				readyMC.x = (stage.stageWidth - readyMC.width)/2;
				readyMC.y = (stage.stageHeight - readyMC.height)/2;
				goMC.alpha = 0;
			}
			else if (repeat >100 && repeat <120){
				readyMC.alpha = 0;
				goMC.alpha = 0;
			}
			else{
				readyMC.alpha = 0;
				goMC.alpha +=0.01
				goMC.width += initGoMCWidth * 0.01;
				goMC.height += initGoMCHeight * 0.01;
				goMC.x = (stage.stageWidth - goMC.width)/2;
				goMC.y = (stage.stageHeight - goMC.height)/2;
				//trace(stage.width);
			}
		}
		private function setFinished(e:TimerEvent){//2200ms结束后，完成
			removeChild(readyMC);
			removeChild(goMC);
			is_finished = true;
		}
		

	}
	
}
