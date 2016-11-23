package com.ORR.ORRME;

import java.io.*;
import java.util.Properties;

import org.lwjgl.opengl.GL11.*;
import org.lwjgl.input.*;
import org.lwjgl.opengl.*;
import org.lwjgl.*;
import org.newdawn.slick.opengl.Texture;
import org.newdawn.slick.opengl.TextureLoader;

public class Boot {
	
	public static enum State {
		Menu,
		Game,
		Intro;
	}
	
	public static int displayHight;
	public static int displayWidth;
	//public static Display display;
	public static State gameState = null;
	Properties prop = new Properties();
	Initialize initialize;
	Menu menu;
	
	public Boot() {
		gameState = State.Intro;
		loadConfig();
		initializeStartVariables();
		initialize = new Initialize();
		initialize.Initialize();
		
		
		//Finally hand off control to menu
		gameState = State.Menu;
		initialize.Initialize();
		menu = new Menu();
		
		/*//Loose all of this when we hand off overall control to menu
		while(!Display.isCloseRequested()) {
			System.out.println("Help I am stuck in a loop");
			Display.update();
			Display.sync(60);
		}
		Display.destroy();
		System.exit(0);*/
	}
	
	private void initializeStartVariables() {
		displayHight = Integer.parseInt((String) prop.get("screenHight"));
		displayWidth = Integer.parseInt((String) prop.get("screenWidth"));
	}
	
	private void loadConfig() {
		InputStream input = null;
		try {
			input = new FileInputStream("settings.cfg");
			// load a properties file
			prop.load(input);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		
	}
	
	public static void main(String[] args) {
		new Boot();
	}

}
