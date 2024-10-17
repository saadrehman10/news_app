import 'package:flutter/material.dart';
import 'package:news_app/apis/news_api.dart';
import 'package:news_app/models/headlines.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: NewsApis.newsApisHeadlines(countryCode: 'us'),
              builder: (context, AsyncSnapshot<Headlines> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(snapshot.error.toString()),
                      IconButton(
                        onPressed: () {
                          setState(() {});
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        return Text('${snapshot.data!.articles![index].content}');
                      });
                } else {
                  return const Placeholder();
                }
              })),
    );
  }
}
