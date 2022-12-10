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
            "007eJxTYPjAeunINGFzz+baZBeLKL2+eYxHvqnfXqSZVXCj8RnjM1UFhtTUtEQTM2PzVAtDI5PkFEsLy5QUwzTDZFMjy0RDM/PEv6FTkhsCGRlkek1YGBkgEMTnYChLLUkMSS0uYWAAAJ9CIFw="),
  );
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora VideoUIKit'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
                layoutType: Layout.floating,
                enableHostControls: true, // Add this to enable host controls
              ),
              AgoraVideoButtons(
                client: client,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
