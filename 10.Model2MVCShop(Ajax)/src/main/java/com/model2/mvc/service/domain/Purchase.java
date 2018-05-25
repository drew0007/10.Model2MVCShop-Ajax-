package com.model2.mvc.service.domain;

import java.sql.Date;


public class Purchase {
	
	private User buyer;
	private String divyDate;
	private String divyRequest;
	private Date orderDate;
	private String paymentOption;
	private Product purchaseProd;
	private String receiverName;
	private String receiverPhone;
	private String tranCode;
	private int tranNo;
	private int tranCnt;
	private int score;
	private String commentText;
	private Date commentDate;
	private String commentImage;
	private String[] commentImageList;
	private String divyPostcode;
	private String divyAddress;
	private String divyAddress2;

	
	public Purchase(){
	}
	
	public User getBuyer() {
		return buyer;
	}
	public void setBuyer(User buyer) {
		this.buyer = buyer;
	}
	public String getDivyDate() {
		return divyDate;
	}
	public void setDivyDate(String divyDate) {
		this.divyDate = divyDate;
	}
	public String getDivyRequest() {
		return divyRequest;
	}
	public void setDivyRequest(String divyRequest) {
		this.divyRequest = divyRequest;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getPaymentOption() {
		return paymentOption;
	}
	public void setPaymentOption(String paymentOption) {
		this.paymentOption = paymentOption;
	}
	public Product getPurchaseProd() {
		return purchaseProd;
	}
	public void setPurchaseProd(Product purchaseProd) {
		this.purchaseProd = purchaseProd;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverPhone() {
		return receiverPhone;
	}
	public void setReceiverPhone(String receiverPhone) {
		this.receiverPhone = receiverPhone;
	}
	public String getTranCode() {
		return tranCode;
	}
	public void setTranCode(String tranCode) {
		this.tranCode = tranCode;
	}
	public int getTranNo() {
		return tranNo;
	}
	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public int getTranCnt() {
		return tranCnt;
	}

	public void setTranCnt(int tranCnt) {
		this.tranCnt = tranCnt;
	}
	
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	public String getCommentImage() {
		return commentImage;
	}

	public void setCommentImage(String commentImage) {
		this.commentImage = commentImage;
		if(commentImage != null && commentImage.length() !=0 ){
			this.commentImageList = commentImage.split("/");
		}
	}

	public String[] getCommentImageList() {
		return commentImageList;
	}

	public void setCommentImageList(String[] commentImageList) {
		this.commentImageList = commentImageList;
	}

	public String getDivyPostcode() {
		return divyPostcode;
	}

	public void setDivyPostcode(String divyPostcode) {
		this.divyPostcode = divyPostcode;
	}

	public String getDivyAddress() {
		return divyAddress;
	}

	public void setDivyAddress(String divyAddress) {
		this.divyAddress = divyAddress;
	}

	public String getDivyAddress2() {
		return divyAddress2;
	}

	public void setDivyAddress2(String divyAddress2) {
		this.divyAddress2 = divyAddress2;
	}

	@Override
	public String toString() {
		return "Purchase [buyer=" + buyer
				+ ", divyDate=" + divyDate + ", divyRequest=" + divyRequest
				+ ", orderDate=" + orderDate + ", paymentOption="
				+ paymentOption + ", purchaseProd=" + purchaseProd
				+ ", receiverName=" + receiverName + ", receiverPhone="
				+ receiverPhone + ", tranCode=" + tranCode + ", tranNo="
				+ tranNo + ", tranCnt=" + tranCnt + ", score=" + score
				+ ", commentText=" + commentText + ", commentDate=" + commentDate
				+ ", commentImage=" + commentImage
				+ ", divyPostcode="+divyPostcode+", divyAddress="+divyAddress
				+", divyAddress2="+divyAddress2+"]";
	}
}