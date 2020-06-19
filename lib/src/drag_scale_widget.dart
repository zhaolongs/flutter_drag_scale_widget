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
import 'package:flutter/material.dart';
import './ds_touchable_container.dart';

@immutable
class DragScaleContainer extends StatefulWidget {
  Widget child;

  /// 双击内容是否一致放大，默认是true，也就是一致放大
  /// 如果为false，第一次双击放大两倍，再次双击恢复原本大小
  bool doubleTapStillScale;
  DragScaleContainer({Widget child, bool doubleTapStillScale = true})
      : this.child = child,
        this.doubleTapStillScale = doubleTapStillScale;
  @override
  State<StatefulWidget> createState() {
    return _DragScaleContainerState();
  }
}

class _DragScaleContainerState extends State<DragScaleContainer> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: TouchableContainer(
          child: widget.child, doubleTapStillScale: widget.doubleTapStillScale),
    );
  }
}