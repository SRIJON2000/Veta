import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:veta/constants.dart';

class AgoraCall extends StatefulWidget {
  const AgoraCall({super.key});

  @override
  State<AgoraCall> createState() => _AgoraCallState();
}

class _AgoraCallState extends State<AgoraCall> {
  final AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: "eefa4637e8124cd989dd1f1c529a167a",
          channelName: "vetaTest",
          username: '$user!.email',
          tempToken:
              "007eJxTYPgudaeQb/rV/wk5ey6fXamuYVyo6nqiZwLXgRcqLZ9F6iYoMKSmpiWamBmbp1oYGpkkp1haWKakGKYZJpsaWSYampknntScltwQyMgwfQEXIyMDBIL4HAxlqSWJIanFJQwMACXAIcM="),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ]);
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Video Call'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          AgoraVideoViewer(
            client: client,
            layoutType: Layout.floating,
            //enableHostControls: true, // Add this to enable host controls
            showAVState: true,
            showNumberOfUsers: true,
          ),
          AgoraVideoButtons(
            client: client,
            enabledButtons: const [
              BuiltInButtons.callEnd,
              BuiltInButtons.toggleCamera,
              BuiltInButtons.switchCamera,
            ],
            extraButtons: [
              GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                }),
                child: const Image(
                  image: AssetImage('assets/images/leaveChannel.png'),
                  height: 70,
                  width: 70,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
