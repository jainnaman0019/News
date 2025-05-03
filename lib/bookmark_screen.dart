import 'package:flutter/material.dart';
import 'package:news/bookmark.dart';
import 'package:news/bookmark_service.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final BookmarkService bookmarkService = BookmarkService();
  List<Bookmark> bookmarks = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final result = await bookmarkService.getBookmarks();
    setState(() {
      bookmarks = result;
    });
  }

  void deleteBookmark(String title) async {
    await bookmarkService.removeBookmark(title);
    await loadBookmarks(); // Refresh list
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bookmark removed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookmarks")),
      body: bookmarks.isEmpty
          ? Center(child: Text("No bookmarks yet"))
          : ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                final item = bookmarks[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(item.urlToImage, width: 60, fit: BoxFit.cover),
                    title: Text(item.title),
                    subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteBookmark(item.title),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
