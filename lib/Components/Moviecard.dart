import 'package:flutter/material.dart';
import 'package:netflixappassignment/Constants/images.dart';

class MovieCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String summary;
  final bool isimage;
  final VoidCallback  onTap;
  final String rating;
  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.summary,
    required this.isimage,  required this.onTap, required this.rating
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    
    String truncatedSummary = widget.summary.length > 100
        ? '${widget.summary.substring(0, 100)}...'
        : widget.summary;

    return  InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 10, 
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(20),
        ),
        shadowColor:
            Colors.black.withOpacity(0.4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250, 
                child: widget.isimage?Image.network(
                  widget.imageUrl,
                  fit: BoxFit.fill, 
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child; 
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/logo.png',
                        fit: BoxFit.fill);
                  },
                ):Image.asset(Images.logo),
              ),
              const SizedBox(height: 10),
              // Movie Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children:[
                    Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                 const SizedBox(width: 8,),
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
                  ] 
                  ),
              ),
              const SizedBox(height: 5),
              // Movie Summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  _isExpanded ? widget.summary : truncatedSummary,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: _isExpanded ? null : 2, 
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              // "Read More" Button
              if (widget.summary.length >
                  100)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded; 
                      });
                    },
                    child: Text(
                      _isExpanded ? "Show Less" : "Read More",
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
