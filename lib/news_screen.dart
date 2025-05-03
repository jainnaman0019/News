import 'package:flutter/material.dart';
import 'package:news/news_service.dart';
import 'package:news/newstile.dart';
import 'package:news/bookmark_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService newsService = NewsService();
  List<dynamic> articles = [];

  String selectedCategory = 'technology';
  String selectedLanguage = 'en';

  final List<String> categories = [
    'technology',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'agriculture',
  ];

  // Add new regional languages here
  final List<String> languages = ['en', 'hi', 'bn', 'ta'];

  @override
  void initState() {
    super.initState();
    _reloadNews();
  }

  void _reloadNews() {
    setState(() => articles = []);
    newsService.fetchnews(selectedCategory, selectedLanguage).then((data) {
      setState(() => articles = data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest News'),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => BookmarkScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Language selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text('Language:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedLanguage,
                  items: languages
                      .map((lang) => DropdownMenuItem(
                            value: lang,
                            child: Text(lang.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (lang) {
                    if (lang == null) return;
                    setState(() => selectedLanguage = lang);
                    _reloadNews();
                  },
                ),
              ],
            ),
          ),

          // Category selector
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, i) {
                final cat = categories[i];
                final isSelected = cat == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedCategory = cat);
                    _reloadNews();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      cat.toUpperCase(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Article list
          Expanded(
            child: articles.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (_, idx) {
                      final a = articles[idx];
                      return NewsTile(
                        title: a['title'] ?? 'No title',
                        description: a['description'] ?? '',
                        urlToImage: a['urlToImage'] ??
                            'https://via.placeholder.com/150',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
