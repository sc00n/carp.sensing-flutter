// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartphoneStudyProtocol _$SmartphoneStudyProtocolFromJson(
        Map<String, dynamic> json) =>
    SmartphoneStudyProtocol(
      ownerId: json['ownerId'] as String,
      name: json['name'] as String,
      protocolDescription: json['protocolDescription'] == null
          ? null
          : StudyDescription.fromJson(
              json['protocolDescription'] as Map<String, dynamic>),
      dataEndPoint: json['dataEndPoint'] == null
          ? null
          : DataEndPoint.fromJson(json['dataEndPoint'] as Map<String, dynamic>),
    )
      ..id = json['id'] as String
      ..createdOn = DateTime.parse(json['createdOn'] as String)
      ..version = json['version'] as int
      ..primaryDevices = (json['primaryDevices'] as List<dynamic>)
          .map((e) =>
              PrimaryDeviceConfiguration.fromJson(e as Map<String, dynamic>))
          .toSet()
      ..connectedDevices = (json['connectedDevices'] as List<dynamic>?)
          ?.map((e) => DeviceConfiguration.fromJson(e as Map<String, dynamic>))
          .toSet()
      ..connections = (json['connections'] as List<dynamic>?)
          ?.map((e) => DeviceConnection.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tasks = (json['tasks'] as List<dynamic>)
          .map((e) => TaskConfiguration.fromJson(e as Map<String, dynamic>))
          .toSet()
      ..triggers = (json['triggers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, TriggerConfiguration.fromJson(e as Map<String, dynamic>)),
      )
      ..taskControls = (json['taskControls'] as List<dynamic>)
          .map((e) => TaskControl.fromJson(e as Map<String, dynamic>))
          .toSet()
      ..participantRoles = (json['participantRoles'] as List<dynamic>?)
          ?.map((e) => ParticipantRole.fromJson(e as Map<String, dynamic>))
          .toSet()
      ..assignedDevices =
          (json['assignedDevices'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toSet()),
      )
      ..expectedParticipantData =
          (json['expectedParticipantData'] as List<dynamic>?)
              ?.map((e) =>
                  ExpectedParticipantData.fromJson(e as Map<String, dynamic>))
              .toSet()
      ..applicationData = json['applicationData'] as Map<String, dynamic>
      ..description = json['description'] as String;

Map<String, dynamic> _$SmartphoneStudyProtocolToJson(
    SmartphoneStudyProtocol instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'createdOn': instance.createdOn.toIso8601String(),
    'version': instance.version,
    'ownerId': instance.ownerId,
    'name': instance.name,
    'primaryDevices': instance.primaryDevices.toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('connectedDevices', instance.connectedDevices?.toList());
  writeNotNull('connections', instance.connections);
  val['tasks'] = instance.tasks.toList();
  val['triggers'] = instance.triggers;
  val['taskControls'] = instance.taskControls.toList();
  writeNotNull('participantRoles', instance.participantRoles?.toList());
  writeNotNull('assignedDevices',
      instance.assignedDevices?.map((k, e) => MapEntry(k, e.toList())));
  writeNotNull(
      'expectedParticipantData', instance.expectedParticipantData?.toList());
  val['applicationData'] = instance.applicationData;
  writeNotNull('protocolDescription', instance.protocolDescription);
  val['description'] = instance.description;
  writeNotNull('dataEndPoint', instance.dataEndPoint);
  return val;
}

SmartphoneApplicationData _$SmartphoneApplicationDataFromJson(
        Map<String, dynamic> json) =>
    SmartphoneApplicationData(
      protocolDescription: json['protocolDescription'] == null
          ? null
          : StudyDescription.fromJson(
              json['protocolDescription'] as Map<String, dynamic>),
      dataEndPoint: json['dataEndPoint'] == null
          ? null
          : DataEndPoint.fromJson(json['dataEndPoint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SmartphoneApplicationDataToJson(
    SmartphoneApplicationData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('protocolDescription', instance.protocolDescription);
  writeNotNull('dataEndPoint', instance.dataEndPoint);
  return val;
}

StudyDescription _$StudyDescriptionFromJson(Map<String, dynamic> json) =>
    StudyDescription(
      title: json['title'] as String,
      description: json['description'] as String,
      purpose: json['purpose'] as String,
      studyDescriptionUrl: json['studyDescriptionUrl'] as String?,
      privacyPolicyUrl: json['privacyPolicyUrl'] as String?,
      responsible: json['responsible'] == null
          ? null
          : StudyResponsible.fromJson(
              json['responsible'] as Map<String, dynamic>),
    )..$type = json['__type'] as String?;

Map<String, dynamic> _$StudyDescriptionToJson(StudyDescription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['title'] = instance.title;
  val['description'] = instance.description;
  val['purpose'] = instance.purpose;
  writeNotNull('studyDescriptionUrl', instance.studyDescriptionUrl);
  writeNotNull('privacyPolicyUrl', instance.privacyPolicyUrl);
  writeNotNull('responsible', instance.responsible);
  return val;
}

StudyResponsible _$StudyResponsibleFromJson(Map<String, dynamic> json) =>
    StudyResponsible(
      id: json['id'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
      email: json['email'] as String,
      affiliation: json['affiliation'] as String,
      address: json['address'] as String,
    )..$type = json['__type'] as String?;

Map<String, dynamic> _$StudyResponsibleToJson(StudyResponsible instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['id'] = instance.id;
  val['name'] = instance.name;
  val['title'] = instance.title;
  val['email'] = instance.email;
  val['address'] = instance.address;
  val['affiliation'] = instance.affiliation;
  return val;
}

FileDataEndPoint _$FileDataEndPointFromJson(Map<String, dynamic> json) =>
    FileDataEndPoint(
      type: json['type'] as String? ?? DataEndPointTypes.FILE,
      dataFormat: json['dataFormat'] as String? ?? NameSpace.CARP,
      bufferSize: json['bufferSize'] as int? ?? 500 * 1000,
      zip: json['zip'] as bool? ?? true,
      encrypt: json['encrypt'] as bool? ?? false,
      publicKey: json['publicKey'] as String?,
    )..$type = json['__type'] as String?;

Map<String, dynamic> _$FileDataEndPointToJson(FileDataEndPoint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['type'] = instance.type;
  val['dataFormat'] = instance.dataFormat;
  val['bufferSize'] = instance.bufferSize;
  val['zip'] = instance.zip;
  val['encrypt'] = instance.encrypt;
  writeNotNull('publicKey', instance.publicKey);
  return val;
}

SQLiteDataEndPoint _$SQLiteDataEndPointFromJson(Map<String, dynamic> json) =>
    SQLiteDataEndPoint(
      type: json['type'] as String? ?? DataEndPointTypes.SQLITE,
      dataFormat: json['dataFormat'] as String? ?? NameSpace.CARP,
    )..$type = json['__type'] as String?;

Map<String, dynamic> _$SQLiteDataEndPointToJson(SQLiteDataEndPoint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['type'] = instance.type;
  val['dataFormat'] = instance.dataFormat;
  return val;
}

PersistentSamplingConfiguration _$PersistentSamplingConfigurationFromJson(
        Map<String, dynamic> json) =>
    PersistentSamplingConfiguration()
      ..$type = json['__type'] as String?
      ..lastTime = json['lastTime'] == null
          ? null
          : DateTime.parse(json['lastTime'] as String);

Map<String, dynamic> _$PersistentSamplingConfigurationToJson(
    PersistentSamplingConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('lastTime', instance.lastTime?.toIso8601String());
  return val;
}

HistoricSamplingConfiguration _$HistoricSamplingConfigurationFromJson(
        Map<String, dynamic> json) =>
    HistoricSamplingConfiguration(
      past: json['past'] == null
          ? null
          : Duration(microseconds: json['past'] as int),
      future: json['future'] == null
          ? null
          : Duration(microseconds: json['future'] as int),
    )
      ..$type = json['__type'] as String?
      ..lastTime = json['lastTime'] == null
          ? null
          : DateTime.parse(json['lastTime'] as String);

Map<String, dynamic> _$HistoricSamplingConfigurationToJson(
    HistoricSamplingConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('lastTime', instance.lastTime?.toIso8601String());
  val['past'] = instance.past.inMicroseconds;
  val['future'] = instance.future.inMicroseconds;
  return val;
}

IntervalSamplingConfiguration _$IntervalSamplingConfigurationFromJson(
        Map<String, dynamic> json) =>
    IntervalSamplingConfiguration(
      interval: Duration(microseconds: json['interval'] as int),
    )
      ..$type = json['__type'] as String?
      ..lastTime = json['lastTime'] == null
          ? null
          : DateTime.parse(json['lastTime'] as String);

Map<String, dynamic> _$IntervalSamplingConfigurationToJson(
    IntervalSamplingConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('lastTime', instance.lastTime?.toIso8601String());
  val['interval'] = instance.interval.inMicroseconds;
  return val;
}

PeriodicSamplingConfiguration _$PeriodicSamplingConfigurationFromJson(
        Map<String, dynamic> json) =>
    PeriodicSamplingConfiguration(
      interval: Duration(microseconds: json['interval'] as int),
      duration: Duration(microseconds: json['duration'] as int),
    )
      ..$type = json['__type'] as String?
      ..lastTime = json['lastTime'] == null
          ? null
          : DateTime.parse(json['lastTime'] as String);

Map<String, dynamic> _$PeriodicSamplingConfigurationToJson(
    PeriodicSamplingConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('lastTime', instance.lastTime?.toIso8601String());
  val['interval'] = instance.interval.inMicroseconds;
  val['duration'] = instance.duration.inMicroseconds;
  return val;
}

OnlineService _$OnlineServiceFromJson(Map<String, dynamic> json) =>
    OnlineService(
      roleName: json['roleName'] as String,
      isOptional: json['isOptional'] as bool? ?? false,
      supportedDataTypes: (json['supportedDataTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )
      ..$type = json['__type'] as String?
      ..defaultSamplingConfiguration =
          (json['defaultSamplingConfiguration'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, SamplingConfiguration.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$OnlineServiceToJson(OnlineService instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['roleName'] = instance.roleName;
  writeNotNull('isOptional', instance.isOptional);
  writeNotNull('supportedDataTypes', instance.supportedDataTypes);
  writeNotNull(
      'defaultSamplingConfiguration', instance.defaultSamplingConfiguration);
  return val;
}

SmartphoneDeployment _$SmartphoneDeploymentFromJson(
        Map<String, dynamic> json) =>
    SmartphoneDeployment(
      studyDeploymentId: json['studyDeploymentId'] as String?,
      deviceConfiguration: PrimaryDeviceConfiguration.fromJson(
          json['deviceConfiguration'] as Map<String, dynamic>),
      registration: DeviceRegistration.fromJson(
          json['registration'] as Map<String, dynamic>),
      connectedDevices: (json['connectedDevices'] as List<dynamic>?)
              ?.map((e) =>
                  DeviceConfiguration.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      connectedDeviceRegistrations: (json['connectedDeviceRegistrations']
                  as Map<String, dynamic>?)
              ?.map(
            (k, e) => MapEntry(
                k,
                e == null
                    ? null
                    : DeviceRegistration.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map(
                  (e) => TaskConfiguration.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      triggers: (json['triggers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, TriggerConfiguration.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      taskControls: (json['taskControls'] as List<dynamic>?)
              ?.map((e) => TaskControl.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      expectedParticipantData: (json['expectedParticipantData']
                  as List<dynamic>?)
              ?.map((e) =>
                  ExpectedParticipantData.fromJson(e as Map<String, dynamic>))
              .toSet() ??
          const {},
      protocolDescription: json['protocolDescription'] == null
          ? null
          : StudyDescription.fromJson(
              json['protocolDescription'] as Map<String, dynamic>),
      dataEndPoint: json['dataEndPoint'] == null
          ? null
          : DataEndPoint.fromJson(json['dataEndPoint'] as Map<String, dynamic>),
    )
      ..lastUpdateDate = json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String)
      ..deployed = json['deployed'] == null
          ? null
          : DateTime.parse(json['deployed'] as String)
      ..userId = json['userId'] as String?
      ..applicationData = json['applicationData'] as Map<String, dynamic>;

Map<String, dynamic> _$SmartphoneDeploymentToJson(
    SmartphoneDeployment instance) {
  final val = <String, dynamic>{
    'deviceConfiguration': instance.deviceConfiguration,
    'registration': instance.registration,
    'connectedDevices': instance.connectedDevices.toList(),
    'connectedDeviceRegistrations': instance.connectedDeviceRegistrations,
    'tasks': instance.tasks.toList(),
    'triggers': instance.triggers,
    'taskControls': instance.taskControls.toList(),
    'expectedParticipantData': instance.expectedParticipantData.toList(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lastUpdateDate', instance.lastUpdateDate?.toIso8601String());
  val['studyDeploymentId'] = instance.studyDeploymentId;
  writeNotNull('deployed', instance.deployed?.toIso8601String());
  writeNotNull('userId', instance.userId);
  val['applicationData'] = instance.applicationData;
  writeNotNull('protocolDescription', instance.protocolDescription);
  writeNotNull('dataEndPoint', instance.dataEndPoint);
  return val;
}

AppTask _$AppTaskFromJson(Map<String, dynamic> json) => AppTask(
      name: json['name'] as String?,
      measures: (json['measures'] as List<dynamic>?)
          ?.map((e) => Measure.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      instructions: json['instructions'] as String? ?? '',
      minutesToComplete: json['minutes_to_complete'] as int?,
      expire: json['expire'] == null
          ? null
          : Duration(microseconds: json['expire'] as int),
      notification: json['notification'] as bool? ?? false,
    )..$type = json['__type'] as String?;

Map<String, dynamic> _$AppTaskToJson(AppTask instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['name'] = instance.name;
  writeNotNull('measures', instance.measures);
  val['type'] = instance.type;
  val['title'] = instance.title;
  val['description'] = instance.description;
  val['instructions'] = instance.instructions;
  writeNotNull('minutes_to_complete', instance.minutesToComplete);
  writeNotNull('expire', instance.expire?.inMicroseconds);
  val['notification'] = instance.notification;
  return val;
}

ImmediateTrigger _$ImmediateTriggerFromJson(Map<String, dynamic> json) =>
    ImmediateTrigger()
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$ImmediateTriggerToJson(ImmediateTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  return val;
}

OneTimeTrigger _$OneTimeTriggerFromJson(Map<String, dynamic> json) =>
    OneTimeTrigger()
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?
      ..triggerTimestamp = json['triggerTimestamp'] == null
          ? null
          : DateTime.parse(json['triggerTimestamp'] as String);

Map<String, dynamic> _$OneTimeTriggerToJson(OneTimeTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  writeNotNull(
      'triggerTimestamp', instance.triggerTimestamp?.toIso8601String());
  return val;
}

PassiveTrigger _$PassiveTriggerFromJson(Map<String, dynamic> json) =>
    PassiveTrigger()
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$PassiveTriggerToJson(PassiveTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  return val;
}

DelayedTrigger _$DelayedTriggerFromJson(Map<String, dynamic> json) =>
    DelayedTrigger(
      delay: Duration(microseconds: json['delay'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$DelayedTriggerToJson(DelayedTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['delay'] = instance.delay.inMicroseconds;
  return val;
}

IntervalTrigger _$IntervalTriggerFromJson(Map<String, dynamic> json) =>
    IntervalTrigger(
      period: Duration(microseconds: json['period'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$IntervalTriggerToJson(IntervalTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['period'] = instance.period.inMicroseconds;
  return val;
}

PeriodicTrigger _$PeriodicTriggerFromJson(Map<String, dynamic> json) =>
    PeriodicTrigger(
      period: Duration(microseconds: json['period'] as int),
      duration: Duration(microseconds: json['duration'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$PeriodicTriggerToJson(PeriodicTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['period'] = instance.period.inMicroseconds;
  val['duration'] = instance.duration.inMicroseconds;
  return val;
}

DateTimeTrigger _$DateTimeTriggerFromJson(Map<String, dynamic> json) =>
    DateTimeTrigger(
      schedule: DateTime.parse(json['schedule'] as String),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$DateTimeTriggerToJson(DateTimeTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['schedule'] = instance.schedule.toIso8601String();
  writeNotNull('duration', instance.duration?.inMicroseconds);
  return val;
}

RecurrentScheduledTrigger _$RecurrentScheduledTriggerFromJson(
        Map<String, dynamic> json) =>
    RecurrentScheduledTrigger(
      type: $enumDecode(_$RecurrentTypeEnumMap, json['type']),
      time: TimeOfDay.fromJson(json['time'] as Map<String, dynamic>),
      end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
      separationCount: json['separationCount'] as int? ?? 0,
      maxNumberOfSampling: json['maxNumberOfSampling'] as int?,
      dayOfWeek: json['dayOfWeek'] as int?,
      weekOfMonth: json['weekOfMonth'] as int?,
      dayOfMonth: json['dayOfMonth'] as int?,
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?
      ..period = Duration(microseconds: json['period'] as int);

Map<String, dynamic> _$RecurrentScheduledTriggerToJson(
    RecurrentScheduledTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['duration'] = instance.duration.inMicroseconds;
  val['type'] = _$RecurrentTypeEnumMap[instance.type]!;
  val['time'] = instance.time;
  writeNotNull('end', instance.end?.toIso8601String());
  val['separationCount'] = instance.separationCount;
  writeNotNull('maxNumberOfSampling', instance.maxNumberOfSampling);
  writeNotNull('dayOfWeek', instance.dayOfWeek);
  writeNotNull('weekOfMonth', instance.weekOfMonth);
  writeNotNull('dayOfMonth', instance.dayOfMonth);
  val['period'] = instance.period.inMicroseconds;
  return val;
}

const _$RecurrentTypeEnumMap = {
  RecurrentType.daily: 'daily',
  RecurrentType.weekly: 'weekly',
  RecurrentType.monthly: 'monthly',
};

CronScheduledTrigger _$CronScheduledTriggerFromJson(
        Map<String, dynamic> json) =>
    CronScheduledTrigger(
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?
      ..cronExpression = json['cronExpression'] as String;

Map<String, dynamic> _$CronScheduledTriggerToJson(
    CronScheduledTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['cronExpression'] = instance.cronExpression;
  val['duration'] = instance.duration.inMicroseconds;
  return val;
}

SamplingEventTrigger _$SamplingEventTriggerFromJson(
        Map<String, dynamic> json) =>
    SamplingEventTrigger(
      measureType: json['measureType'] as String,
      resumeCondition: json['resumeCondition'] == null
          ? null
          : ConditionalEvent.fromJson(
              json['resumeCondition'] as Map<String, dynamic>),
      pauseCondition: json['pauseCondition'] == null
          ? null
          : ConditionalEvent.fromJson(
              json['pauseCondition'] as Map<String, dynamic>),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$SamplingEventTriggerToJson(
    SamplingEventTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['measureType'] = instance.measureType;
  writeNotNull('resumeCondition', instance.resumeCondition);
  writeNotNull('pauseCondition', instance.pauseCondition);
  return val;
}

ConditionalEvent _$ConditionalEventFromJson(Map<String, dynamic> json) =>
    ConditionalEvent(
      json['condition'] as Map<String, dynamic>,
    )..$type = json['__type'] as String?;

Map<String, dynamic> _$ConditionalEventToJson(ConditionalEvent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['condition'] = instance.condition;
  return val;
}

ConditionalSamplingEventTrigger _$ConditionalSamplingEventTriggerFromJson(
        Map<String, dynamic> json) =>
    ConditionalSamplingEventTrigger(
      measureType: json['measureType'] as String,
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$ConditionalSamplingEventTriggerToJson(
    ConditionalSamplingEventTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['measureType'] = instance.measureType;
  return val;
}

ConditionalPeriodicTrigger _$ConditionalPeriodicTriggerFromJson(
        Map<String, dynamic> json) =>
    ConditionalPeriodicTrigger(
      period: Duration(microseconds: json['period'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$ConditionalPeriodicTriggerToJson(
    ConditionalPeriodicTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['period'] = instance.period.inMicroseconds;
  return val;
}

RandomRecurrentTrigger _$RandomRecurrentTriggerFromJson(
        Map<String, dynamic> json) =>
    RandomRecurrentTrigger(
      minNumberOfTriggers: json['minNumberOfTriggers'] as int? ?? 0,
      maxNumberOfTriggers: json['maxNumberOfTriggers'] as int? ?? 1,
      startTime: TimeOfDay.fromJson(json['startTime'] as Map<String, dynamic>),
      endTime: TimeOfDay.fromJson(json['endTime'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?
      ..lastTriggerTimestamp = json['lastTriggerTimestamp'] == null
          ? null
          : DateTime.parse(json['lastTriggerTimestamp'] as String);

Map<String, dynamic> _$RandomRecurrentTriggerToJson(
    RandomRecurrentTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['startTime'] = instance.startTime;
  val['endTime'] = instance.endTime;
  val['minNumberOfTriggers'] = instance.minNumberOfTriggers;
  val['maxNumberOfTriggers'] = instance.maxNumberOfTriggers;
  val['duration'] = instance.duration.inMicroseconds;
  writeNotNull(
      'lastTriggerTimestamp', instance.lastTriggerTimestamp?.toIso8601String());
  return val;
}

UserTaskTrigger _$UserTaskTriggerFromJson(Map<String, dynamic> json) =>
    UserTaskTrigger(
      taskName: json['taskName'] as String,
      resumeCondition:
          $enumDecode(_$UserTaskStateEnumMap, json['resumeCondition']),
      pauseCondition:
          $enumDecodeNullable(_$UserTaskStateEnumMap, json['pauseCondition']),
    )
      ..$type = json['__type'] as String?
      ..sourceDeviceRoleName = json['sourceDeviceRoleName'] as String?;

Map<String, dynamic> _$UserTaskTriggerToJson(UserTaskTrigger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  writeNotNull('sourceDeviceRoleName', instance.sourceDeviceRoleName);
  val['taskName'] = instance.taskName;
  val['resumeCondition'] = _$UserTaskStateEnumMap[instance.resumeCondition]!;
  writeNotNull(
      'pauseCondition', _$UserTaskStateEnumMap[instance.pauseCondition]);
  return val;
}

const _$UserTaskStateEnumMap = {
  UserTaskState.initialized: 'initialized',
  UserTaskState.enqueued: 'enqueued',
  UserTaskState.dequeued: 'dequeued',
  UserTaskState.started: 'started',
  UserTaskState.canceled: 'canceled',
  UserTaskState.done: 'done',
  UserTaskState.expired: 'expired',
  UserTaskState.undefined: 'undefined',
};

FileData _$FileDataFromJson(Map<String, dynamic> json) => FileData(
      filename: json['filename'] as String,
      upload: json['upload'] as bool? ?? true,
    )
      ..$type = json['__type'] as String?
      ..metadata = (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$FileDataToJson(FileData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('__type', instance.$type);
  val['filename'] = instance.filename;
  val['upload'] = instance.upload;
  writeNotNull('metadata', instance.metadata);
  return val;
}
