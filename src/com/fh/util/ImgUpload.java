package com.fh.util;

import java.awt.Dimension;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifDirectory;

public class ImgUpload {

	/**
	 * 处理图片旋转问题
	 * 
	 * @param file
	 * @param path
	 */
	public static void copyFileToFile(File file, String path) {
		try {
			BufferedImage src = getPicture(file);
			BufferedImage bi = null;

			// 图片存在
			if (src != null) {
				// 获取图片旋转角度
				int angel = getRotateAngleForPhoto(file);
				if (angel == 0) {
					// 图片正常，不处理图片
					bi = src;
				} else {
					// 图片被翻转，调整图片
					int src_width = src.getWidth();
					int src_height = src.getHeight();
					Rectangle rect_des = CalcRotatedSize(new Rectangle(new Dimension(src_width, src_height)), angel);

					bi = new BufferedImage(rect_des.width, rect_des.height, BufferedImage.TYPE_INT_RGB);
					Graphics2D g2 = bi.createGraphics();

					g2.translate((rect_des.width - src_width) / 2, (rect_des.height - src_height) / 2);
					g2.rotate(Math.toRadians(angel), src_width / 2, src_height / 2);

					g2.drawImage(src, null, null);
				}

				int index = path.lastIndexOf(".");
				String formate = path.substring(index + 1);
				FileOutputStream os = new FileOutputStream(file);
				ImageIO.write(bi, formate, os);
				os.close();
			} else {
				// 图片不存在
				// logger.info("图片：" + name + "为空");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		}
	}

	/**
	 * 图片翻转时，计算图片翻转到正常显示需旋转角度
	 */
	public static int getRotateAngleForPhoto(File file) {
		int angel = 0;
		Metadata metadata;

		try {
			metadata = JpegMetadataReader.readMetadata(file);
			Directory directory = metadata.getDirectory(ExifDirectory.class);
			if (directory.containsTag(ExifDirectory.TAG_ORIENTATION)) {
				// Exif信息中方向
				int orientation = directory.getInt(ExifDirectory.TAG_ORIENTATION);
				// 原图片的方向信息
				if (6 == orientation) {
					// 6旋转90
					angel = 90;
				} else if (3 == orientation) {
					// 3旋转180
					angel = 180;
				} else if (8 == orientation) {
					// 8旋转90
					angel = 270;
				}
			}
		} catch (JpegProcessingException e) {
			e.printStackTrace();
		} catch (MetadataException e) {
			e.printStackTrace();
		}
		// logger.info("图片旋转角度：" + angel);
		System.err.println(angel);
		return angel;
	}

	/**
	 * 读取指定图片
	 */
	public static BufferedImage getPicture(File file) {
		BufferedImage bi = null;
		try {
			bi = ImageIO.read(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bi;
	}

	/**
	 * 计算旋转参数
	 */
	public static Rectangle CalcRotatedSize(Rectangle src, int angel) {
		if (angel > 90) {
			if (angel / 9 % 2 == 1) {
				int temp = src.height;
				src.height = src.width;
				src.width = temp;
			}
			angel = angel % 90;
		}

		double r = Math.sqrt(src.height * src.height + src.width * src.width) / 2;
		double len = 2 * Math.sin(Math.toRadians(angel) / 2) * r;
		double angel_alpha = (Math.PI - Math.toRadians(angel)) / 2;
		double angel_dalta_width = Math.atan((double) src.height / src.width);
		double angel_dalta_height = Math.atan((double) src.width / src.height);

		int len_dalta_width = (int) (len * Math.cos(Math.PI - angel_alpha - angel_dalta_width));
		int len_dalta_height = (int) (len * Math.cos(Math.PI - angel_alpha - angel_dalta_height));
		int des_width = src.width + len_dalta_width * 2;
		int des_height = src.height + len_dalta_height * 2;
		return new java.awt.Rectangle(new Dimension(des_width, des_height));
	}
}
