package com.lex.util;

import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.client.methods.RequestBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.util.Random;

/**
 * 通过短信接口发送短信
 */
public class AliyunSmsUtil {
    private static final String aliyun_url = "https://ca.aliyuncs.com/gw/alidayu/sendSms";
    private static final String appKey = "23363365 ";
    private static final String appSecret = "a636841859d3c49d51d4186d88554e8f";
    private static final String product = "";

    public static int sendSms(String mobile, String code, String template_code) {
        CloseableHttpClient httpClient = HttpClients.createDefault();
        try {
            // 请求地址
            HttpUriRequest httpGet = RequestBuilder
                    .get(aliyun_url)
                    .addHeader("X-Ca-Key", appKey)
                    .addHeader("X-Ca-Secret", appSecret)
                    .addParameter("rec_num", mobile)
                    .addParameter("sms_template_code", template_code)
                    .addParameter("sms_free_sign_name", getSignName(template_code))
                    .addParameter("sms_type", "normal")
                    .addParameter("extend", "1234")
                    .addParameter("sms_param", "{'code':'" + code + "','product':'" + product + "'}")
                    .build();
            // TODO 设置请求超时时间

            // 处理请求结果
            ResponseHandler<String> responseHandler = new ResponseHandler<String>() {
                @Override
                public String handleResponse(final HttpResponse response) throws IOException {
                    int status = response.getStatusLine().getStatusCode();
                    System.out.println(status);
                    HttpEntity entity = response.getEntity();
                    return entity != null ? EntityUtils.toString(entity) : null;
                }
            };
            // 发起API 调用
            String responseBody = httpClient.execute(httpGet, responseHandler);
            System.out.println(responseBody);

            JSONObject obj = JSONObject.fromObject(responseBody);
            return obj.getInt("code");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                httpClient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    private static String getSignName(String template_code) {
        switch (template_code) {
            case "SMS_6355037":
                return "注册验证";
            case "SMS_6355041":
                return "身份验证";
            default:
                return "";
        }
    }

    /**
     * 获取4位随机数字字符串
     *
     * @return
     */
    public static String randomNum4() {
        return randomNum(4);
    }

    /**
     * 获取指定长度的随机数字字符串
     *
     * @param length
     * @return
     */
    public static String randomNum(int length) {
        Random r = new Random();

        String code = "";
        String s = "0123456789";
        for (int i = 0; i < 4; i++) {
            code += s.charAt(r.nextInt(s.length()));
        }
        return code;
    }
}

