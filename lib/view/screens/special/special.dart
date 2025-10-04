import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';

class Special extends StatefulWidget {
  const Special({super.key});

  @override
  State<Special> createState() => _SpecialState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _SpecialState extends State<Special> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xffF7F9FA),
        body: Column(
          children: [
            // Top Image & Text Section
            Container(
              width: Get.width,
              height: Get.height / 2.9,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffF78520), Color(0xffffffff)],
                ),
                image: const DecorationImage(
                  image: AssetImage("asset/images/home/home_background.png"),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 20,
                  right: 20,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: SizedBox(
                            height: Get.width / 20,
                            width: Get.width / 20,
                            child: Image.asset(
                              "asset/images/home/location.png",
                              color: const Color(0xffF78520),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width / 50),
                        const Text(
                          "Vrajbhoomi\nNana Varachha, Surat",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.adminBottomBar);
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SizedBox(
                              height: Get.width / 20,
                              width: Get.width / 20,
                              child: Image.asset(
                                "asset/images/home/person.png",
                                color: const Color(0xffF78520),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Get.width / 50),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.shoppingCard);
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: SizedBox(
                              height: Get.width / 20,
                              width: Get.width / 20,
                              child: Image.asset(
                                "asset/images/home/cart.png",
                                color: const Color(0xffF78520),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height / 40),
                    Text(
                      "Ladoo Making Process at hometown , Frenchies Specials",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                    ),
                    Text(
                      "Experience our authentic ladoo-making process and savor premium, Frenchies-inspired snacks crafted with tradition and finest ingredients.",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons acting as tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2.2,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _tabController.animateTo(0);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tabController.index == 0
                          ? const Color(0xffF78520)
                          : const Color(0xffFCE4CE),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: _tabController.index == 0
                            ? BorderSide.none
                            : const BorderSide(
                                color: Color(0xffF78520),
                                width: 1,
                              ),
                      ),
                    ),
                    child: Text(
                      "Making Special",
                      style: TextStyle(
                        color: _tabController.index == 0
                            ? Colors.white
                            : Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Get.width / 50),
                SizedBox(
                  width: Get.width / 2.2,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _tabController.animateTo(1);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tabController.index == 1
                          ? const Color(0xffF78520)
                          : const Color(0xffFCE4CE),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: _tabController.index == 1
                            ? BorderSide.none
                            : const BorderSide(
                                color: Color(0xffF78520),
                                width: 1,
                              ),
                      ),
                    ),
                    child: Text(
                      "Frenchies Special",
                      style: TextStyle(
                        color: _tabController.index == 1
                            ? Colors.white
                            : Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height / 60),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // Making Special Tab
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: _buildContentCard(
                            title: "Our Value",
                            content:
                                "Our ladoo making process follows traditional methods passed down through generations. We start with the finest quality ingredients including pure ghee, premium nuts, and aromatic spices. Each step is carefully executed to ensure the perfect texture and authentic taste that our customers love.",
                            imagePath: "asset/images/special/our_value.png",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 12.0,
                          ),
                          child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildFeatureItem(
                                title: 'Pure Cow Ghee',
                                subtitle:
                                    'Authentic clarified butter for rich taste and texture',
                                imagePath: "asset/images/special/tree.png",
                                backgroundColor: const Color(0xffFAA423),
                              ),
                              _buildFeatureItem(
                                title: 'Premium Nuts & Dry Fruits',
                                subtitle:
                                    'Finest quality almonds, cashews, and pistachios',
                                imagePath: "asset/images/special/dry_fruit.png",
                                backgroundColor: const Color(0xffF7611B),
                              ),
                              _buildFeatureItem(
                                title: 'Aromatic Spices',
                                subtitle:
                                    'Traditional spices for authentic flavor',
                                imagePath: "asset/images/special/spice.png",
                                backgroundColor: const Color(0xffF7611B),
                              ),
                              _buildFeatureItem(
                                title: 'Natural Sweeteners',
                                subtitle: 'Pure jaggery and natural sweeteners',
                                imagePath: "asset/images/special/jaggery.png",
                                backgroundColor: const Color(0xffFAA423),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20,
                        right: 20,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Our Frenchies Specials",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Color(0xff828590),
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "View All",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Color(0xffF2722D),
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height / 50),
                          _buildFoodItemCard(
                            imageUrl: "asset/images/home/khaman.png",
                            title: "French Butter Cookies",
                            subtitle:
                                "Delicate butter cookies with a hint of vanilla and a perfect crunch. Made with premium French butter.",
                            onExploreMore: () {
                              print("Explore More tapped!");
                            },
                          ),
                          SizedBox(height: Get.height / 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItemCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required VoidCallback onExploreMore,
  }) {
    return Container(
      width: Get.width,
      height: Get.height / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            child: Image.asset(
              imageUrl,
              height: Get.height / 4,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 15,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Color(0xff666666),
                  ),
                ),
                SizedBox(height: Get.height / 50),
                SizedBox(
                  width: double.infinity, // full width
                  child: ElevatedButton(
                    onPressed: onExploreMore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFB8C00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const Text(
                      "Add to Card",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard({
    required String title,
    required String content,
    required String imagePath,
  }) {
    return Container(
      height: Get.height / 3.7,
      width: Get.width,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: Get.width / 20,
            offset: Offset(0, Get.height / 80),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: Get.width / 15,
            offset: Offset(0, Get.height / 50),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: Get.width / 8,
                height: Get.width / 8,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xffED5439), Color(0xffDB2730)],
                  ),
                  borderRadius: BorderRadius.circular(Get.width / 25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(9),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(imagePath),
                  ),
                ),
              ),
              SizedBox(width: Get.width / 25),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height / 100),
          Text(
            content,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required String subtitle,
    required String imagePath,
    required Color backgroundColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Get.width / 7,
          height: Get.width / 7,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(Get.width / 40),
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.6,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
        SizedBox(height: Get.height / 70),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Get.height / 140),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 50),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final VoidCallback onExploreMore;

  const FoodItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.onExploreMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width, // Adjust width as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
            child: Image.asset(
              imageUrl,
              height: Get.height / 4, // Adjust height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13.0, color: Color(0xff666666)),
                ),
                SizedBox(height: Get.height / 50),
                ElevatedButton(
                  onPressed: onExploreMore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFB8C00), // Orange color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    "Explore More",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
