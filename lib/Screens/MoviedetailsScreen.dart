import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflixappassignment/Constants/images.dart';
import 'package:netflixappassignment/Screens/MainScreen.dart';

class Moviedetailsscreen extends StatelessWidget {
  const Moviedetailsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movie = Get.arguments;
    String genre = movie['genres'].map((genres) => genres).join(", ");
    String removeHtmlTags(String html) {
      html = html.replaceAll(RegExp(r'<p.*?>|</p>'), '');
      html = html.replaceAll(RegExp(r'<b.*?>|</b>'), '');
      return html;
    }

    bool isimage = true;
    String summ = removeHtmlTags(movie['summary']);
    if (movie == null ||
        movie['image'] == null ||
        movie['image']['original'] == null) {
      isimage = false;
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Get.height * 0.5, // 40% height for the image
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: isimage
                          ? NetworkImage(movie['image']['original'] ??
                              'https://path_to_default_image.jpg')
                          : const AssetImage(Images.logo),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      // for top arrow
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => {Get.back()},
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.arrow_back_ios,
                              weight: 800,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => {
                            Get.to(const Mainscreen(),
                                arguments: {'currentindex': 1}),
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Rest of the content wrapped with padding
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['name'] ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Airs on: ${movie['schedule']['days'].join(', ')} at ${movie['schedule']['time']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[700],
                      ),
                      Text(
                        movie['rating']['average'] != null
                            ? movie['rating']['average'].toStringAsFixed(1)
                            : "Not rated",
                        style: TextStyle(
                          color: Colors.yellow[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        genre,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summ,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
