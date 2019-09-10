import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:layout_practice/utils/Utils.dart';
import './bloc.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  @override
  NoticeState get initialState => InitialNoticeState();

  @override
  Stream<NoticeState> mapEventToState(
    NoticeEvent event,
  ) async* {
    if (event is PublishNotice) {
      if (true) {
        //开启通知，
        yield NotificationState(
          isShow: true,
          noticeId: event.noticeId,
          senderAccount: event.senderAccount,
          senderName: event.senderName,
          content: event.content,
          imgSrc: event.imgSrc,
        );
        //弹出一次通知之后，立即将通知转改改为false，以免其他状态变化，导致通知重复显示

      }
    }
  }
}
