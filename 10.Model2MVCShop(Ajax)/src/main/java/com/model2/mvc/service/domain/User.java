package com.model2.mvc.service.domain;

import java.sql.Date;


//==>회원정보를 모델링(추상화/캡슐화)한 Bean
public class User {
	
	///Field
	private String userId;
	private String userName;
	private String password;
	private String role;
	private String ssn;
	private String phone;
	private String email;
	private Date regDate;
	private String postcode;
	private String address;
	private String address2;
	private String userIdKakao;
	private String userIdNaver;
	private String userStatusCode;
	private String emailCode;
	/////////////// EL 적용 위해 추가된 Field ///////////
	private String phone1;
	private String phone2;
	private String phone3;

	
	
	///Constructor
	public User(){
	}
	
	///Method 
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getSsn() {
		return ssn;
	}
	public void setSsn(String ssn) {
		this.ssn = ssn;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
		/////////////// EL 적용 위해 추가 ///////////
		if(phone != null && phone.length() !=0 ){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	/////////////// EL 적용 위해 추가된 getter Method ///////////
	public String getPhone1() {
		return phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public String getPhone3() {
		return phone3;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getUserIdKakao() {
		return userIdKakao;
	}

	public void setUserIdKakao(String userIdKakao) {
		this.userIdKakao = userIdKakao;
	}

	public String getUserIdNaver() {
		return userIdNaver;
	}

	public void setUserIdNaver(String userIdNaver) {
		this.userIdNaver = userIdNaver;
	}

	public String getUserStatusCode() {
		return userStatusCode;
	}

	public void setUserStatusCode(String userStatusCode) {
		this.userStatusCode = userStatusCode;
	}

	public String getEmailCode() {
		return emailCode;
	}

	public void setEmailCode(String emailCode) {
		this.emailCode = emailCode;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", role=" + role
				+ ", ssn=" + ssn + ", phone=" + phone + ", email=" + email + ", regDate=" + regDate + ", postcode="
				+ postcode + ", address=" + address + ", address2=" + address2 + ", userIdKakao=" + userIdKakao
				+ ", userIdNaver=" + userIdNaver + ", userStatusCode=" + userStatusCode + ", emailCode=" + emailCode
				+ ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3 + "]";
	}
}