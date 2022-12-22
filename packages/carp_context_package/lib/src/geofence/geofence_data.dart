/*
 * Copyright 2019 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of carp_context_package;

/// Holds information about a geofence event of entering, exiting, or dwelling.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class Geofence extends Data {
  static const dataType = ContextSamplingPackage.GEOFENCE;

  Geofence({required this.type, required this.name}) : super();

  factory Geofence.fromJson(Map<String, dynamic> json) =>
      _$GeofenceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GeofenceToJson(this);

  /// The name of this geofence.
  String name;

  /// Type of geofence event:
  ///  - ENTER
  ///  - EXIT
  ///  - DWELL
  GeofenceType type;

  @override
  String toString() => '${super.toString()}, name: $name, type: $type';
}

enum GeofenceType { ENTER, EXIT, DWELL }