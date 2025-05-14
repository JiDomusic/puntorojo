import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SectionContent extends StatelessWidget {
  final String pageTitle;
  final String sectionId;

  const SectionContent({
    super.key,
    required this.pageTitle,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context) {
    final collection = '$sectionId${pageTitle.toLowerCase()}';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final docs = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: docs.length,
          itemBuilder: (_, index) {
            final doc = docs[index];
            final url = doc['url'];
            final title = doc['title'];
            final desc = doc['description'];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(desc),
                    const SizedBox(height: 8),
                    YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: YoutubePlayer.convertUrlToId(url) ?? '',
                        flags: const YoutubePlayerFlags(autoPlay: false),
                      ),
                      showVideoProgressIndicator: true,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
