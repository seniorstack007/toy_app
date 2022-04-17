import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/widget/detailPage_test.dart';
import 'package:toy_app/model/cart_model.dart';
import 'package:toy_app/service/product_repo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  // provider setting
  AppState _appState;

  final ProductService _productService = ProductService();
  Future<List<CartModel>> cartItems;
  double _total_price = 0;
  String total_price = '0';
  String cart_count = '0';
  // List<bool> checkValue = [];
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _appState = Provider.of<AppState>(context, listen: false);

    cartItems = _productService.getCartItems(_appState.user['_id']);
    // for (int j = 0; j < 50; j++) {
    //   checkValue.add(false);
    // }
    cartItems.then((value) {
      print(value);
      for (int i = 0; i < value.length; i++) {
        _total_price += value[i].quantity.toDouble() * value[i].product.price;
        // checkValue.add(false);
      }
      setState(() {
        total_price = _total_price.toStringAsFixed(2);
        cart_count = value.length.toString();
      });
    }, onError: (e) {
      print(e);
    });
  }

  void deleteCartItem(String id) async {
    String response =
        await _productService.deleteCartItem(_appState.user['_id'], id);
    if (response == 'success') {
      Navigator.pushReplacementNamed(context, '/cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: Color(0xff283488),
      floatingActionButton: const LanguageTransitionWidget(),
      appBar: CustomAppBar(
        title: Image.asset(
          'assets/img/LoginRegistration/header.png',
          // height: height * 0.1,
          width: width * 0.5,
          fit: BoxFit.cover,
        ),
        leadingAction: () {
          Navigator.pushNamed(context, '/home');
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 30, left: width * 0.05, right: width * 0.05),
                  child: Text(
                    AppLocalizations.of(context).cartpage_scart,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      letterSpacing: 0.02,
                      fontFamily: "Avenir Next",
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: width * 0.05,
                  ),
                  child: Text(
                    AppLocalizations.of(context).searchpage_text1 +
                        cart_count +
                        AppLocalizations.of(context).searchpage_text2,
                    style: const TextStyle(
                      color: Color(0xff999999),
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Avenir Next",
                    ),
                  ),
                )
              ],
            ),
            FutureBuilder(
              future: cartItems,
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? Center(
                          child: SizedBox(
                            height: height * 0.5,
                            width: width * 0.9,
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, index) =>
                                  InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailPageTest.routeName,
                                    arguments: snapshot.data[index].product,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.zero,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 1),
                                        blurRadius: 5,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(32.0),
                                            bottomLeft: Radius.circular(32.0)),
                                        child: Image.network(
                                          "${_appState.endpoint}/products/image/${snapshot.data[index].product.image}",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.zero,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.zero,
                                              height: height * 0.2,
                                              width: width * 0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            height * 0.03,
                                                            width * 0.05,
                                                            0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          snapshot.data[index]
                                                              .product.name,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Avenir Next',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: SizedBox(
                                                            height: 30,
                                                            width: 30,
                                                            child:
                                                                RawMaterialButton(
                                                              onPressed: () => {
                                                                deleteCartItem(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .product
                                                                        .id)
                                                              },
                                                              elevation: 1.0,
                                                              fillColor:
                                                                  Colors.white,
                                                              child: const Icon(
                                                                Icons
                                                                    .close_rounded,
                                                                size: 16.0,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            width * 0.05,
                                                            8,
                                                            width * 0.05,
                                                            0),
                                                    child: Text(
                                                      '\$' +
                                                          snapshot.data[index]
                                                              .product.price
                                                              .toString() +
                                                          ' X ' +
                                                          snapshot.data[index]
                                                              .quantity
                                                              .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'Avenir Next',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text("No Cart Item."),
                        ),
            ),
            InkWell(
              onTap: () => {
                Navigator.pushNamed(context, '/wrap'),
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                child: Text(
                  AppLocalizations.of(context).searchpage_text3,
                  style: const TextStyle(
                    fontFamily: 'Avenir Next',
                    fontSize: 14,
                    color: Color(0xff283488),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => {},
              child: Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                child: Text(
                  AppLocalizations.of(context).searchpage_coupon,
                  style: const TextStyle(
                    fontFamily: 'Avenir Next',
                    fontSize: 14,
                    color: Color(0xff283488),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                  child: Text(
                    AppLocalizations.of(context).searchpage_Subtotal,
                    style: const TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 14,
                      color: Color(0xff999999),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 0),
                  child: Text(
                    '\$' + total_price,
                    style: const TextStyle(
                      fontFamily: 'Avenir Next',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1d1d1d),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
              child: SizedBox(
                height: height * 0.07,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    _appState.cartTotalPrice = total_price;
                    Navigator.pushNamed(context, '/delivery');
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff283488)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(83.0),
                        side: const BorderSide(color: Color(0xff283488)),
                      ),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context).searchpage_checkout,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
