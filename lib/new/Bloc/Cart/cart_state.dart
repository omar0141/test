part of 'cart_bloc.dart';

abstract class CartState {
  List<ProductModel> cart;
  CartState({required this.cart});
}

class CartInitial extends CartState {
  CartInitial({required super.cart});
}

class CartLoading extends CartState {
  String id;
  CartLoading({required this.id, required super.cart});
}

class AddToCartState extends CartState {
  AddToCartState({required super.cart});
}

class GetLocalCartState extends CartState {
  GetLocalCartState({required super.cart});
}

class RemoveFromCartState extends CartState {
  RemoveFromCartState({required super.cart});
}