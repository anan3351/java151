package com.example.demo.acsch;

import net.sourceforge.tess4j.Tesseract;
import net.sourceforge.tess4j.TesseractException;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@Service
public class acschCrawiling {

    public List<String> getShowSchedule() {
        List<String> schedules = new ArrayList<>();
        try {
            String imageUrl = "https://ticketimage.interpark.com/Play/image/etc/24/24005971-18.jpg";
            schedules.add(performOCR(imageUrl));
        } catch (IOException | TesseractException e) {
            e.printStackTrace();
        }
        return schedules;
    }

    private String performOCR(String imageUrl) throws IOException, TesseractException {
        BufferedImage image = ImageIO.read(new URL(imageUrl));
        BufferedImage processedImage = preprocessImage(image);

        Tesseract tesseract = new Tesseract();
        tesseract.setDatapath("C:\\Tesseract-OCR\\tessdata");
        tesseract.setLanguage("kor");
        tesseract.setPageSegMode(6);
        tesseract.setTessVariable("preserve_interword_spaces", "1");
        tesseract.setTessVariable("tessedit_char_whitelist", "0123456789월일화수목금토시분ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ가나다라마바사아자차카타파하");

        return tesseract.doOCR(processedImage);
    }

    private BufferedImage preprocessImage(BufferedImage image) {
        int width = image.getWidth();
        int height = image.getHeight();

        // Convert to grayscale
        BufferedImage grayImage = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_GRAY);
        Graphics g = grayImage.getGraphics();
        g.drawImage(image, 0, 0, null);
        g.dispose();

        // Increase contrast and binarize
        BufferedImage binarizedImage = new BufferedImage(width, height, BufferedImage.TYPE_BYTE_BINARY);
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int pixel = grayImage.getRGB(x, y);
                int gray = pixel & 0xFF;
                int newPixel = (gray < 128) ? 0 : 255;
                binarizedImage.setRGB(x, y, (newPixel << 16) | (newPixel << 8) | newPixel);
            }
        }

        // Scale the image
        int newWidth = width * 2;
        int newHeight = height * 2;
        Image tmp = binarizedImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);
        BufferedImage scaledImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_BYTE_BINARY);
        Graphics2D g2d = scaledImage.createGraphics();
        g2d.drawImage(tmp, 0, 0, null);
        g2d.dispose();

        return scaledImage;
    }
}