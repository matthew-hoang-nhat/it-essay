// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:it_project/main.dart';
import 'package:it_project/src/local/dao/item_cart.dart';
import 'package:it_project/src/utils/app_shared.dart';

class FCartLocal {
  FCartLocal();
  final _appShared = getIt<AppShared>();
  set itemCarts(List<ItemCart> value) => _appShared.setItemCartsValue(value);
  List<ItemCart> get itemCarts {
    var items = _appShared.getItemCartsValue();
    if (items == null) {
      _appShared.setItemCartsValue([]);
      items = _appShared.getItemCartsValue()!;
    }
    return List<ItemCart>.from(items);
  }
}
