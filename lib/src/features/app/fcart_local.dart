// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/utils/app_shared.dart';

class FCartLocal {
  FCartLocal(this._box);
  final Box<dynamic> _box;
  late final _appShared = AppSharedCart(_box);
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
