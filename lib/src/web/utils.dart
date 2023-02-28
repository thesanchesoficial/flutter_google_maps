// Copyright (c) 2020, the MarchDev Toolkit project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:ui' as ui show Color;

import 'package:flinq/flinq.dart';
import 'package:google_maps/google_maps.dart';
import 'package:google_directions_api/google_directions_api.dart'
    show GeoCoord, GeoCoordBounds;

extension WebLatLngExtensions on LatLng {
  GeoCoord toGeoCoord() => GeoCoord(lat.toDouble(), lng.toDouble());
}

extension WebGeoCoordExtensions on GeoCoord {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension WebGeoCoordBoundsExtensions on GeoCoordBounds {
  LatLngBounds toLatLngBounds() => LatLngBounds(
        southwest.toLatLng(),
        northeast.toLatLng(),
      );

  GeoCoord get center => GeoCoord(
        (northeast.latitude + southwest.latitude) / 2,
        (northeast.longitude + southwest.longitude) / 2,
      );
}

extension WebLatLngBoundsExtensions on LatLngBounds {
  GeoCoordBounds toGeoCoordBounds() => GeoCoordBounds(
        northeast: northEast.toGeoCoord(),
        southwest: southWest.toGeoCoord(),
      );
}

extension WebColorExtensions on ui.Color {
  String toHashString() =>
      '#${red.toRadixString(16)}${green.toRadixString(16)}${blue.toRadixString(16)}';
}

extension WebMapStyleExtension on String {
//   MapTypeStyleElementType _elementTypeFromString(String value) {
//     switch (value) {
//       case 'all':
//         return MapTypeStyleElementType.ALL;
//       case 'geometry':
//         return MapTypeStyleElementType.GEOMETRY;
//       case 'geometry.fill':
//         return MapTypeStyleElementType.GEOMETRY_FILL;
//       case 'geometry.stroke':
//         return MapTypeStyleElementType.GEOMETRY_STROKE;
//       case 'labels':
//         return MapTypeStyleElementType.LABELS;
//       case 'labels.icon':
//         return MapTypeStyleElementType.LABELS_ICON;
//       case 'labels.text':
//         return MapTypeStyleElementType.LABELS_TEXT;
//       case 'labels.text.fill':
//         return MapTypeStyleElementType.LABELS_TEXT_FILL;
//       case 'labels.text.stroke':
//         return MapTypeStyleElementType.LABELS_TEXT_STROKE;
//       default:
//         return MapTypeStyleElementType.ALL;
//     }
//   }

//   MapTypeStyleFeatureType _featureTypeFromString(String value) {
//     switch (value) {
//       case 'administrative':
//         return MapTypeStyleFeatureType.ADMINISTRATIVE;
//       case 'administrative.country':
//         return MapTypeStyleFeatureType.ADMINISTRATIVE_COUNTRY;
//       case 'administrative.land_parcel':
//         return MapTypeStyleFeatureType.ADMINISTRATIVE_LAND_PARCEL;
//       case 'administrative.locality':
//         return MapTypeStyleFeatureType.ADMINISTRATIVE_LOCALITY;
//       case 'administrative.neighborhood':
//         return MapTypeStyleFeatureType.ADMINISTRATIVE_NEIGHBORHOOD;
//       case 'administrative.province':
//         return MapTypeStyleFeatureType.ADMINISTRATIVE_PROVINCE;
//       case 'all':
//         return MapTypeStyleFeatureType.ALL;
//       case 'landscape':
//         return MapTypeStyleFeatureType.LANDSCAPE;
//       case 'landscape.man_made':
//         return MapTypeStyleFeatureType.LANDSCAPE_MAN_MADE;
//       case 'landscape.natural':
//         return MapTypeStyleFeatureType.LANDSCAPE_NATURAL;
//       case 'landscape.natural.landcover':
//         return MapTypeStyleFeatureType.LANDSCAPE_NATURAL_LANDCOVER;
//       case 'landscape.natural.terrain':
//         return MapTypeStyleFeatureType.LANDSCAPE_NATURAL_TERRAIN;
//       case 'poi':
//         return MapTypeStyleFeatureType.POI;
//       case 'poi.attraction':
//         return MapTypeStyleFeatureType.POI_ATTRACTION;
//       case 'poi.business':
//         return MapTypeStyleFeatureType.POI_BUSINESS;
//       case 'poi.government':
//         return MapTypeStyleFeatureType.POI_GOVERNMENT;
//       case 'poi.medical':
//         return MapTypeStyleFeatureType.POI_MEDICAL;
//       case 'poi.park':
//         return MapTypeStyleFeatureType.POI_PARK;
//       case 'poi.place_of_worship':
//         return MapTypeStyleFeatureType.POI_PLACE_OF_WORSHIP;
//       case 'poi.school':
//         return MapTypeStyleFeatureType.POI_SCHOOL;
//       case 'poi.sports_complex':
//         return MapTypeStyleFeatureType.POI_SPORTS_COMPLEX;
//       case 'road':
//         return MapTypeStyleFeatureType.ROAD;
//       case 'road.arterial':
//         return MapTypeStyleFeatureType.ROAD_ARTERIAL;
//       case 'road.highway':
//         return MapTypeStyleFeatureType.ROAD_HIGHWAY;
//       case 'road.highway.controlled_access':
//         return MapTypeStyleFeatureType.ROAD_HIGHWAY_CONTROLLED_ACCESS;
//       case 'road.local':
//         return MapTypeStyleFeatureType.ROAD_LOCAL;
//       case 'transit':
//         return MapTypeStyleFeatureType.TRANSIT;
//       case 'transit.line':
//         return MapTypeStyleFeatureType.TRANSIT_LINE;
//       case 'transit.station':
//         return MapTypeStyleFeatureType.TRANSIT_STATION;
//       case 'transit.station.airport':
//         return MapTypeStyleFeatureType.TRANSIT_STATION_AIRPORT;
//       case 'transit.station.bus':
//         return MapTypeStyleFeatureType.TRANSIT_STATION_BUS;
//       case 'transit.station.rail':
//         return MapTypeStyleFeatureType.TRANSIT_STATION_RAIL;
//       case 'water':
//         return MapTypeStyleFeatureType.WATER;

//       default:
//         return MapTypeStyleFeatureType.ALL;
//     }
//   }

  // MapTypeStyler _stylerFromMap(Map<String, dynamic> map) => MapTypeStyler()
  //   ..color = map['color']
  //   ..gamma = map['gamma']
  //   ..hue = map['hue']
  //   ..invertLightness = map['invertLightness']
  //   ..lightness = map['lightness']
  //   ..saturation = map['saturation']
  //   ..visibility = map['visibility']
  //   ..weight = map['weight'];

  List<MapTypeStyle> parseMapStyle() {
    final List map = json.decode(this);
    return map.mapList(
      (style) => MapTypeStyle()
        // ..elementType = _elementTypeFromString(style['elementType'])
        ..elementType = style['elementType']
        // ..featureType = _featureTypeFromString(style['featureType'])
        ..featureType = style['featureType']
        // ..stylers = (style['stylers'] as List).mapList(
        //   (styler) => _stylerFromMap(styler),
        // ),
    );
  }
}

enum MapTypeStyleElementType {
  ALL,
  GEOMETRY,
  GEOMETRY_FILL,
  GEOMETRY_STROKE,
  LABELS,
  LABELS_ICON,
  LABELS_TEXT,
  LABELS_TEXT_FILL,
  LABELS_TEXT_STROKE,
}

enum MapTypeStyleFeatureType {
  ADMINISTRATIVE,
  ADMINISTRATIVE_COUNTRY,
  ADMINISTRATIVE_LAND_PARCEL,
  ADMINISTRATIVE_LOCALITY,
  ADMINISTRATIVE_NEIGHBORHOOD,
  ADMINISTRATIVE_PROVINCE,
  ALL,
  LANDSCAPE,
  LANDSCAPE_MAN_MADE,
  LANDSCAPE_NATURAL,
  LANDSCAPE_NATURAL_LANDCOVER,
  LANDSCAPE_NATURAL_TERRAIN,
  POI,
  POI_ATTRACTION,
  POI_BUSINESS,
  POI_GOVERNMENT,
  POI_MEDICAL,
  POI_PARK,
  POI_PLACE_OF_WORSHIP,
  POI_SCHOOL,
  POI_SPORTS_COMPLEX,
  ROAD,
  ROAD_ARTERIAL,
  ROAD_HIGHWAY,
  ROAD_HIGHWAY_CONTROLLED_ACCESS,
  ROAD_LOCAL,
  TRANSIT,
  TRANSIT_LINE,
  TRANSIT_STATION,
  TRANSIT_STATION_AIRPORT,
  TRANSIT_STATION_BUS,
  TRANSIT_STATION_RAIL,
  WATER,
}