import 'package:busan_trip/screen/booking_calendar_screen.dart';
import 'package:busan_trip/screen/pay_screen.dart';
import 'package:busan_trip/screen/item_review_list_screen.dart';
import 'package:busan_trip/screen/store_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../app_http/heart_list_http.dart';
import '../model/user_model.dart';
import '../vo/heart_list.dart';
import '../vo/item.dart' as itemVo;

class ItemDetailScreen extends StatefulWidget {
  final itemVo.Item item; // Item 객체를 받도록 수정

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {

  late Future<void> _loadingFuture;
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    _loadingFuture = _simulateLoading();
    _checkIfFavorited();
  }

  Future<void> _checkIfFavorited() async {
    try {
      int userId = Provider.of<UserModel>(context, listen: false).loggedInUser.u_idx;
      List<HeartList> heartList = await HeartListHttp.fetchAll(userId);
      setState(() {
        isFavorited = heartList.any((item) => item.i_idx == widget.item.i_idx);
      });
    } catch (e) {
      print('Error fetching wishlist: $e');
    }
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));

    return Scaffold(
      body: FutureBuilder<void>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildSkeletonLoader();
          } else {
            return _buildDetailContent();
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  padding: EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Icon(Icons.share_outlined, size: 18, color: Colors.grey[600],),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder:  (context) => BookingCalendarScreen(item: widget.item)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff0e4194),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  '결제하기',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 35,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 25,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey[200], thickness: 1.0,),
                    SizedBox(height: 15),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 30,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(color: Colors.grey[200], thickness: 7.0,),
                    SizedBox(height: 15),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 25,
                        width: 100,
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(color: Colors.grey[200], thickness: 1.0,),
                    SizedBox(height: 15),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 50,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 50,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300],
                        height: 50,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 35),
                    Divider(color: Colors.grey[200], thickness: 7.0,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.width,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '${widget.item.i_image}',
              fit: BoxFit.cover,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              DetailContent(
                image: widget.item.i_image,
                name: widget.item.i_name,
                wishes: widget.item.i_wishes,
                avgScore: widget.item.averageScore,
                reviews: widget.item.review_count,
                price: widget.item.i_price,
                shop_img_url: widget.item.s_img,
                shop_name: widget.item.s_name,
                address: widget.item.i_address,
                opr_house: widget.item.operation_house,
                cld_days: widget.item.closed_days,
                content: widget.item.i_content,
                manual: widget.item.manual,
                refund: widget.item.refund,
                item: widget.item,
                itemId: widget.item.i_idx,
                userId: Provider.of<UserModel>(context, listen: false).loggedInUser.u_idx,
                isFavorited: isFavorited,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailContent extends StatefulWidget {
  final String image;
  final String name;
  final int wishes;
  final double avgScore;
  final int reviews;
  final int price;
  final String shop_img_url;
  final String shop_name;
  final String address;
  final String opr_house;
  final String cld_days;
  final String content;
  final String manual;
  final String refund;
  final itemVo.Item item;
  final int itemId;
  final int userId;
  final bool isFavorited;

  const DetailContent({
    Key? key,
    required this.image,
    required this.name,
    required this.wishes,
    required this.avgScore,
    required this.reviews,
    required this.price,
    required this.shop_img_url,
    required this.shop_name,
    required this.address,
    required this.opr_house,
    required this.cld_days,
    required this.content,
    required this.manual,
    required this.refund,
    required this.item,
    required this.itemId,
    required this.userId,
    required this.isFavorited,
  }) : super(key: key);

  @override
  _DetailContentState createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  bool isFavorited = false;
  final formatter = NumberFormat('#,###');

  @override
  void initState() {
    super.initState();
    isFavorited = widget.isFavorited;
  }

  void toggleFavorite() async {
    try {
      if (isFavorited) {
        // Fetch the wishlist to find the corresponding wish_idx
        List<HeartList> heartList = await HeartListHttp.fetchAll(widget.userId);
        int? wishIdxToDelete;

        // Find the corresponding wish_idx for the item
        for (var wish in heartList) {
          if (wish.i_idx == widget.itemId) {
            wishIdxToDelete = wish.wish_idx; // Assuming HeartList has wish_idx
            break;
          }
        }

        if (wishIdxToDelete != null) {
          await HeartListHttp.deleteWish(wishIdxToDelete);
        }
      } else {
        await HeartListHttp.addWish(widget.userId, widget.itemId);
      }

      setState(() {
        isFavorited = !isFavorited; // Toggle the favorite state
      });
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,  // Use screen width
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100), // 32는 패딩 등을 고려한 너비
                        child: Text(
                          widget.name,
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: toggleFavorite,
                            child: Icon(
                              isFavorited ? Icons.favorite : Icons.favorite_outline,
                              size: 22,
                              color: isFavorited ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 22,
                      color: Colors.red,
                    ),
                    Text(
                      ' ${widget.wishes}명이 찜했습니다',
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[500]
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 22,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 2),
                          Text(
                            '${widget.avgScore}',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ' · ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.grey[400],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder:  (context) => ItemReviewListScreen(i_idx: widget.item.i_idx)),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black,width: 1.0),
                                ),
                              ),
                              child: Text(
                                '리뷰 ${widget.reviews}개',
                                style: TextStyle(
                                  fontFamily: 'NotoSansKR',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${formatter.format(widget.price)}원 ',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '~',
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => StoreDetailScreen()),
                    // );
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            '${widget.shop_img_url}',
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${widget.shop_name}',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          _buildInfoSection(),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '상품 설명',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.content}',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 15),
                      Image.network(
                        '${widget.image}',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '상품 안내',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.manual}',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey[200], thickness: 7.0,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '취소 및 환불 규정',
                  style: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[200], thickness: 1.0,),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.refund}',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이용 안내',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Divider(color: Colors.grey[200], thickness: 1.0,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('주소', '${widget.address}'),
                  _buildInfoRow('운영요일 및 시간', '${widget.opr_house}'),
                  // _buildInfoRow('전화번호', '1661-2000'),
                  _buildInfoRow('휴무일', '${widget.cld_days}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
