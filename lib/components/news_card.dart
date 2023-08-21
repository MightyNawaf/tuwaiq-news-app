import 'package:cached_network_image/cached_network_image.dart';
import 'package:disney/constants/spacings.dart';
import 'package:disney/models/news.dart';
import 'package:disney/screens/news_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
              article: article,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              height: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage ?? 'https://demofree.sirv.com/nope-not-here.jpg',
                errorWidget: (context, url, s) {
                  return Container(color: Colors.red);
                },
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            kVSpace8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'By ${article.source?.name}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                      color: Color.fromARGB(255, 62, 62, 62),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(article.publishedAt ?? '')),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w100, color: Color.fromARGB(255, 62, 62, 62)),
                ),
              ],
            ),
            kVSpace8,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    article.title ?? 'Title not found',
                    style: const TextStyle(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
                    maxLines: 4,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
