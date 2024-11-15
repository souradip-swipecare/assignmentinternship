import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixappassignment/Components/Moviecard.dart';
import 'package:netflixappassignment/Controller/Moviecontroller.dart';
import 'package:netflixappassignment/Screens/MainScreen.dart';
import 'package:netflixappassignment/Screens/MoviedetailsScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final Moviecontroller  moviecon = Get.put(Moviecontroller());
  @override
  void initState() {
    super.initState();
    // Fetch movies at the starting of screen
    moviecon.fetchMovies();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF780909), // Red
            Color(0xFF000000), // Black
          ],
          stops: [0.0, 0.7],
        ),
      ),
      child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              elevation:0,
              toolbarHeight: 60,
              leadingWidth: Get.width,
              leading: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "For souradip ",
                            style: GoogleFonts.dmSans(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 25,
                            ),
                            
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.white,
                          ),
                          onTap: () => {
                            Get.offAll(
                                const Mainscreen(),arguments: {'currentindex':1}), 
                          },
                        ),
                        
                        ],
                    ),
                  ),
               
            ),
            body: Obx(() {
            if (moviecon.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (moviecon.movies.isEmpty) {
              return const Center(child: Text('No Movies Available'));
            } else {
              // print(moviecon.movies);
              return ListView.builder(
                itemCount: moviecon.movies.length,
                
                itemBuilder: (context, index) {
                  var movie = moviecon.movies[index]["show"];
                  String imageUrl = movie['image'] != null && movie['image']['medium'] != null
                      ? movie['image']['medium']
                      : 'https://via.placeholder.com/150';
                  bool isimage =  movie['image'] != null && movie['image']['medium'] != null
                          ? true
                          : false;
                      
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: MovieCard(
                      imageUrl: imageUrl,
                      title: movie['name'] ?? 'No Title',
                      summary: movie['summary']
                              ?.replaceAll(RegExp(r'<[^>]*>'), '') ??
                          'No summary available',
                      isimage: isimage,
                      onTap: () {
                        Get.to(
                          const Moviedetailsscreen(),
                          arguments: movie,
                          transition: Transition.rightToLeft,
                          duration: const Duration(milliseconds: 400),
                          );
                      },
                      rating: movie['rating']['average'] != null
                          ? movie['rating']['average'].toStringAsFixed(1)
                          : "Not rated",
                    
                    ),
                  );
                },
              );
            }
          }),
          ),
        
      ),
    );
  }
}