// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:amazon/constant/common_function.dart';
import 'package:amazon/constant/constants.dart';
import 'package:amazon/controller/provider/deal_of_the_provider.dart';
import 'package:amazon/controller/services/product_services.dart';
import 'package:amazon/model/ProductModel.dart';
import 'package:amazon/utils/colors.dart';
import 'package:amazon/view/User/Product_Screen/Product_Screen.dart';
import 'package:amazon/view/User/product_category_screen/product_category_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController todaysDealsCarouselController = CarouselController();

  headphoneDeals(int index) {
    switch (index) {
      case 0:
        return 'Bose';
      case 1:
        return 'boAt';
      case 2:
        return 'Sony';
      case 3:
        return 'OnePlus';
    }
  }

  clothingDeals(int index) {
    switch (index) {
      case 0:
        return 'Kurtas, sarees & more';
      case 1:
        return 'Tops, dresses & more';
      case 2:
        return 'T-Shirt, jeans & more';
      case 3:
        return 'View all';
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     checkUserAddress();
  //     context.read<AddressProvider>().getCurrentSelectedAddress();
  //     context.read<DealOfTheDayProvider>().fetchTodaysDeal();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: Size(width * 1, height * 0.1),
          child: HomePageAppBar(width: width, height: height)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HomeScreenUserAddressBar(height: height, width: width),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            const HomeScreenCategoriesList(),
            SizedBox(
              height: height * 0.01,
              width: 0,
            ),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            HomeScreenBanner(height: height),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            TodaysDealHomeScreenWidget(
                todaysDealsCarouselController: todaysDealsCarouselController),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            // otherOfferGridWidget(
            //       title: 'Latest Launces in Headphones',
            //       textBtnName: 'Explore More',
            //       productPicNamesList: headphonesDeals,
            //       offerFor: 'headphones'),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            SizedBox(
              height: height * 0.35,
              width: width,
              child: const Image(
                image: AssetImage(
                  'assets/images/offersNsponcered/insurance.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            // otherOfferGridWidget(
            //       title: 'Minimum 70% Off | Top Offers on Clothing',
            //       textBtnName: 'See all deals',
            //       productPicNamesList: clothingDealsList,
            //       offerFor: 'clothing'),
            Divider(
              color: greyShade3,
              height: 0,
              thickness: 3,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                  width: 0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Text(
                    'Watch Sixer only on miniTV',
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  // height: height * 0.4,
                  width: width,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.01,
                  ),
                  child: const Image(
                    image: AssetImage(
                      'assets/images/offersNsponcered/sixer.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container otherOfferGridWidget(
      {required String title,
      required String textBtnName,
      required List<String> productPicNamesList,
      required String offerFor}) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.01,
        ),
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: height ?? 0,
              width: width ?? 0,
            ),
            GridView.builder(
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/offersNsponcered/${productPicNamesList[index]}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          offerFor == 'headphones'
                              ? headphoneDeals(index)
                              : clothingDeals(index),
                          style: textTheme.bodyMedium,
                        )
                      ],
                    ),
                  );
                }),
            TextButton(
              onPressed: () {},
              child: Text(
                textBtnName,
                style: textTheme.bodySmall!.copyWith(
                  color: blue,
                ),
              ),
            ),
          ],
        ));
  }
}

class TodaysDealHomeScreenWidget extends StatelessWidget {
  const TodaysDealHomeScreenWidget({
    super.key,
    required this.todaysDealsCarouselController,
  });

  final CarouselController todaysDealsCarouselController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.03, vertical: height * 0.01),
        child: Consumer<DealOfTheDayProvider>(
            builder: (context, dealOfTheDayProvider, child) {
          if (dealOfTheDayProvider.dealsFetched == false) {
            return Container(
              height: height * 0.2,
              width: width,
              alignment: Alignment.center,
              child: Text(
                'Loading Latest Deals',
                style: textTheme.bodyMedium,
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${dealOfTheDayProvider.deals[3].discountPercentage}%-${dealOfTheDayProvider.deals[0].discountPercentage}% off | Latest deals.',
                  style: textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                  width: 0,
                ),
                CarouselSlider(
                  carouselController: todaysDealsCarouselController,
                  options: CarouselOptions(
                    height: height * 0.2,
                    autoPlay: true,
                    viewportFraction: 1,
                  ),
                  items: dealOfTheDayProvider.deals.map((i) {
                    ProductModel currentProduct = i;
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child:
                                    ProductScreen(productModel: currentProduct),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: white,
                              image: DecorationImage(
                                image:
                                    NetworkImage(currentProduct.imagesURL![0]),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                CommonFunctions.blankSpace(
                  height * 0.01,
                  0,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          color: red),
                      child: Text(
                        'Upto 62% Off',
                        style: textTheme.labelMedium!.copyWith(color: white),
                      ),
                    ),
                    CommonFunctions.blankSpace(0, width * 0.03),
                    Text(
                      'Deal of the Day',
                      style: textTheme.labelMedium!.copyWith(
                        color: red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CommonFunctions.blankSpace(height * 0.01, 0),
                GridView.builder(
                    itemCount: dealOfTheDayProvider.deals.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ProductModel currentModel =
                          dealOfTheDayProvider.deals[index];
                      return InkWell(
                        onTap: () {
                          log(index.toString());
                          todaysDealsCarouselController.animateToPage(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: greyShade3,
                            ),
                            image: DecorationImage(
                              image: NetworkImage(currentModel.imagesURL![0]),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    }),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See all Deals',
                    style: textTheme.bodySmall!.copyWith(
                      color: blue,
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class HomeScreenBanner extends StatelessWidget {
  const HomeScreenBanner({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: CarouselController(),
      options: CarouselOptions(
        height: height * 0.23,
        autoPlay: true,
        viewportFraction: 1,
      ),
      items: carouselPictures.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.symmetric(horizontal: 5.0),

              decoration: BoxDecoration(
                color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage('assets/images/carousel_slideshow/$i'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class HomeScreenCategoriesList extends StatelessWidget {
  const HomeScreenCategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: height * 0.09,
      width: width,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            /// ************* ABO ALI bymasii
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child:
                      ProductCategoryScreen(productCategory: categories[index]),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage(
                      'assets/images/categories/${categories[index]}.png',
                    ),
                    height: height * 0.07,
                  ),
                  Text(
                    categories[index],
                    style: textTheme.labelMedium,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(),

      padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          bottom: height * 0.012,
          top: height * 0.045),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: appBarGradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            ///************* */ ABO ALI bymasii
            onTap: () {
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     child: const SearchedProductScreen(),
              //     type: PageTransitionType.rightToLeft,
              //   ),
              // );
            },
            child: Container(
              width: width * 0.81,
              height: height * 0.06,
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  5,
                ),
                border: Border.all(
                  color: grey,
                ),
                color: white,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                    ),
                    child: Text(
                      'Search Amazon.in',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: grey),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.camera_alt_sharp,
                    color: grey,
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                ProductServices.getImages(context: context);
              },
              icon: Icon(
                Icons.mic,
                color: black,
              ))
        ],
      ),
    );
  }
}
