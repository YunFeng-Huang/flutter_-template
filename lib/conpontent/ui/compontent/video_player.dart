// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// import '../css.dart';
//
// class VideoPlay extends StatefulWidget {
//   final String videoUrl;
//   VideoPlay({required this.videoUrl});
//   @override
//   _VideoPlayState createState() => _VideoPlayState();
// }
//
// class _VideoPlayState extends State<VideoPlay> {
//   String get videoUrl => widget.videoUrl;
//   // 声明视频控制器
//   late VideoPlayerController _controller;
//   bool canPlay = false;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(videoUrl)
//       ..initialize().then(
//         (_) {
//           setState(() {
//             canPlay = true;
//             _controller.pause();
//             _controller.setLooping(true);
//           });
//         },
//       );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.pause();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         _controller.value.duration != Duration.zero
//             ? VideoPlayer(_controller)
//             : Center(
//                 child: Text(
//                   '加载中...',
//                   style: font(16),
//                 ),
//               ),
//         if (canPlay)
//           Align(
//             alignment: Alignment.center,
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       Icons.play_circle_outline,
//                       color: Colors.white,
//                       size: 32,
//                     ),
//                     onPressed: () {
//                       _controller.play();
//                       setState(() {
//                         canPlay = false;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
//
// List<String> videoType = ["avi", "flv", "mpg", "mpeg", "mpe", "m1v", "m2v", "mpv2", "mp2v", "dat", "ts", "tp", "tpr", "pva", "pss", "mp4", "m4v", "m4p", "m4b", "3gp", "3gpp", "3g2", "3gp2", "ogg", "mov", "qt", "amr", "rm", "ram", "rmvb", "rpm"];
//
// bool IsVideo(value) {
//   return videoType.any((element) => value.endsWith('.$element'));
// }
