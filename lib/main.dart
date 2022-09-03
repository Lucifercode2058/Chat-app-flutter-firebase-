import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_player/video_player.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(video());
}
class video extends StatefulWidget {


  @override

  State<video> createState() => _videoState();
}

class _videoState extends State<video> {
  VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=VideoPlayerController.asset('video/background.mp4')..initialize().then((_) {
      // Once the video has been loaded we play the video and set looping to true.
      controller.play();
      controller.setLooping(true);
      // Ensure the first frame is shown after the video is initialized.
      setState(() {});
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: controller.value.size?.width ?? 0,
                    height: controller.value.size?.height ?? 0,
                    child: VideoPlayer(controller),

                  ),

                ),
              ),
              WelcomeScreen(),
            ],
          ),
        ),
      ),
    );
  }
}






//     return MaterialApp(
//
//       home: SafeArea(
//         child: Scaffold(
//           body: Stack(
//             children: [
//               SizedBox.expand(
//                 child: FittedBox(
//                   fit: BoxFit.fill,
//                   child: SizedBox(
//                     width: controller.value.size?.width ?? 0,
//                     height: controller.value.size?.height ?? 0,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }





