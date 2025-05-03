import 'package:cloud_firestore/cloud_firestore.dart';
import 'bookmark.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addBookmark(Bookmark bookmark) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(bookmark.title); // You can use a unique ID if needed

    await docRef.set(bookmark.toMap());
  }

  Future<List<Bookmark>> getBookmarks() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .get();

    return snapshot.docs
        .map((doc) => Bookmark.fromMap(doc.data()))
        .toList();
  }

  Future<void> removeBookmark(String title) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(title);

    await docRef.delete();
  }

  Future<bool> isbookmarked(String title) async{
    final user=_auth.currentUser;
    if(user==null) return false;
    final snapshot=await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(title)
        .get(); 

        return snapshot.exists; 
  }
}
