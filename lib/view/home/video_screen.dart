// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoScreen extends StatefulWidget {
//   const VideoScreen({super.key, required this.videoPlayerController});
  
//     final VideoPlayerController videoPlayerController ;
//   final bool looping = false;

//   @override
//   State<VideoScreen> createState() => _VideoScreenState();
// }

// class _VideoScreenState extends State<VideoScreen> {
//     ChewieController? _chewieController;

//   late VideoPlayerController _controller;


//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     _chewieController=ChewieController(
//       videoPlayerController: widget.videoPlayerController,
//       aspectRatio: 16/9,
//       autoInitialize: true,
//       looping: widget.looping,
//       errorBuilder: (context,errorMassage){
//         return Center(
//           child: Text(errorMassage,style: TextStyle(color: Colors.white),),
//         );
//       },
//     );
//   }
//   @override
//   void dispose() {
//     widget.videoPlayerController.dispose();
//     _chewieController!.dispose();
//     super.dispose();
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Chewie(controller: _chewieController!),
//     )
      
//       //  Center(
//       //   child: _controller.value.isInitialized
//       //       ? AspectRatio(
//       //           aspectRatio: _controller.value.aspectRatio,
//       //           child: VideoPlayer(_controller),
//       //         )
//       //       : Container(),
//       // ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     setState(() {
//       //       _controller.value.isPlaying
//       //           ? _controller.pause()
//       //           : _controller.play();
//       //     });
//       //   },
//       //   child: Icon(
//       //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//       //   ),
//       // ),
//     );
//   }






//   }


