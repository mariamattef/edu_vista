import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edu_vista/models/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> saveCartItemsToFirebase() async {
    final cartItems = jsonEncode(itemscard);

    // save to firebase firestore carts collection with current user id
    FirebaseFirestore.instance
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'cartItems': cartItems});
  }

  Future<void> loadCartItemsFromSharedPreferences(LoadingCartEvent event, Emitter<CartState> emit) async {
    final cartItemsDoc =
        await FirebaseFirestore.instance.collection('carts').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final cartItemsJson = cartItemsDoc.data()?['cartItems'];
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

  FutureOr<void> onAddItem(AddingToCartEvent event, Emitter<CartState> emit) async {
    itemscard.add(event.course);
    saveCartItemsToFirebase();
    emit(CartUpdatState(
      itemscard,
      calculateTotalPrice(),
    ));
  }

  FutureOr<void> onRemoveitem(RemovingFromCartEvent event, Emitter<CartState> emit) async {
    itemscard.remove(event.course);
    saveCartItemsToFirebase();
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
