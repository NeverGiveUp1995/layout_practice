class SearchUserEntity {
	String msgType;
	List<SearchUserData> data;
	String tip;
	String status;

	SearchUserEntity({this.msgType, this.data, this.tip, this.status});

	SearchUserEntity.fromJson(Map<String, dynamic> json) {
		msgType = json['msgType'];
		if (json['data'] != null) {
			data = new List<SearchUserData>();(json['data'] as List).forEach((v) { data.add(new SearchUserData.fromJson(v)); });
		}
		tip = json['tip'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msgType'] = this.msgType;
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		data['tip'] = this.tip;
		data['status'] = this.status;
		return data;
	}
}

class SearchUserData {
	bool isfriend;
	SearchUserDataUser user;

	SearchUserData({this.isfriend, this.user});

	SearchUserData.fromJson(Map<String, dynamic> json) {
		isfriend = json['isfriend'];
		user = json['user'] != null ? new SearchUserDataUser.fromJson(json['user']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['isfriend'] = this.isfriend;
		if (this.user != null) {
      data['user'] = this.user.toJson();
    }
		return data;
	}
}

class SearchUserDataUser {
	String birthday;
	dynamic password;
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

	SearchUserDataUser({this.birthday, this.password, this.address, this.gender, this.nickName, this.online, this.phoneNum, this.account, this.email, this.isVip, this.headerImg, this.registerDate});

	SearchUserDataUser.fromJson(Map<String, dynamic> json) {
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
