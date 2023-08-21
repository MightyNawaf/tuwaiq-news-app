import 'package:cached_network_image/cached_network_image.dart';
import 'package:disney/constants/spacings.dart';
import 'package:disney/models/news.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Material(
            elevation: 10,
            child: Container(
              height: 130,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  kVSpace64,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
                        const Spacer(),
                        const Hero(
                          tag: 'Disney News',
                          child: Column(
                            children: [
                              Text('Disney News', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text('Latest news from Disney',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(width: 24.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          kVSpace16,
          CachedNetworkImage(
            imageUrl: article.urlToImage ?? 'https://demofree.sirv.com/nope-not-here.jpg',
            errorWidget: (context, url, s) {
              return Container(color: Colors.red);
            },
            width: 300,
            fit: BoxFit.cover,
          ),
          kVSpace16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Authored by ${article.author}',
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w100, color: Color.fromARGB(255, 62, 62, 62)),
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.parse(article.publishedAt ?? '')),
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w100, color: Color.fromARGB(255, 62, 62, 62)),
                ),
              ],
            ),
          ),
          kVSpace16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              article.content ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          kVSpace32,
          ZoomTapAnimation(
            child: InkWell(
              onTap: () {
                launchUrl(Uri.parse(article.url ?? 'www.google.com'));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.red, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Center(
                  child: Text(
                    'View more',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),
          kVSpace64,
        ],
      ),
    );
  }
}
