package com.example.demo.show;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class Ctest {
	public static void main(String[] args) {
		String url = "http://ticket.interpark.com/Ticket/Goods/GoodsInfo.asp?GoodsCode=24007854";
		try {
            Document doc = Jsoup.connect(url).get();
            System.out.println(doc.title());
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
}
