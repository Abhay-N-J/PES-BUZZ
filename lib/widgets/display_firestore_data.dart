import 'package:flutter/material.dart';
import '/models/news_item_model.dart';
import '/services/firestore_service.dart';
import '/widgets/list_view_builder_tab.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DisplayFirestoreData extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final String category;

  DisplayFirestoreData({required this.category});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsItemModel>>(
      future: firestoreService.fetchNewsItemsByCategory(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return (const Center(
            child: SpinKitDualRing(
              color: Color(0xFF4169E1),
              size: 30.0,
            ),
          ));
        } else if (snapshot.data == null) {
          return const Center(child: Text('An error occurred.'));
        } else {
          return ListViewBuilderByTab(
              category: category, newsItems: snapshot.data!);
        }
      },
    );
  }
}
