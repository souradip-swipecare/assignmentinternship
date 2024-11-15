import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixappassignment/Constants/images.dart';
import 'package:netflixappassignment/Screens/MainScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool loading = false;
  bool animloading=true;
  @override
  void initState() {
    super.initState();
     Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        animloading = false;
        loading = true; 
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        loading = false;
      });
      Get.offAll(() => const Mainscreen(), transition: Transition.leftToRight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:const EdgeInsets.all(30),
                // using dummy lottie
                // child: Lottie.network("https://lottie.host/764364b6-ef83-4435-953e-9dee68e5f79d/RhwaHj0VAw.json"),
                child: animloading?Image.asset(Images.gifs):Image.asset(Images.logo)
            ),
            const SizedBox(
              height: 100,
            ),
            loading? const CircularProgressIndicator(
              color: Colors.red, // Red circular progress bar
            ):const SizedBox(height: 5,),
        ]),
      ),
    ));
  }
}
