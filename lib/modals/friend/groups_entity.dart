class GroupsEntity {
	String msgType;
	List<GroupsData> data;
	String tip;
	String status;

	GroupsEntity({this.msgType, this.data, this.tip, this.status});

	GroupsEntity.fromJson(Map<String, dynamic> json) {
		msgType = json['msgType'];
		if (json['data'] != null) {
			data = new List<GroupsData>();(json['data'] as List).forEach((v) { data.add(new GroupsData.fromJson(v)); });
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

class GroupsData {
	String creatTime;
	int groupId;
	String creatorId;
	int onlineNum;
	List<GroupsDataUser> users;
	String friendGroupName;

	GroupsData({this.creatTime, this.groupId, this.creatorId, this.onlineNum, this.users, this.friendGroupName});

	GroupsData.fromJson(Map<String, dynamic> json) {
		creatTime = json['creatTime'];
		groupId = json['groupId'];
		creatorId = json['creatorId'];
		onlineNum = json['onlineNum'];
		if (json['users'] != null) {
			users = new List<GroupsDataUser>();(json['users'] as List).forEach((v) { users.add(new GroupsDataUser.fromJson(v)); });
		}
		friendGroupName = json['friendGroupName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['creatTime'] = this.creatTime;
		data['groupId'] = this.groupId;
		data['creatorId'] = this.creatorId;
		data['onlineNum'] = this.onlineNum;
		if (this.users != null) {
      data['users'] =  this.users.map((v) => v.toJson()).toList();
    }
		data['friendGroupName'] = this.friendGroupName;
		return data;
	}
}

class GroupsDataUser {
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

	GroupsDataUser({this.birthday, this.password, this.address, this.gender, this.nickName, this.online, this.phoneNum, this.account, this.email, this.isVip, this.headerImg, this.registerDate});

	GroupsDataUser.fromJson(Map<String, dynamic> json) {
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
