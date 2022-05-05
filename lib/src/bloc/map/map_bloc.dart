import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vietnam_covid19/src/bloc/map/map_event.dart';
import 'package:flutter_vietnam_covid19/src/bloc/map/map_state.dart';
import 'package:flutter_vietnam_covid19/src/data/model/map_model.dart';
import 'package:flutter_vietnam_covid19/src/data/model/province_map_model.dart';
import 'package:flutter_vietnam_covid19/src/data/model/province_model.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../constant/theme.dart';
import '../../data/remote/api.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  // MapBloc(MapState initialState) : super(initialState);

  // MapBloc(): super MapState(){
  //
  // }
  late MapShapeSource mapSource;
  List<Province> lstProvince = [];
  List<Province> lstSearchProvince = [];
  List<MapModelView> listMapModel = [];

  MapBloc() : super(const MapState()) {
    on<LoadEvent>(_onLoadData);
    on<RefreshEvent>(_onRefresh);
    on<WarningMapEvent>(_onWarning);
  }

  Map<String, Color> mapColorByCount = {
    "1-100": ThemePrimary.primaryColor.withOpacity(0.1),
    "101 - 500": ThemePrimary.primaryColor.withOpacity(0.2),
    "501 - 1000": ThemePrimary.primaryColor.withOpacity(0.4),
    "1001 - 10000": ThemePrimary.primaryColor.withOpacity(0.6),
    "10001+": ThemePrimary.primaryColor
  };

  late final List<MapColorMapper> _shapeColorMappers = <MapColorMapper>[
    MapColorMapper(
        from: 1,
        to: 100,
        color: ThemePrimary.primaryColor.withOpacity(0.2),
        text: '1 - 100'),
    MapColorMapper(
        from: 101,
        to: 500,
        color: ThemePrimary.primaryColor.withOpacity(0.4),
        text: '101 - 500'),
    MapColorMapper(
        from: 501,
        to: 1000,
        color: ThemePrimary.primaryColor.withOpacity(0.6),
        text: '501 - 1000'),
    MapColorMapper(
        from: 1001,
        to: 10000,
        color: ThemePrimary.primaryColor,
        text: '1001 - 10000'),
    MapColorMapper(
        from: 10001, to: 99999999999, color: Colors.red[300]!, text: '10001+'),
  ];

  void _onLoadData(LoadEvent event, Emitter<MapState> emit) async {
    emit(const LoadingState());

    print("loadString");

    try {
      String data = await rootBundle.loadString('assets/maps/vietnam.json') as String;

      var jsonResult = json.decode(data);

      // Map Obj load from Map Asset
      MapModelAsset _mapModel = MapModelAsset.fromJson(jsonResult);

      print("OnLoadData");

      List<ProvinceMap> lstProvinceMap = await Api.getProvincesMap();

      print("lstProvinceMap " + lstProvinceMap.length.toString());

      await Future.forEach(lstProvinceMap, (ProvinceMap element) {
        if (element.data == null || element.data!.isEmpty) return;
        Color? _color = mapColorByCount[element.name];
        List<String> _titleSet =
            element.data!.map((e) => e.title.toString()).toList();

        for (var e in _mapModel.features) {
          if (_titleSet.contains(e.properties.name1)) {
            listMapModel.add(MapModelView(
                color: _color ?? ThemePrimary.primaryColor,
                title: e.properties.name1,
                total: element.data!
                        .firstWhere(
                            (element) => element.title == e.properties.name1)
                        .confirmed ??
                    0));
          }

          if (_titleSet.contains("")) {
            listMapModel.add(MapModelView(
                title: "Hồ Chí Minh",
                color: _color ?? ThemePrimary.primaryColor,
                total: element.data!
                    .firstWhere((element) => element.title == "")
                    .confirmed!));
          }
        }
      });

      print("MapShapeSource");

      mapSource = MapShapeSource.asset('assets/maps/vietnam.json',
        shapeDataField: "NAME_1",
        dataCount: listMapModel.length,
        primaryValueMapper: (index) => listMapModel[index].title,
        // Attach color with total value
        shapeColorValueMapper: (index) =>
            listMapModel[index].total.toDouble(),
        // Setting List Color
        shapeColorMappers: _shapeColorMappers
      );

    } catch (e) {
      mapSource = const MapShapeSource.asset('assets/maps/vietnam.json',
          shapeDataField: "NAME_1");

      print("Catch Exception " + e.toString());
    }

    emit(LoadingSuccess());
  }

  void _onRefresh(RefreshEvent event, Emitter<MapState> state) async {}

  void _onWarning(WarningMapEvent event, Emitter<MapState> state) async {}
}
