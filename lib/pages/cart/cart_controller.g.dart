// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartTotalHash() => r'829bdb3981122191d9bd414319cdb77065d3b3f8';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalRef = AutoDisposeProviderRef<double>;
String _$shoppingCartHash() => r'c5bed982bc89c72006bb25a0880ef0f07b8cf5d2';

/// See also [ShoppingCart].
@ProviderFor(ShoppingCart)
final shoppingCartProvider =
    NotifierProvider<ShoppingCart, Set<Product>>.internal(
  ShoppingCart.new,
  name: r'shoppingCartProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$shoppingCartHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShoppingCart = Notifier<Set<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
