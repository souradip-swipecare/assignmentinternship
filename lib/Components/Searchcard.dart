import 'package:flutter/material.dart';
import 'package:netflixappassignment/Constants/images.dart';

class SearchCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String summary;
  final bool isimage;
  final VoidCallback onTap;
  final String rating;
  const SearchCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.summary,
      required this.isimage,
      required this.onTap,
      required this.rating});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    String truncatedSummary = widget.summary.length > 100
        ? '${widget.summary.substring(0, 100)}...'
        : widget.summary;

    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 150,
                child: widget.isimage
                    ? Image.network(
                        widget.imageUrl,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/logo.png',
                              fit: BoxFit.fitWidth);
                        },
                      )
                    : Image.asset(Images.logo,
                        fit: BoxFit.fitWidth), // Adjusted to BoxFit.contain
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                          ),
                          Text(
                            widget.rating,
                            style: TextStyle(
                              color: Colors.yellow[700],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                         truncatedSummary,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        maxLines:  3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
