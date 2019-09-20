class CheckFriendEntity {
	String msgType;
	CheckFriendData data;
	String tip;
	String status;

	CheckFriendEntity({this.msgType, this.data, this.tip, this.status});

	CheckFriendEntity.fromJson(Map<String, dynamic> json) {
		msgType = json['msgType'];
		data = json['data'] != null ? new CheckFriendData.fromJson(json['data']) : null;
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

class CheckFriendData {
	String passiveUserId;
	int friendId;
	String addTime;
	String activeUserId;

	CheckFriendData({this.passiveUserId, this.friendId, this.addTime, this.activeUserId});

	CheckFriendData.fromJson(Map<String, dynamic> json) {
		passiveUserId = json['passiveUserId'];
		friendId = json['friendId'];
		addTime = json['addTime'];
		activeUserId = json['activeUserId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['passiveUserId'] = this.passiveUserId;
		data['friendId'] = this.friendId;
		data['addTime'] = this.addTime;
		data['activeUserId'] = this.activeUserId;
		return data;
	}
}
