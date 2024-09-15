part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartUpdatState extends CartState {
  final List<Course> itemcart;
  final double totalPrice;

  CartUpdatState(this.itemcart, this.totalPrice);
}
