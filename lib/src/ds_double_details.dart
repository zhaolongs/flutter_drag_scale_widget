import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 创建人： Created by zhaolong
 * 创建时间：Created by  on 2020/6/15.
 *
 * 可关注公众号：我的大前端生涯   获取最新技术分享
 * 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
 * 可关注博客：https://blog.csdn.net/zl18603543572
 */
import 'package:flutter/src/gestures/events.dart' show PointerEvent;

/// Signature for callback when the user has tapped the screen at the same
/// location twice in quick succession.
typedef GestureDoubleTapCallback = void Function(DoubleDetails details);

/// double tap callback details
/// 双击的回调信息
class DoubleDetails {
  DoubleDetails({this.pointerEvent});
  final PointerEvent pointerEvent;
  @override
  String toString() => 'DoubleDetails(pointerEvent: $pointerEvent)';
}