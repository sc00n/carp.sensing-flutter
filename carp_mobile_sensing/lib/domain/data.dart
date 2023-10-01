/*
 * Copyright 2018-2022 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */
part of domain;

/// A [Data] object holding a link to a file.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class FileData extends Data {
  static const dataType = CAMSDataType.FILE_TYPE_NAME;

  /// The local path to the attached file on the phone where it is sampled.
  /// This is used by e.g. a data manager to get and manage the file on
  /// the phone.
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? path;

  /// The name to the attached file.
  String filename;

  /// Should the file also be uploaded, or only this meta data?
  /// Default is true.
  bool upload = true;

  /// Metadata for this file as a map of string key-value pairs.
  Map<String, String>? metadata = <String, String>{};

  /// Create a new [FileData] based the file path and whether it is
  /// to be uploaded or not.
  FileData({required this.filename, this.upload = true}) : super();

  @override
  Function get fromJsonFunction => _$FileDataFromJson;
  factory FileData.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as FileData;
  @override
  Map<String, dynamic> toJson() => _$FileDataToJson(this);

  @override
  String toString() =>
      '${super.toString()}, filename: $filename, upload: $upload';
}

/// A buffer of [Data] objects.
///
/// This type of data is typically collected by the buffering probes, like
/// [BufferingPeriodicProbe] or [BufferingPeriodicStreamProbe].
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class DataBuffer extends Data {
  static const dataType = '${CarpDataTypes.CARP_NAMESPACE}.databuffer';

  /// The buffer of data. May be empty.
  List<Data> buffer = [];

  /// The data type of the data in this buffer. Returns null if the [buffer] is
  /// empty.
  String? bufferDataType;
  //  =>
  //     buffer.isNotEmpty ? buffer[0].format.toString() : null;

  @JsonKey(includeFromJson: false, includeToJson: false)
  late DateTime startTime;

  @JsonKey(includeFromJson: false, includeToJson: false)
  DateTime? endTime;

  DataBuffer() {
    startTime = DateTime.now();
  }

  void add(Data value) => buffer.add(value);

  void close() {
    endTime = DateTime.now();
    bufferDataType = buffer[0].format.toString();
  }

  @override
  Function get fromJsonFunction => _$DataBufferFromJson;
  factory DataBuffer.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as DataBuffer;
  @override
  Map<String, dynamic> toJson() => _$DataBufferToJson(this);
}

/// Reflects a heart beat data send every [period] minute.
/// Useful for calculating sampling coverage over time.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class Heartbeat extends Data {
  static const dataType = '${CarpDataTypes.CARP_NAMESPACE}.heartbeat';

  /// The period of heartbeats per minute.
  int period;

  /// The type of device.
  String deviceType;

  /// The role name of the device in the protocol.
  String deviceRoleName;

  Heartbeat({
    required this.period,
    required this.deviceType,
    required this.deviceRoleName,
  }) : super();

  @override
  Function get fromJsonFunction => _$HeartbeatFromJson;
  factory Heartbeat.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as Heartbeat;
  @override
  Map<String, dynamic> toJson() => _$HeartbeatToJson(this);
}
