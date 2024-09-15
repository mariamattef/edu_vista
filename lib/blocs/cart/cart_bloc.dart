import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:edu_vista/models/course.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Course> itemscard = [];
  CartBloc() : super(CartInitial()) {
    on<LoadingCartEvent>(loadCartItemsFromSharedPreferences);
    on<AddingToCartEvent>(onAddItem);
    on<RemovingFromCartEvent>(onRemoveitem);
  }

  Future<void> saveCartItemsToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItems = jsonEncode(itemscard);
    prefs.setString('cartItems', cartItems);
  }

  Future<void> loadCartItemsFromSharedPreferences(
      LoadingCartEvent event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getString('cartItems');
    if (cartItemsJson != null) {
      final cartItems = List<Course>.from(
        jsonDecode(cartItemsJson).map((item) => Course.fromJson(item)),
      );
      itemscard = cartItems;
      emit(
        CartUpdatState(
          itemscard,
          calculateTotalPrice(),
        ),
      );
    }
  }

  FutureOr<void> onAddItem(
      AddingToCartEvent event, Emitter<CartState> emit) async {
    itemscard.add(event.course);
    saveCartItemsToSharedPreferences();
    emit(CartUpdatState(
      itemscard,
      calculateTotalPrice(),
    ));
  }

  FutureOr<void> onRemoveitem(
      RemovingFromCartEvent event, Emitter<CartState> emit) async {
    itemscard.remove(event.course);
    saveCartItemsToSharedPreferences();
    emit(
      CartUpdatState(
        itemscard,
        calculateTotalPrice(),
      ),
    );
  }

  double calculateTotalPrice() {
    return itemscard.fold(
      0,
      (total, course) => total + course.price!.toDouble(),
    );
  }
}
