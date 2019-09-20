class AddFriendEntity {
	String msgType;
	dynamic data;
	String tip;
	String status;

	AddFriendEntity({this.msgType, this.data, this.tip, this.status});

	AddFriendEntity.fromJson(Map<String, dynamic> json) {
		msgType = json['msgType'];
		data = json['data'];
		tip = json['tip'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msgType'] = this.msgType;
		data['data'] = this.data;
		data['tip'] = this.tip;
		data['status'] = this.status;
		return data;
	}
}
