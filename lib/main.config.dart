// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'datasources/dofusdude/almanax_source.dart' as _i3;
import 'datasources/dofusdude/items_source.dart' as _i8;
import 'datasources/dofusdude/itemTypes/consumables_source.dart' as _i4;
import 'datasources/dofusdude/itemTypes/cosmetics_source.dart' as _i5;
import 'datasources/dofusdude/itemTypes/equipment_source.dart' as _i6;
import 'datasources/dofusdude/itemTypes/quest_items_source.dart' as _i9;
import 'datasources/dofusdude/itemTypes/resources_source.dart' as _i10;
import 'repositories/item_repository.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AlmanaxSource>(() => _i3.AlmanaxSource());
    gh.lazySingleton<_i4.ConsumablesSource>(() => _i4.ConsumablesSource());
    gh.lazySingleton<_i5.CosmeticsSource>(() => _i5.CosmeticsSource());
    gh.lazySingleton<_i6.EquipmentSource>(() => _i6.EquipmentSource());
    gh.lazySingleton<_i7.ItemRepository>(() => _i7.ItemRepository());
    gh.lazySingleton<_i8.ItemsSource>(() => _i8.ItemsSource());
    gh.lazySingleton<_i9.QuestItemsSource>(() => _i9.QuestItemsSource());
    gh.lazySingleton<_i10.ResourcesSource>(() => _i10.ResourcesSource());
    return this;
  }
}
