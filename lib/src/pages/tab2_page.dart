import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_models.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/theme.dart';
import 'package:newsapp/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
                color: Colors.black54,
                height: 85,
                width: double.infinity,
                child: _ListCategories()
              ),

              if (!newsService.isLoading) 
                 Expanded(child: NewsList(newsService.getArticlesByCategorySelected)),
                                   
              if ( newsService.isLoading || newsService.headlines.length == 0)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
                )              
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int idx) {
        final nameToUpperCase = categories[idx].name;

        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _CategoryButton(
                category: categories[idx],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  '${nameToUpperCase[0].toUpperCase()}${nameToUpperCase.substring(1)}')
            ],
          ),
        );
      },
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton({this.category});

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        print(category.name);
        newsService.selectedCategory = category.name;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: 40,
        height: 40,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: category.name == newsService.selectedCategory
              ? globalTheme.accentColor
              : Colors.black54,
          size: 20,
        ),
      ),
    );
  }
}
