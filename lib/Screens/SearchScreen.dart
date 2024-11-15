import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflixappassignment/Components/Searchcard.dart';
import 'package:netflixappassignment/Controller/Moviecontroller.dart';
import 'package:netflixappassignment/Networks/url.dart';
import 'package:netflixappassignment/Screens/MainScreen.dart';
import 'package:netflixappassignment/Screens/MoviedetailsScreen.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final Moviecontroller moviecon = Get.put(Moviecontroller());
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leadingWidth: Get.width,
          leading: Padding(
            padding: const EdgeInsets.only(top:10,left: 10,bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => {Get.offAll(const Mainscreen(),arguments: {'correntindex':0})},
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.arrow_back_ios,
                      weight: 800,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: Get.height,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(65, 209, 205, 205),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                              autocorrect: true,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.dmSans(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                hintText:
                                    'Search game,shows,movies..', // Optional hint text
                                hintStyle: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                                border: InputBorder.none, // Remove default border
                              ),
                              onSubmitted: (value) {
                                moviecon.searchMovies('${Apiurl.baseurl}/search/shows?q=$value');
                              },
                            ),
                        ),
                      ],
                    )
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          elevation: 0,     
        ),
        body: Obx(() {
          if (moviecon.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (moviecon.searchResults.isEmpty) {
            return const Center(child: Text('No Movies Available'));
          } else {
            // print(moviecon.movies);
            return ListView.builder(
              itemCount: moviecon.searchResults.length,
              itemBuilder: (context, index) {
                var movie = moviecon.searchResults[index]["show"];
                String imageUrl =
                    movie['image'] != null && movie['image']['medium'] != null
                        ? movie['image']['medium']
                        : 'https://via.placeholder.com/150';
                bool isimage =
                    movie['image'] != null && movie['image']['medium'] != null
                        ? true
                        : false;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: SearchCard(
                    imageUrl: imageUrl,
                    title: movie['name'] ?? 'No Title',
                    summary:
                        movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ??
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
    );
  }
}