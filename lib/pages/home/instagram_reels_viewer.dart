import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:fixupmoto/global/model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class InstagramReelsViewer extends StatefulWidget {
  final List<ModelInstagramPost> posts;
  final int initialIndex;

  const InstagramReelsViewer({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  State<InstagramReelsViewer> createState() => _InstagramReelsViewerState();
}

class _InstagramReelsViewerState extends State<InstagramReelsViewer> {
  late final PageController _pageController;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  late int _currentIndex;
  int _loadToken = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _loadVideo(_currentIndex);
  }

  Future<void> _loadVideo(int index) async {
    final post = widget.posts[index];
    if (post.mediaType != 'VIDEO') return;

    final token = ++_loadToken;
    final controller =
        VideoPlayerController.networkUrl(Uri.parse(post.mediaUrl));
    await controller.initialize();

    if (!mounted || token != _loadToken) {
      controller.dispose();
      return;
    }

    setState(() {
      _videoController = controller;
      _chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        looping: true,
        showControls: false,
        aspectRatio: controller.value.aspectRatio,
      );
    });
  }

  void _disposeVideo() {
    _chewieController?.dispose();
    _videoController?.dispose();
    _chewieController = null;
    _videoController = null;
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
    _disposeVideo();
    _loadVideo(index);
  }

  @override
  void dispose() {
    _loadToken++;
    _disposeVideo();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: widget.posts.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final post = widget.posts[index];
              final isCurrent = index == _currentIndex;

              return Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  if (isCurrent && _chewieController != null)
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoController!.value.size.width,
                        height: _videoController!.value.size.height,
                        child: Chewie(controller: _chewieController!),
                      ),
                    )
                  else
                    CachedNetworkImage(
                      imageUrl: post.thumbnailUrl.isNotEmpty
                          ? post.thumbnailUrl
                          : post.mediaUrl,
                      fit: BoxFit.cover,
                    ),
                  if (isCurrent && _chewieController == null)
                    const Center(
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24 + MediaQuery.of(context).padding.bottom,
                    child: Text(
                      post.caption,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
