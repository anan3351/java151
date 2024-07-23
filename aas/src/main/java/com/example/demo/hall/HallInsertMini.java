package com.example.demo.hall;

import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;

import java.sql.SQLException;

import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
/**/
public class HallInsertMini
{
    // 태그 값을 읽어올 함수
    private static String getTagValue(String tag, Element eElement)
    {
        Node nValue = null;

        NodeList x = eElement.getElementsByTagName(tag);
        Node test = x.item(0);
        NodeList t = null;
        if (test != null)
        {
            t = test.getChildNodes();
            if ((Node) t.item(0) != null)
            {
                nValue = (Node) t.item(0);
            }
        }
        if (nValue == null)
            return null;
        return nValue.getNodeValue();
    }

    // API 파싱해서 DB에 저장하는 함수(공연 정보)
    public static void apiDB() throws IOException, ParserConfigurationException, SAXException, ClassNotFoundException, SQLException
    {
        // #. 변수 선언
        HallDAO hallDao = new HallDAO();
        ArrayList<String> list = new ArrayList<String>();

        // #. 데이터 삽입 성공 여부 판단 위해 변수 선언
        int result = 0;

        // #. 길이 확인 위해 nList 길이 받아 올 변수 선언
        int length = 0;

        // #. 공연장 코드 가져오기 
        try
        {
            list = hallDao.listPlayCode(); // 공연장코드 다 조회해서 list 변수에 넣음
        }
        catch (Exception e)
        {
            System.out.println(e.toString());
        }//END try

        for (String var : list)
        {
            try {
                StringBuilder urlBuilder = new StringBuilder("http://www.kopis.or.kr/openApi/restful/prfplc/" + var);  // var = 공연장 코드
                urlBuilder.append("?" + URLEncoder.encode("service","UTF-8") + "=47cd4dbaba4843bcb340c5a752cf68c0");
                urlBuilder.append("&" + URLEncoder.encode("newsql","UTF-8") + "=Y");

                URL url = new URL(urlBuilder.toString());

                String parsingUrl = url.toString();

                // 1. 빌더 팩토리 생성.
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();

                // 2. 빌더 팩토리로부터 빌더 생성
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

                // 3. 빌더를 통해 XML 문서를 파싱해서 Document 객체로 가져온다.
                Document doc = dBuilder.parse(parsingUrl);

                // 문서 구조 안정화 
                doc.getDocumentElement().normalize();

                // XML 데이터 중 <db> 태그의 내용을 가져온다.
                NodeList nList = doc.getElementsByTagName("db");

                length = nList.getLength();

                for(int i = 0; i < nList.getLength(); i++)
                {
                    Node nNode = nList.item(i);

                    if(nNode.getNodeType() == Node.ELEMENT_NODE)
                    {
                        Element eElement = (Element) nNode;

                        String code = getTagValue("mt10id", eElement);

                        if(code != null)
                        {     
                            String facilityName = getTagValue("fcltynm", eElement);
                            String miniHall = getTagValue("mt13cnt", eElement);
                            String addr = getTagValue("adres", eElement);
                            String call = getTagValue("telno", eElement);
                            String urlStr = getTagValue("relateurl", eElement);
                            String fcltyChartr = getTagValue("fcltychartr", eElement);

                            NodeList mt13List = eElement.getElementsByTagName("mt13");

                            for(int j = 0; j < mt13List.getLength(); j++) 
                            {
                                Node mt13Node = mt13List.item(j);

                                if(mt13Node.getNodeType() == Node.ELEMENT_NODE)
                                {
                                    Element mt13Element = (Element) mt13Node;
                                    String mt13id = getTagValue("mt13id", mt13Element);

                                    if(mt13id != null && !mt13id.isEmpty())
                                    {
                                        HallDTO hallDto = new HallDTO();
                                        hallDto.setHall_id(mt13id);
                                        //hallDto.setH_name(facilityName); // 공연 시설 명
                                        hallDto.setMiniHall(miniHall); // 공연장수
                                        hallDto.setAddr(addr); // 지역
                                        hallDto.setH_call(call); // 전화번호
                                        hallDto.setUrl(urlStr);  // url
                                        hallDto.setH_code(fcltyChartr);  // 공연시설코드
                                        hallDto.setPrfplcnm(getTagValue("prfplcnm", mt13Element));
                                        //hallDto.setMt13id(mt13id);
                                        hallDto.setSeatscale(getTagValue("seatscale", mt13Element));

                                        try
                                        {
                                            result += hallDao.addPlay2(hallDto);
                                        }
                                        catch (Exception e)
                                        {
                                            System.out.println("Error processing code " + var + ": " + e.getMessage());
                                            e.printStackTrace(); // 스택 트레이스 출력
                                            continue;
                                        }//END try
                                    }//END if
                                }//END if
                            }//END for
                        }//END if
                    }//END if
                }//END for
            }
            catch (IOException e) {
                System.err.println("IO Exception for hall_id: " + var + " - " + e.getMessage());
                continue;
            } catch (ParserConfigurationException | SAXException e) {
                System.err.println("Parsing Exception for hall_id: " + var + " - " + e.getMessage());
                continue;
            }
        }//END for

        System.out.println("공연장 정보 처리 개수 : " + length);
        if (result > 0) {
            System.out.println("데이터 베이스 입력 성공");
        } else {
            System.out.println("데이터베이스 입력 실패");
        }//END if
    }//END apiDB

    public static void main(String[] args) throws IOException, ParserConfigurationException, SAXException, SQLException, ClassNotFoundException
    {
        System.out.println("시작hallInsert");
        apiDB();
    }//END main
}//END HallInsert
