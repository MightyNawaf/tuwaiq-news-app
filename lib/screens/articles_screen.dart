import 'dart:developer';

import 'package:disney/components/news_card.dart';
import 'package:disney/constants/spacings.dart';
import 'package:disney/models/news.dart';
import 'package:disney/services/api.dart';
import 'package:flutter/material.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => ArticlesScreenState();
}

class ArticlesScreenState extends State<ArticlesScreen> {
  TextEditingController controller = TextEditingController(text: 'apple');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _AppBar(
            controller: controller,
            onSubmitted: () {
              setState(() {});
            },
            onTyped: () {
              log('Hello');
            },
          ),
          FutureBuilder(
            future: NewsService().getNews(controller.text),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                final news = snapshot.data;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 250,
                  ),
                  itemCount: news?.articles?.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (news?.articles?.isEmpty ?? true) {
                      return const SizedBox.shrink();
                    }
                    return NewsCard(
                      article: news?.articles?[index] ?? Article(),
                    );
                  },
                );
              } else {
                return const Text('Error');
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({
    required this.controller,
    required this.onSubmitted,
    required this.onTyped,
  });

  final TextEditingController controller;
  final Function onSubmitted;
  final Function onTyped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
          const Column(
            children: [
              Text('Disney News', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Latest news from Disney', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w100)),
            ],
          ),
          kVSpace16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              onChanged: (_) {
                onTyped.call();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w100),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                //   borderRadius: BorderRadius.circular(16),
              ),
              controller: controller,
              onSubmitted: (_) {
                onSubmitted.call();
              },
            ),
          ),
        ],
      ),
    );
  }
}
