package com.lex.test;

import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by chunye on 16/8/10.
 */
public class HttpClientTest {

    private static int executePost(String url, List<NameValuePair> formparams) {

        // 创建默认的httpClient实例.
        CloseableHttpClient httpclient = HttpClients.createDefault();
        // 创建httppost
        HttpPost httppost = new HttpPost("http://localhost:8091/app/user/login");
        // 创建参数队列
        //        List<BasicNameValuePair> formparams = new ArrayList<BasicNameValuePair>();
        //        formparams.add(new BasicNameValuePair("username", "admin"));
        //        formparams.add(new BasicNameValuePair("password", "123456"));
        UrlEncodedFormEntity uefEntity;
        try {
            uefEntity = new UrlEncodedFormEntity(formparams, "UTF-8");
            httppost.setEntity(uefEntity);
            System.out.println("executing request " + httppost.getURI());
            CloseableHttpResponse response = httpclient.execute(httppost);
            try {
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    System.out.println("--------------------------------------");
                    String responseBody = EntityUtils.toString(entity, "UTF-8");
                    System.out.println("Response content: " + responseBody);
                    System.out.println("--------------------------------------");
                    JSONObject obj = JSONObject.fromObject(responseBody);
                }

            } finally {
                response.close();
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 关闭连接,释放资源
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return 0;
    }

    public static void uploadFile(String url, String textFileName) {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost post = new HttpPost(url);
        File file = new File(textFileName);
        String message = "This is a multipart post";
        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
        builder.addBinaryBody("file", file, ContentType.DEFAULT_BINARY, textFileName);
        builder.addTextBody("phone", "9999", ContentType.DEFAULT_BINARY);

        HttpEntity entity = builder.build();
        post.addHeader("token", "testToken");
        post.setEntity(entity);


        HttpResponse response = null;
        try {
            response = httpclient.execute(post);
        } catch (IOException e) {
            e.printStackTrace();
        }
        HttpEntity entity1 = response.getEntity();
        if (entity != null) {
            System.out.println("--------------------------------------");
            try {
                System.out.println("Response content: " + EntityUtils.toString(entity1, "UTF-8"));
            } catch (IOException e) {
                e.printStackTrace();
            }
            System.out.println("--------------------------------------");
        }


    }


    /**
     * 发送 post请求访问本地应用并根据传递参数不同返回不同结果
     */
    public static void post(String url, List<NameValuePair> formparams) {
        // 创建默认的httpClient实例.
        CloseableHttpClient httpclient = HttpClients.createDefault();
        // 创建httppost
        HttpPost httppost = new HttpPost(url);
        // 创建参数队列
//        List<NameValuePair> formparams = new ArrayList<NameValuePair>();
//        formparams.add(new BasicNameValuePair("type", "house"));
        UrlEncodedFormEntity uefEntity;
        try {
            uefEntity = new UrlEncodedFormEntity(formparams, "UTF-8");
            httppost.addHeader("token", "testToken");
            httppost.setEntity(uefEntity);
            System.out.println("executing request " + httppost.getURI());
            CloseableHttpResponse response = httpclient.execute(httppost);
            try {
                HttpEntity entity = response.getEntity();
                if (entity != null) {
                    System.out.println("--------------------------------------");
                    System.out.println("Response content: " + EntityUtils.toString(entity, "UTF-8"));
                    System.out.println("--------------------------------------");
                }
            } finally {
                response.close();
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 关闭连接,释放资源
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    public static void get(String url) {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {
            // 创建httpget.
            HttpGet httpget = new HttpGet(url);
            System.out.println("executing request " + httpget.getURI());
            // 执行get请求.
            CloseableHttpResponse response = httpclient.execute(httpget);
            try {
                // 获取响应实体
                HttpEntity entity = response.getEntity();
                System.out.println("--------------------------------------");
                // 打印响应状态
                System.out.println(response.getStatusLine());
                if (entity != null) {
                    // 打印响应内容长度
                    System.out.println("Response content length: " + entity.getContentLength());
                    // 打印响应内容
                    System.out.println("Response content: " + EntityUtils.toString(entity));
                }
                System.out.println("------------------------------------");
            } finally {
                response.close();
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 关闭连接,释放资源
            try {
                httpclient.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }


    public static void main(String[] aa) {
       // String url = "http://120.27.4.103:8080/app/user/login";
        String url = "http://120.27.4.103:8080/app/user/register";
        // String url = "http://localhost:8091/app/sms/send";
        // String url = "http://localhost:8091/app/sms/forgetPass";
        // String url = "http://localhost:8091/app/user/forgetPassReset";
       // String url = "http://localhost:8091/app/user/editUser";
       String urlUpload = "http://120.27.4.103:8080/app/user/editHeadPic";
       // String url = "http://localhost:8091/app/company/list";
        //String url = "http://localhost:8091/app/user/addWork";
       // String url = "http://localhost:8091/app/user/labelList";

//        String url = "http://localhost:8091/app/user/editLabel";
//        //String url = "http://localhost:8091/app/label/list";
//        List<NameValuePair> formparams = new ArrayList<NameValuePair>();
//        formparams.add(new BasicNameValuePair("phone", "9999"));
//       formparams.add(new BasicNameValuePair("password", "9999"));
//        formparams.add(new BasicNameValuePair("app_user_id", "0"));
//        formparams.add(new BasicNameValuePair("label_id", "1"));
//        formparams.add(new BasicNameValuePair("label_name", "技术人员"));



//        formparams.add(new BasicNameValuePair("start_time", "201301"));
//        formparams.add(new BasicNameValuePair("end_time", "201501"));
       String file = "/Users/chunye/pic/Screenshot_20160704-113412.PNG";
        //formparams.add(new BasicNameValuePair("validate_code_where", "DFDSDS"));
       // HttpClientTest.post(url,formparams);
        HttpClientTest.uploadFile(urlUpload, file);
        //  HttpClientTest.get(url);
    }
}
