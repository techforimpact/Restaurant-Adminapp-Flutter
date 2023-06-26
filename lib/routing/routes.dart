// ignore_for_file: constant_identifier_names

const RootRoute = "/";

const DashboardPageDisplayName = 'Dashboard';
const DashboardPageRoute = '/dashboard';

const OrdersPageDisplayName = 'Orders';
const OrdersPageRoute = '/order';

const OrdersDetailsPageDisplayName = 'Order Details';
const OrdersDetailsPageRoute = '/order details';

const CustomersPageDisplayName = 'Customers';
const CustomersPageRoute = '/customers';

const ProductPageDisplayName = 'Products';
const ProductPageRoute = '/products';

const BookingPageDisplayName = 'Bookings';
const BookingPageRoute = '/booking';

const RestaurentPageDisplayName = 'Restaurent';
const RestaurentPageRoute = '/Restaurent';

const CouponsPageDisplayName = 'Coupon';
const CouponsPageRoute = '/coupon';

const ReviewsPageDisplayName = 'Review';
const ReviewsPageRoute = '/review';

const AccountsPageDisplayName = 'My Account';
const AccountsPageRoute = '/account';

const NotificationsPageDisplayName = 'Push Notifications';
const NotificationsPageRoute = '/notification';

const PaymentsPageDisplayName = 'Payment';
const PaymentsPageRoute = '/payment';

const ReportsPageDisplayName = 'Report';
const ReportsPageRoute = '/report';

const AuthenticationDisplayName = 'Log Out';
const AuthenticationPageRoute = '/auth';



class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(DashboardPageDisplayName, DashboardPageRoute),
  MenuItem(OrdersPageDisplayName, OrdersPageRoute),
  MenuItem(CustomersPageDisplayName, CustomersPageRoute),
  MenuItem(ProductPageDisplayName, ProductPageRoute),
  MenuItem(BookingPageDisplayName, BookingPageRoute),
  MenuItem(RestaurentPageDisplayName, RestaurentPageRoute),
  MenuItem(CouponsPageDisplayName, CouponsPageRoute),
  MenuItem(ReviewsPageDisplayName, ReviewsPageRoute),
  MenuItem(AccountsPageDisplayName, AccountsPageRoute),
  MenuItem(ReportsPageDisplayName, ReportsPageRoute),
  MenuItem(AuthenticationDisplayName, AuthenticationPageRoute),


];
