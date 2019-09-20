class UserEntity {
	String msgType;
	UserData data;
	dynamic tip;
	String status;

	UserEntity({this.msgType, this.data, this.tip, this.status});

	UserEntity.fromJson(Map<String, dynamic> json) {
		msgType = json['msgType'];
		data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
		tip = json['tip'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msgType'] = this.msgType;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['tip'] = this.tip;
		data['status'] = this.status;
		return data;
	}
}

class UserData {
	String birthday;
	String password;
	String address;
	String gender;
	String nickName;
	bool online;
	String phoneNum;
	String account;
	String email;
	String isVip;
	String headerImg;
	String registerDate;
	List<String>  album;

	UserData({this.birthday, this.password, this.address, this.gender, this.nickName, this.online, this.phoneNum, this.account, this.email, this.isVip, this.headerImg, this.registerDate});

	UserData.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		password = json['password'];
		address = json['address'];
		gender = json['gender'];
		nickName = json['nickName'];
		online = json['online'];
		phoneNum = json['phoneNum'];
		account = json['account'];
		email = json['email'];
		isVip = json['isVip'];
		headerImg = json['headerImg'];
		registerDate = json['registerDate'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['password'] = this.password;
		data['address'] = this.address;
		data['gender'] = this.gender;
		data['nickName'] = this.nickName;
		data['online'] = this.online;
		data['phoneNum'] = this.phoneNum;
		data['account'] = this.account;
		data['email'] = this.email;
		data['isVip'] = this.isVip;
		data['headerImg'] = this.headerImg;
		data['registerDate'] = this.registerDate;
		return data;
	}
}
