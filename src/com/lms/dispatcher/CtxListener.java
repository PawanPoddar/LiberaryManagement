package com.lms.dispatcher;

import java.io.*;
import java.util.*;
import javax.servlet.*;
public class CtxListener implements ServletContextListener {
	public void contextDestroyed(ServletContextEvent c) {}

	public void contextInitialized(ServletContextEvent c) {
		ServletContext ctx=c.getServletContext();
		String path=ctx.getRealPath("WEB-INF/classes/resources/application.properties");
		Properties p=new Properties();
		try{
			p.load(new FileInputStream(path));
			ctx.setAttribute("properties",p);
			//System.out.println("Properties loaded.");
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}

