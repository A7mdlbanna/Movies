import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/shared/constants.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      backgroundColor: const Color(0xFF151C25),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              // alignment: Alignment.bottomLeft,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                        colors: [Color(0xFF151C25), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: Image.asset(
                    'assets/posters/dune.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(backgroundColor: Colors.black26,),
                              ImageIcon(AssetImage('assets/icons/previous.png'), size: 50, color: Colors.white,),
                            ],
                          ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
