part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class LoadingCartEvent extends CartEvent {}

class AddingToCartEvent extends CartEvent {
  final Course course;
  AddingToCartEvent(this.course);
}

class RemovingFromCartEvent extends CartEvent {
  final Course course;
  RemovingFromCartEvent(this.course);
}
