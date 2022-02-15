package com.lms.dispatcher;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -419988024238583352L;
	
	public void doGet(HttpServletRequest request,
			HttpServletResponse response)throws ServletException,IOException {
		doPost(request,response);	
	}
	
	public void doPost(HttpServletRequest request,HttpServletResponse response){
		try{
			String uri=request.getRequestURI();
			String action=uri.substring(uri.lastIndexOf("/")+1);
			//System.out.println(uri);
			//System.out.println(action);
			String handlerJsp="/jsp/"+action+".jsp";
			//System.out.println("HandlerJsp: "+handlerJsp);
			RequestDispatcher rd=request.getRequestDispatcher(handlerJsp);
			rd.forward(request,response);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}