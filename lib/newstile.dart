import 'package:flutter/material.dart';
import 'package:news/bookmark.dart';
import 'package:news/bookmark_service.dart';
import 'package:news/articles_details_screen.dart'; // Import this!

class NewsTile extends StatelessWidget {
  final String title;
  final String urlToImage;
  final String description;

  final BookmarkService bookmarkService = BookmarkService();

  NewsTile({
    required this.title,
    required this.urlToImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final bookmark = Bookmark(
      title: title,
      urlToImage: urlToImage,
      description: description,
    );

    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            urlToImage,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey,
              child: Center(child: Icon(Icons.broken_image, size: 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                //Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.bookmark_add),
                      
                      onPressed: () async { await bookmarkService.addBookmark(bookmark);
                       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bookmark saved to Firebase!')),
    );}
                      
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ArticleDetailsScreen(
                              title: title,
                              imageUrl: urlToImage,
                              description: description,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
