package com.fh.util;

import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.springframework.web.multipart.MultipartFile;

public class ImageUpload {
	// imageInfo.properties
	private static Properties ps = null;

	static {
		ps = new Properties();
		try {
			ps.load(new FileInputStream(URLDecoder.decode(ImageUpload.class.getResource("/").getPath(),"utf8") + "imageInfo.properties"));

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static boolean cleckImageSize(MultipartFile file, String flag) {
		int width = Integer.parseInt(ps.getProperty("image." + flag + ".width"));
		int height = Integer.parseInt(ps.getProperty("image." + flag + ".height"));

		try {
			BufferedImage bi = ImageIO.read(file.getInputStream());
			return width == bi.getWidth() && height == bi.getHeight();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static void main(String[] args) {
		new ImageUpload();
	}

}
