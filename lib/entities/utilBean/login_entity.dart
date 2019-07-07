class LoginEntity {
	LoginData data;
	dynamic message;
	String status;

	LoginEntity({this.data, this.message, this.status});

	LoginEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
		message = json['message'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['message'] = this.message;
		data['status'] = this.status;
		return data;
	}
}

class LoginData {
	dynamic birthday;
	String password;
	dynamic address;
	String nickName;
	String sex;
	dynamic phoneNum;
	String account;
	dynamic email;
	String headerImg;

	LoginData({this.birthday, this.password, this.address, this.nickName, this.sex, this.phoneNum, this.account, this.email, this.headerImg});

	LoginData.fromJson(Map<String, dynamic> json) {
		birthday = json['birthday'];
		password = json['password'];
		address = json['address'];
		nickName = json['nickName'];
		sex = json['sex'];
		phoneNum = json['phoneNum'];
		account = json['account'];
		email = json['email'];
		headerImg = json['headerImg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['birthday'] = this.birthday;
		data['password'] = this.password;
		data['address'] = this.address;
		data['nickName'] = this.nickName;
		data['sex'] = this.sex;
		data['phoneNum'] = this.phoneNum;
		data['account'] = this.account;
		data['email'] = this.email;
		data['headerImg'] = this.headerImg;
		return data;
	}
}
