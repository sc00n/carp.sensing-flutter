/*
 * Copyright 2018-2022 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */
part of domain;

/// A [Data] object holding a link to a file.
@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class FileData extends Data {
  static const dataType = CAMSDataType.FILE_TYPE_NAME;

  /// The local path to the attached file on the phone where it is sampled.
  /// This is used by e.g. a data manager to get and manage the file on
  /// the phone.
  @JsonKey(ignore: true)
  String? path;

  /// The name to the attached file.
  String filename;

  /// Should this file be uploaded together with the [Datum] description.
  /// Default is [true].
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
