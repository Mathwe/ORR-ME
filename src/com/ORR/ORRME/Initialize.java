package com.ORR.ORRME;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.lwjgl.LWJGLException;

import static org.lwjgl.opengl.GL11.*;

import org.lwjgl.opengl.*;
import org.lwjgl.*;
import org.newdawn.slick.opengl.Texture;
import org.newdawn.slick.opengl.TextureLoader;

public class Initialize {
	
	Texture background;
	Texture statusBarWraper;
	Texture statusBar;
	
	public void Initialize() {
		switch(Boot.gameState) {
		case Intro:
			setUpScreen(Boot.displayWidth, Boot.displayHight);
			setUpOpenGL(Boot.displayWidth, Boot.displayHight);
			loadSplashTextures();
			Draw(.5);
			Draw(1);
			break;
		case Menu:
			
			break;
		case Game:
			break;
		default:
			break;
		}
	
	}
	
	private void setUpScreen(int width, int hight) {
		try {
			Display.setDisplayMode(new DisplayMode(width, hight));
			Display.setTitle("ORR-ME");
			Display.create();
		} catch (LWJGLException e) {
			e.printStackTrace();
		}
	}
	
	private void setUpOpenGL(int width, int hight) {
		glMatrixMode(GL_PROJECTION);
		glLoadIdentity();
		glOrtho(0, width, hight, 0, 1, -1);
		glMatrixMode(GL_MODELVIEW);
		glEnable(GL_TEXTURE_2D);
	}
	
	public void testDraw() { //Used for glTest
		glClear(GL_COLOR_BUFFER_BIT);
		glBegin(GL_LINES);
			glVertex2i(100, 100);
			glVertex2i(200, 200);
		glEnd();
	}
	
	public void loadSplashTextures() {
		background = loadTexture("res/shared/background");
		statusBarWraper = loadTexture("res/splash/statusWraper");
		statusBar = loadTexture("res/splash/statusBar");
	}
	
	public void Draw(double percentLoaded) {
		glClear(GL_COLOR_BUFFER_BIT);
		background.bind();  //Binding Background to GL To draw it.
		glBegin(GL_QUADS);  // Start to describe the vertices of the Background image
			glTexCoord2f(0, 0);
			glVertex2i(0, 0);//Upper Left
			glTexCoord2f(1, 0);
			glVertex2i(Boot.displayWidth, 0);//Upper Right
			glTexCoord2f(1, 1);
			glVertex2i(Boot.displayWidth, Boot.displayHight);//Lower Right
			glTexCoord2f(0, 1);
			glVertex2i(0, Boot.displayHight);
		glEnd();
		
		//Pre calculating the vertices of the wrapper
		int wraperx0 = Boot.displayWidth / 6;
		int wraperx1 = (Boot.displayWidth / 6) * 5;
		int wrapery0 = Boot.displayHight - 40;
		int wrapery1 = Boot.displayHight - 15;
		
		statusBarWraper.bind();
		glBegin(GL_QUADS);  //Drawing the wrapper to vertices
			glTexCoord2f(0, 0);
			glVertex2i(wraperx0, wrapery0);//Upper Left
			glTexCoord2f(1, 0);
			glVertex2i(wraperx1, wrapery0);//Upper Right
			glTexCoord2f(1, 1);
			glVertex2i(wraperx1, wrapery1);//Lower Right
			glTexCoord2f(0, 1);
			glVertex2i(wraperx0, wrapery1);
		glEnd();
		
		//Pre calculating the vertices of the progress bar
		int wraperLength = wraperx1 - wraperx0;
		int wraperHight = wrapery1 - wrapery0;
		int barx0 = wraperx0 + wraperLength / 10;
		int barx1 = (int) (wraperx0 + (wraperLength / 10 * (9 * percentLoaded)));
		int bary0 = wrapery0 + wraperHight / 3;
		int bary1 = wrapery1 - wraperHight /3;
		
		statusBar.bind();
		glBegin(GL_QUADS); //Drawing progress Bar
			glTexCoord2f(0, 0);
			glVertex2i(barx0, bary0);//Upper Left
			glTexCoord2f(1, 0);
			glVertex2i(barx1, bary0);//Upper Right
			glTexCoord2f(1, 1);
			glVertex2i(barx1, bary1);//Lower Right
			glTexCoord2f(0, 1);
			glVertex2i(barx0, bary1);
		glEnd();
		
		
	}
	
	public Texture loadTexture(String key) {
		try {
			return TextureLoader.getTexture("PNG", new FileInputStream(new File(key+".png")));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
