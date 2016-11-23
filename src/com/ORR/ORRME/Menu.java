package com.ORR.ORRME;

import org.lwjgl.opengl.Display;

public class Menu {
	
	Initialize initialize = new Initialize();
	public Menu() {
		while (!Display.isCloseRequested()){
			
			Display.update();
			Display.sync(60);
		}
		Display.destroy();
		System.exit(0);
			
	}

}
