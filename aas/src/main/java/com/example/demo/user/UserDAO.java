package com.example.demo.user;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {

	public UserDAO() {
		System.out.println("------------UserDAO()객체생성됨");
	}//UserDAO() end
}
