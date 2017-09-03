package com.lex.interceptor;

import com.fh.util.Const;
import net.sf.json.JSONObject;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by chunye on 16/8/11.
 * 用于验证app登录状态
 */
public class CheckUserInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = request.getHeader("token");

        response.setHeader("contentType", "text/html; charset=utf-8");
        if (Const.APP_SESSION_TOKEN.containsKey(token)) {
            return super.preHandle(request, response, handler);
        } else {
//            response.addHeader(Const.APP_RESULT_CODE,Const.APP_RESULT_CODE_FAIL);
//            response.addHeader(Const.APP_RESULT_MESSAGE,new String( "连接失效,请重新登录".getBytes("gb2312"), "ISO8859-1" ));

            Map map = new HashMap();
            map.put(Const.APP_RESULT_CODE, Const.APP_RESULT_CODE_FAIL);
            map.put(Const.APP_RESULT_MESSAGE, "连接失效,请重新登录");
            JSONObject responseJSONObject = JSONObject.fromObject(map);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=utf-8");
            PrintWriter out = null;
            try {
                out = response.getWriter();
                out.append(responseJSONObject.toString());
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (out != null) {
                    out.close();
                }

                return false;
            }
        }

    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//        response.
        super.postHandle(request, response, handler, modelAndView);
    }
}
