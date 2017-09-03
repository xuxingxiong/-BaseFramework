package com.fh.util;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

/**
 * 上传文件 创建人：FH Q313596790 创建时间：2014年12月23日
 * 
 * @version
 */
public class FileUpload {

	// imageInfo.properties
	private static Properties ps = null;

	static {
		ps = new Properties();
		try {
			ps.load(new FileInputStream(URLDecoder.decode(FileUpload.class.getResource("/").getPath(),"utf8") + "imageInfo.properties"));
		} catch (FileNotFoundException e) {
			System.out.println(e);
		} catch (IOException e) {
			System.out.println(e);
		}
	}

	/**
	 * 上传文件
	 * 
	 * @param file
	 *            //文件对象
	 * @param filePath
	 *            //上传路径
	 * @param fileName
	 *            //文件名
	 * @return 文件名
	 */
	public static String fileUp(MultipartFile file, String filePath, String fileName) {
		String extName = ""; // 扩展名格式：
		try {
			if (file.getOriginalFilename().lastIndexOf(".") >= 0) {
				extName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			}
			copyFile(file.getInputStream(), filePath, fileName + extName).replaceAll("-", "");
		} catch (IOException e) {
			System.out.println(e);
		}
		return fileName + extName;
	}

	/**
	 * 获取功能模块所需图片尺寸
	 * 
	 * @param flag
	 *            功能模块标识
	 */
	public static Map<String, Object> getImgSize(String flag) {
		Map<String, Object> sizeMap = new HashMap<>();
		sizeMap.put("width", ps.getProperty("image." + flag + ".width"));
		sizeMap.put("height", ps.getProperty("image." + flag + ".height"));
		return sizeMap;
	}

	/**
	 * 校验图片尺寸是否符合模块要求
	 * 
	 * @param file
	 *            待校验文件
	 * @param flag
	 *            功能模块标识
	 */
	public static boolean cleckImageSize(MultipartFile file, String flag) {
		try {
			if (null==flag || "".equals(flag)){
				flag = "none";
			}
			// 模块需要图片宽度
			int width = Integer.parseInt(ps.getProperty("image." + flag + ".width"));
			// 模块需要图片长度
			int height = Integer.parseInt(ps.getProperty("image." + flag + ".height"));

			BufferedImage bi = ImageIO.read(file.getInputStream());
			// 返回判断结果
			return width >= bi.getWidth() && height >= bi.getHeight();
		} catch (IOException e) {
			System.err.println(e);
		}
		return false;
	}

	/**
	 * 写文件到当前目录的upload目录中
	 * 
	 * @param in
	 * @param fileName
	 * @throws IOException
	 */
	private static String copyFile(InputStream in, String dir, String realName) throws IOException {
		File file = mkdirsmy(dir, realName);
		FileUtils.copyInputStreamToFile(in, file);
		File file1 = new File(dir + "/" + realName);
		ImgUpload.copyFileToFile(file1, file.getPath());
		return realName;
	}

	/**
	 * 判断路径是否存在，否：创建此路径
	 * 
	 * @param dir
	 *            文件路径
	 * @param realName
	 *            文件名
	 * @throws IOException
	 */
	public static File mkdirsmy(String dir, String realName) throws IOException {
		File file = new File(dir, realName);
		if (!file.exists()) {
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			file.createNewFile();
		}
		return file;
	}

	/**
	 * 下载网络图片上传到服务器上
	 * 
	 * @param httpUrl
	 *            图片网络地址
	 * @param filePath
	 *            图片保存路径
	 * @param myFileName
	 *            图片文件名(null时用网络图片原名)
	 * @return 返回图片名称
	 */
	public static String getHtmlPicture(String httpUrl, String filePath, String myFileName) {

		URL url; // 定义URL对象url
		BufferedInputStream in; // 定义输入字节缓冲流对象in
		FileOutputStream file; // 定义文件输出流对象file
		try {
			String fileName = null == myFileName ? httpUrl.substring(httpUrl.lastIndexOf("/")).replace("/", "")
					: myFileName; // 图片文件名(null时用网络图片原名)
			url = new URL(httpUrl); // 初始化url对象
			in = new BufferedInputStream(url.openStream()); // 初始化in对象，也就是获得url字节流
			// file = new FileOutputStream(new File(filePath +"\\"+ fileName));
			file = new FileOutputStream(mkdirsmy(filePath, fileName));
			int t;
			while ((t = in.read()) != -1) {
				file.write(t);
			}
			file.close();
			in.close();
			return fileName;
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;

	}
}
