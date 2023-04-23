import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../flutter_drag_scale_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/12.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

class ImageShowPageView extends StatefulWidget {
  final List<String> imageList;
  final ImageShowType imageShowType;
  final BoxFit boxFit;
  final ValueChanged<int>? onPageChanged;
  final bool useCache;
  final Widget? placeholder;
  final Widget? iconError;

  ImageShowPageView(
      {required this.imageList,
      this.useCache = true,
      this.placeholder,
      this.iconError,
      this.imageShowType = ImageShowType.ASSET,
      this.boxFit = BoxFit.contain,
      this.onPageChanged});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<ImageShowPageView> {
  //lib/code/main_data1316.dart
  //手势识别  双击放大、双指缩放、拖动图片 依赖库使用
  bool _isBorder = true;

  ///PageView当前显示的角标
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Stack(
      ///设置子Widget默认剧中对齐
      alignment: Alignment.center,
      children: [
        ///构建PageView
        buildPageView(),

        ///页面指示器
        buildPositioneIindicator()
      ],
    );
  }

  ///页面指示器
  Positioned buildPositioneIindicator() {
    return Positioned(
      ///底部对齐
      bottom: 20,
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),

        ///设置圆角边框
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          "$currentIndex/${widget.imageList.length}",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  //lib/code/main_data1316.dart
  ///页面主体的PageView
  Positioned buildPageView() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
      child: PageView.builder(
        ///页面切换时的回调
        ///[pageIndex]页面的角标
        onPageChanged: (int pageIndex) {
          currentIndex = pageIndex + 1;
          if (widget.onPageChanged != null) {
            widget.onPageChanged!(currentIndex);
          }
          setState(() {});
        },

        ///配置滑动
        ///BouncingScrollPhysics 有回弹效果的滑动
        ///NeverScrollableScrollPhysics 不可滑动
        physics: _isBorder
            ? BouncingScrollPhysics()
            : NeverScrollableScrollPhysics(),

        ///pageView的构建子Item的构建器
        itemBuilder: (BuildContext context, int index) {
          return buildItemImageWidget(index);
        },

        ///子Item的个数
        itemCount: widget.imageList.length,
      ),
    );
  }

  //lib/code/main_data1316.dart
  ///pageView的子Item
  Widget buildItemImageWidget(int index) {
    return Center(
      ///缩放拖动组件
      child: TouchableContainer(
        ///双击放大
        doubleTapStillScale: true,

        ///当缩放拖动图片时会裡回调此方法
        scaleChanged: buildSlideAndScaleChangeFunction,

        ///需要放大拖动的子组件
        child: buildImage(index),
      ),
    );
  }

  //lib/code/main_data1316.dart
  ///当缩放拖动图片时会裡回调此方法
  buildSlideAndScaleChangeFunction(ScaleChangedModel model) {
    ///向左滑动
    if (model.currentHorizontalSlideDirectionType ==
        SlideDirectionType.toLeft) {
      ///当前放大的图片是否拖动到了左边界
      if (model.isLeftBorder) {
        _isBorder = true;
      } else {
        _isBorder = false;
      }
    } else {
      ///向右滑动
      /// 当前放大的图片是否拖动到了右边界
      if (model.isRightBorder) {
        _isBorder = true;
      } else {
        _isBorder = false;
      }
    }
    setState(() {});
  }

  buildImage(int index) {
    if (widget.imageShowType == ImageShowType.ASSET) {
      return Image.asset(
        widget.imageList[index],
        fit: widget.boxFit,
      );
    } else if (widget.imageShowType == ImageShowType.NET) {
      if (widget.useCache) {
        return CachedNetworkImage(
          imageUrl: widget.imageList[index],
          fit: widget.boxFit,
          placeholder: (context, url) => widget.placeholder == null
              ? CircularProgressIndicator()
              : widget.placeholder!,
          errorWidget: (context, url, error) => widget.placeholder == null
              ? Icon(Icons.error)
              : widget.iconError!,
        );
      }
      return Image.network(
        widget.imageList[index],
        fit: widget.boxFit,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
        },
        loadingBuilder: (
          BuildContext context,
          Widget child,
          ImageChunkEvent? loadingProgress,
        ) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }
  }
}

enum ImageShowType {
  NET,
  FILE,
  ASSET,
}
