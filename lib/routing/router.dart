

import 'package:flutter/material.dart';

import '../pages/Coupons/coupons.dart';
import '../pages/bookings/booking_page.dart';
import '../pages/customers/customers.dart';

import '../pages/myAccount/myAccount.dart';
import '../pages/orders/orderDetails.dart';
import '../pages/orders/orders.dart';
import '../pages/overview/overview.dart';
import '../pages/products/product_page.dart';
import '../pages/pushNotifications/notifications.dart';
import '../pages/reports/reports.dart';
import '../pages/restaurent/restaurentpage.dart';
import '../pages/reviews/reviews.dart';

import 'routes.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case DashboardPageRoute:
      return _getPageRoute(const OverviewPage());
    case OrdersPageRoute:
      return _getPageRoute(const OrderPage());
    case OrdersDetailsPageRoute:
      return _getPageRoute(const OrderDetailsPage());
    case CustomersPageRoute:
      return _getPageRoute(const CustomersPage());
    case ProductPageRoute:
      return _getPageRoute(const ProductPage());

    case BookingPageRoute:
      return _getPageRoute(const BookingPage());
      
    case RestaurentPageRoute:
      return _getPageRoute(const RestaurentPage());

    case CouponsPageRoute:
      return _getPageRoute(CouponsPage());
    case ReviewsPageRoute:
      return _getPageRoute(const ReviewsPage());
    case AccountsPageRoute:
      return _getPageRoute(AccountsPage());

    case NotificationsPageRoute:
      return _getPageRoute(NotificationsPage());

    case ReportsPageRoute:
      return _getPageRoute(ReportsPage());



    default:
      return _getPageRoute(const OverviewPage());
  }
}

Route<dynamic>? _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
