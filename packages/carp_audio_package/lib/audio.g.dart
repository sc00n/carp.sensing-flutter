// GENERATED CODE - DO NOT MODIFY BY HAND

part of audio;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioDatum _$AudioDatumFromJson(Map<String, dynamic> json) {
  return AudioDatum(
    filename: json['filename'] as String,
    startRecordingTime: json['start_recording_time'] == null
        ? null
        : DateTime.parse(json['start_recording_time'] as String),
    endRecordingTime: json['end_recording_time'] == null
        ? null
        : DateTime.parse(json['end_recording_time'] as String),
  )
    ..id = json['id'] as String?
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String)
    ..upload = json['upload'] as bool
    ..metadata = (json['metadata'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    );
}

Map<String, dynamic> _$AudioDatumToJson(AudioDatum instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  val['filename'] = instance.filename;
  val['upload'] = instance.upload;
  writeNotNull('metadata', instance.metadata);
  writeNotNull(
      'start_recording_time', instance.startRecordingTime?.toIso8601String());
  writeNotNull(
      'end_recording_time', instance.endRecordingTime?.toIso8601String());
  return val;
}

NoiseDatum _$NoiseDatumFromJson(Map<String, dynamic> json) {
  return NoiseDatum(
    meanDecibel: (json['mean_decibel'] as num).toDouble(),
    stdDecibel: (json['std_decibel'] as num).toDouble(),
    minDecibel: (json['min_decibel'] as num).toDouble(),
    maxDecibel: (json['max_decibel'] as num).toDouble(),
  )
    ..id = json['id'] as String?
    ..timestamp = json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String);
}

Map<String, dynamic> _$NoiseDatumToJson(NoiseDatum instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  val['mean_decibel'] = instance.meanDecibel;
  val['std_decibel'] = instance.stdDecibel;
  val['min_decibel'] = instance.minDecibel;
  val['max_decibel'] = instance.maxDecibel;
  return val;
}

NoiseMeasure _$NoiseMeasureFromJson(Map<String, dynamic> json) {
  return NoiseMeasure(
    type: json['type'] as String,
    name: json['name'] as String?,
    description: json['description'] as String?,
    enabled: json['enabled'] as bool,
    frequency: Duration(microseconds: json['frequency'] as int),
    duration: Duration(microseconds: json['duration'] as int),
    samplingRate: json['samplingRate'] as int,
  )
    ..$type = json[r'$type'] as String?
    ..configuration = Map<String, String>.from(json['configuration'] as Map);
}

Map<String, dynamic> _$NoiseMeasureToJson(NoiseMeasure instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(r'$type', instance.$type);
  val['type'] = instance.type;
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  val['enabled'] = instance.enabled;
  val['configuration'] = instance.configuration;
  val['frequency'] = instance.frequency.inMicroseconds;
  val['duration'] = instance.duration.inMicroseconds;
  val['samplingRate'] = instance.samplingRate;
  return val;
}
