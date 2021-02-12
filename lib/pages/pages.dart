import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../helpers/helpers.dart';
import '../models/models.dart';
import '../models/wishListArray.dart';
import '../models/searchArray.dart';
import '../models/FilterArray.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:async/async.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:localstorage/localstorage.dart';
import 'package:path/path.dart';
import 'package:AirEcom/ScopeManage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

part 'bottom_navigation_page.dart';
part 'forgotPassword/forgot_password_page.dart';
part 'home/home_page.dart';
part 'notification/activity_page.dart';
part 'notification/feed_page.dart';
part 'notification/notification_page.dart';
part 'notification/offer_page.dart';
part 'onBoarding/on_boarding_page.dart';
part 'order/add_address_page.dart';
part 'order/edit_address_page.dart';

part 'order/address_page.dart';
part 'order/cart_page.dart';
part 'order/order_detail_page.dart';
part 'order/order_detail_page2.dart';

part 'order/order_page.dart';
part 'order/payment_page.dart';
part 'order/success_page.dart';
part 'product/browse_category_page.dart';
part 'product/browse_product_page.dart';
part 'product/browse_category_page2.dart';

part 'product/favorite_page.dart';
part 'product/product_detail_page.dart';
part 'product/product_detail_page2.dart';

part 'product/reviews_page.dart';
part 'product/write_review_page.dart';
part 'profile/profile_page.dart';
part 'profile/profile_detail_page.dart';
part 'profile/profile_addaddress_page.dart';
part 'profile/profile_editaddress.dart';

part 'search/filter_page.dart';
part 'search/search.dart';
part 'search/search_category_page.dart';
part 'search/search_page.dart';
part 'search/sort_page.dart';
part 'signIn/sign_in_page.dart';
part 'signUp/sign_up_page.dart';
part 'splash/splash_page.dart';
part 'profile/profile_change_name_page.dart';
part 'profile/profile_change_gender_page.dart';
part 'profile/profile_change_email_page.dart';
part 'profile/profile_change_phone_page.dart';
part 'profile/profile_change_password_page.dart';
part 'profile/profile_address_page.dart';
part 'profile/profile_payment_page.dart';
