import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatefulWidget {
  //For loading images from URL
  AppImage.network(
    String this.imageUrl, {
    Key? key,
    this.memCacheWidth,
    this.memCacheHeight,
    this.imageBuilder,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.httpHeaders,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.repeat = ImageRepeat.noRepeat,
    void Function(Object)? errorListener,
  })  : imageType = ImageType.network,
        asset = null,
        bytes = null,
        color = null,
        _imageProvider = CachedNetworkImageProvider(
          imageUrl,
          maxHeight: _maxHeight(height),
          maxWidth: _maxWidth(width),
          errorListener: errorListener,
        ),
        super(key: key);

  //For loading images from Asset
  AppImage.asset(
    String this.asset, {
    Key? key,
    this.memCacheWidth,
    this.memCacheHeight,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.repeat = ImageRepeat.noRepeat,
    String? package,
    AssetBundle? bundle,
  })  : imageType = ImageType.asset,
        httpHeaders = null,
        imageBuilder = null,
        imageUrl = null,
        bytes = null,
        placeholder = null,
        errorWidget = null,
        progressIndicatorBuilder = null,
        _imageProvider = ResizeImage.resizeIfNeeded(
          memCacheWidth,
          memCacheHeight,
          AssetImage(asset, bundle: bundle, package: package),
        ),
        super(key: key);

  //For loading images from Asset
  AppImage.svgAsset(
    String this.asset, {
    Key? key,
    this.memCacheWidth,
    this.memCacheHeight,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.repeat = ImageRepeat.noRepeat,
    String? package,
    AssetBundle? bundle,
  })  : imageType = ImageType.svgAsset,
        httpHeaders = null,
        bytes = null,
        imageBuilder = null,
        imageUrl = null,
        placeholder = null,
        errorWidget = null,
        progressIndicatorBuilder = null,
        _imageProvider = ResizeImage.resizeIfNeeded(
          memCacheWidth,
          memCacheHeight,
          AssetImage(asset, bundle: bundle, package: package),
        ),
        super(key: key);

  AppImage.bytes(
    this.bytes, {
    Key? key,
    this.memCacheWidth,
    this.memCacheHeight,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.repeat = ImageRepeat.noRepeat,
  })  : imageType = ImageType.bytes,
        httpHeaders = null,
        imageBuilder = null,
        imageUrl = null,
        asset = null,
        placeholder = null,
        errorWidget = null,
        progressIndicatorBuilder = null,
        _imageProvider = ResizeImage.resizeIfNeeded(
            memCacheWidth, memCacheHeight, Image.memory(bytes!).image),
        super(key: key);

  static int? _maxHeight(double? height) {
    if (height == null) return null;
    return height.isFinite ? height.round() : double.maxFinite.round();
  }

  static int? _maxWidth(double? width) {
    if (width == null) return null;
    return width.isFinite ? width.round() : double.maxFinite.round();
  }

  final Uint8List? bytes;

  //Get ImageProvider for this image
  final ImageProvider _imageProvider;
  final Color? color;

  /// How to paint any portions of the layout bounds not covered by the image.
  final ImageRepeat repeat;

  //Asset path hen [imageType] is asset
  final String? asset;

  //URL of the image when [imageType] is network
  final String? imageUrl;

  /// Optional headers for the http request of the image url
  final Map<String, String>? httpHeaders;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// Will resize the image in memory to have a certain width using [ResizeImage]
  final int? memCacheWidth;

  /// Will resize the image in memory to have a certain height using [ResizeImage]
  final int? memCacheHeight;

  /// Optional builder to further customize the display of the image.
  final ImageWidgetBuilder? imageBuilder;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  //Image Size
  final double? width;
  final double? height;

  /// How to inscribe the image into the space allocated during layout.
  ///
  /// The default varies based on the other fields. See the discussion at
  /// [paintImage].
  final BoxFit? fit;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorWidget;

  final ImageType imageType;

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  ImageProvider get imageProvider => widget._imageProvider;

  late Size _screenPhysicalSize;

  late double _devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    _getScreenPhysicalSize(context);

    switch (widget.imageType) {
      case ImageType.bytes:
        return Image.memory(
          widget.bytes!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          cacheHeight: _getCacheHeight(),
          cacheWidth: _getCacheWidth(),
          color: widget.color,
        );

      case ImageType.svgAsset:
        return SvgPicture.asset(
          widget.asset ?? '',
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
        );

      case ImageType.asset:
        return Image.asset(
          widget.asset ?? '',
          height: widget.height,
          width: widget.width,
          cacheHeight: _getCacheHeight(),
          cacheWidth: _getCacheWidth(),
          color: widget.color,
          fit: widget.fit,
          repeat: widget.repeat,
        );

      case ImageType.network:
        return CachedNetworkImage(
          imageUrl: widget.imageUrl ?? '',
          memCacheHeight: _getCacheHeight(),
          memCacheWidth: _getCacheWidth(),
          imageBuilder: widget.imageBuilder,
          fit: widget.fit,
          placeholder: widget.placeholder,
          httpHeaders: widget.httpHeaders,
          height: widget.height,
          width: widget.width,
          repeat: widget.repeat,
          progressIndicatorBuilder: widget.progressIndicatorBuilder,
          errorWidget: widget.errorWidget,
        );

      default:
        return const SizedBox();
    }
  }

  void _getScreenPhysicalSize(BuildContext context) {
    final mq = MediaQuery.of(context);
    _devicePixelRatio = mq.devicePixelRatio;
    _screenPhysicalSize = mq.size * _devicePixelRatio;
  }

  int? _getCacheHeight() {
    if (widget.memCacheHeight != null) return widget.memCacheHeight;
    if (widget.height != null && widget.height!.isFinite)
      return (widget.height! * _devicePixelRatio).round();
    if (widget.width != null) return null;
    return _screenPhysicalSize.height.round();
  }

  int? _getCacheWidth() {
    if (widget.memCacheWidth != null) return widget.memCacheWidth;
    if (widget.width != null && widget.width!.isFinite)
      return (widget.width! * _devicePixelRatio).round();
    if (widget.height != null) return null;
    return _screenPhysicalSize.width.round();
  }
}

enum ImageType { asset, network, svgAsset, bytes }
