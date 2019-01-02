import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:gankflutter/utils/SharePrefUtils.dart';
import 'package:gankflutter/utils/IndicatorUtils.dart';
import 'package:gankflutter/utils/Constant.dart';
import 'package:gankflutter/api/Api.dart';
import 'package:gankflutter/api/Http.dart';
import 'package:gankflutter/model/DailyResponse.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String feedType;
  bool showTitle = false;

  DetailPage({Key key, this.feedType, this.showTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with IndicatorFactory {
  List listData;
  var curPage = 1;
  var listTotalSize = 0;
  var requestError = false;

  RefreshController _refreshController;

  void enterRefresh() {
    _refreshController.requestRefresh(true);
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    _loadingData();
  }

  @override
  Widget build(BuildContext context) {

    if (widget.showTitle) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.feedType),
        ),
        body: detailBuild(context),
      );
    } else {
      return new Scaffold(
        body: detailBuild(context),
      );
    }
  }

  Widget detailBuild(BuildContext context) {
    return requestError
        ? buildExceptionIndicator("网络请求出错了！")
        : listData == null
        ? new Center(
      child: new CupertinoActivityIndicator(),
    )
        : new SmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        controller: _refreshController,
        headerBuilder: buildDefaultHeader,
        footerBuilder: buildDefaultFooter,
        footerConfig: new RefreshConfig(),
        onRefresh: (up) {
          if (up) {
            _pullToRefresh();
          } else {
            _loadingMore();
          }
        },
        child: buildListViewBuilder(context, listData));
  }

  //网络请求
  getNewsList(bool isLoadMore) async {
    String url = getUrl();
    await HttpExt.getGankData(url).then((CategoryResponse categoryResponse) {
      if (!categoryResponse.error) {
        var _listData = categoryResponse.results;
        print(_listData);
        if (_listData.length > 0) {
          setState(() {
            if (!isLoadMore) {
              listData = _listData;
              //目前只缓存第一页数据
              SharePrefUtils.saveString(
                  url, json.encode(categoryResponse.toJson()));
            } else {
              List list1 = new List();
              list1.addAll(listData);
              list1.addAll(_listData);
              listData = list1;
            }
          });
        }
      }

      if (isLoadMore) {
        _refreshController.sendBack(false, RefreshStatus.idle);
      } else {
        _refreshController.sendBack(true, RefreshStatus.completed);
      }
      return false;
    }).catchError((error) {
      _refreshController.sendBack(true, RefreshStatus.failed);
      return false;
    });
  }

  Widget buildListViewBuilder(context, List results) {
    print(results);
    switch (results.length) {
      case 1:
        return new Center(
          child: new Card(
            elevation: 16.0,
            child: new Text("暂无数据"),
          ),
        );
      default:
        return new ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(2.0),
          itemCount: results == null ? 0 : results.length,
          itemBuilder: (context, i) {
            return buildRow(context, results[i], false, null);
          },
        );
    }
  }

  //刷新
  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  //加载更多
  void _loadingMore() {
    print("load more ... ");
    curPage++;
    getNewsList(true);
  }

  void _loadingData() async {
    //先获取缓存数据
    String url = getUrl();
    var cacheData = await SharePrefUtils.get(url);
    if (cacheData != null) {
      var userMap = json.decode(cacheData);
      CategoryResponse categoryResponse = CategoryResponse.fromJson(userMap);
      print("获取缓存数据成功");
      setState(() {
        listData = categoryResponse.results;
      });
    }

    if (null == listData) {
      print("开始网络请求");
      getNewsList(false);
    }
  }

  String getUrl() {
    var url = Api.feedUrl;
    url += widget.feedType + '/10/' + this.curPage.toString();
    print("feedListUrl: $url");
    return url;
  }
}
