import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/theme.dart';

class NewsList extends StatelessWidget {
  final List<Article> news;

  const NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.news.length,
        itemBuilder: (BuildContext context, int idx) {
          return _News(news: this.news[idx], index: idx);
        });
  }
}

class _News extends StatelessWidget {
  final Article news;
  final int index;

  const _News({@required this.news, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _CardTopBar(
          news: this.news,
          index: this.index,
        ),
        _CardTitle(
          news: this.news,
        ),
        _CardImage(news: this.news)
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article news;

  const _CardImage({@required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Imagen'),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article news;

  const _CardTitle({@required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(news.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article news;
  final int index;

  const _CardTopBar({@required this.news, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            '${index + 1}. ',
            style: TextStyle(color: globalTheme.accentColor),
          ),
          Text('${news.source.name}. ')
        ],
      ),
    );
  }
}
