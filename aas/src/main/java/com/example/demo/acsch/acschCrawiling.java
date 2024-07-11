package com.example.demo.acsch;

import net.sourceforge.tess4j.Tesseract;
import net.sourceforge.tess4j.TesseractException;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
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

        Tesseract tesseract = new Tesseract();
        tesseract.setDatapath("C:\\Tesseract-OCR\\tessdata");  // Tesseract 데이터 경로 설정
        tesseract.setLanguage("kor");

        return tesseract.doOCR(image);
    }
}
