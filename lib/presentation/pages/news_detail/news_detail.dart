import 'package:flutter/material.dart';
import 'package:newsapp/core/adaptive_screen.dart';
import 'package:newsapp/core/colors.dart';
import 'package:newsapp/core/utils/time_formater.dart';
import 'package:newsapp/domain/entities/news_article.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailPage({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text(
          'News Articles',
          style: TextStyle(
            fontSize: SizeConfig.screenWidth * 0.1,
            fontWeight: FontWeight.w900,
            foreground: Paint()..shader = kAppBarTextColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.02,
                vertical: SizeConfig.screenWidth * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: SizeConfig.screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/default_news.png',
                      image: article.urlToImage.isNotEmpty ? article.urlToImage : '',
                      width: double.infinity,
                      height: SizeConfig.screenHeight * 0.22,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/default_news.png',
                          width: double.infinity,
                          height: SizeConfig.screenHeight * 0.22,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Text(
                    article.description,
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: SizeConfig.screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      article.author,
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: SizeConfig.screenWidth * 0.03,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      timeToReadableFormat(article.publishedAt),
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: SizeConfig.screenWidth * 0.03,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.screenHeight * 0.02,
            ),
            child: OutlinedButton(
              onPressed: () => _launchURLBrowser(),
              style: OutlinedButton.styleFrom(
                backgroundColor: kNewsButtonColor,
                side: BorderSide(
                  color: kNewsButtonBorderColor,
                  width: 2.0,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.01,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.2,
                ),
                child: Text(
                  "Go to original link",
                  style: TextStyle(
                    color: kNewsButtonTextColor,
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launchURLBrowser() async {
    if (await canLaunchUrlString(article.url)) {
      await launchUrlString(
        article.url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch ${article.url}';
    }
  }
}
