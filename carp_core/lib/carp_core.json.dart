part of carp_core;

bool _fromJsonFunctionsRegistered = false;

// Register all the fromJson functions for the domain classes.
void _registerFromJsonFunctions() {
  if (_fromJsonFunctionsRegistered) return;

  // DEPLOYMENT
  FromJsonFactory().registerAll([
    DefaultDeviceRegistration(),
    AltBeaconDeviceRegistration(),
    SmartphoneDeviceRegistration(),
  ]);

  // register all the different device deployment status types - see [DeviceDeploymentStatusTypes]
  final device = DefaultDeviceConfiguration(roleName: '');
  FromJsonFactory().register(DeviceDeploymentStatus(device: device));
  FromJsonFactory().register(DeviceDeploymentStatus(device: device),
      type:
          'dk.cachet.carp.deployments.application.DeviceDeploymentStatus.NotDeployed');
  FromJsonFactory().register(DeviceDeploymentStatus(device: device),
      type:
          'dk.cachet.carp.deployments.application.DeviceDeploymentStatus.Unregistered');
  FromJsonFactory().register(DeviceDeploymentStatus(device: device),
      type:
          'dk.cachet.carp.deployments.application.DeviceDeploymentStatus.Registered');
  FromJsonFactory().register(DeviceDeploymentStatus(device: device),
      type:
          'dk.cachet.carp.deployments.application.DeviceDeploymentStatus.Deployed');
  FromJsonFactory().register(DeviceDeploymentStatus(device: device),
      type:
          'dk.cachet.carp.deployments.application.DeviceDeploymentStatus.Running');
  FromJsonFactory().register(DeviceDeploymentStatus(device: device),
      type:
          'dk.cachet.carp.deployments.application.DeviceDeploymentStatus.NeedsRedeployment');

  // register all the different study deployment status types - see [StudyDeploymentStatus]
  FromJsonFactory().register(StudyDeploymentStatus(studyDeploymentId: ''));
  FromJsonFactory().register(StudyDeploymentStatus(studyDeploymentId: ''),
      type:
          'dk.cachet.carp.deployments.application.StudyDeploymentStatus.Invited');
  FromJsonFactory().register(StudyDeploymentStatus(studyDeploymentId: ''),
      type:
          'dk.cachet.carp.deployments.application.StudyDeploymentStatus.DeployingDevices');
  FromJsonFactory().register(StudyDeploymentStatus(studyDeploymentId: ''),
      type:
          'dk.cachet.carp.deployments.application.StudyDeploymentStatus.DeploymentReady');
  FromJsonFactory().register(StudyDeploymentStatus(studyDeploymentId: ''),
      type:
          'dk.cachet.carp.deployments.application.StudyDeploymentStatus.Running');
  FromJsonFactory().register(StudyDeploymentStatus(studyDeploymentId: ''),
      type:
          'dk.cachet.carp.deployments.application.StudyDeploymentStatus.Stopped');

  // PROTOCOL
  final config = SamplingConfiguration();

  FromJsonFactory().registerAll([
    TriggerConfiguration(),
    ElapsedTimeTrigger(elapsedTime: const IsoDuration()),
    ManualTrigger(),
    ScheduledTrigger(
        recurrenceRule: RecurrenceRule(Frequency.DAILY),
        time: const TimeOfDay()),
    TaskConfiguration(),
    BackgroundTask(),
    CustomProtocolTask(studyProtocol: ''),
    Measure(type: ''),
    SamplingConfiguration(),
    NoOptionsSamplingConfiguration(),
    BatteryAwareSamplingConfiguration(
        critical: config, low: config, normal: config),
    GranularitySamplingConfiguration(Granularity.Balanced),
    DefaultDeviceConfiguration(roleName: ''),
    PrimaryDeviceConfiguration(roleName: ''),
    CustomProtocolDevice(),
    Smartphone(),
    AltBeacon(),
    ParticipantAttribute(inputDataType: ''),
    AssignedTo()
  ]);

  // DeviceConfiguration with different sub-types
  FromJsonFactory().register(DeviceConfiguration(roleName: ''));
  FromJsonFactory().register(DeviceConfiguration(roleName: ''),
      type:
          'dk.cachet.carp.protocols.infrastructure.test.StubMasterDeviceConfiguration');
  FromJsonFactory().register(DeviceConfiguration(roleName: ''),
      type:
          'dk.cachet.carp.protocols.infrastructure.test.StubDeviceConfiguration');

  // REQUESTS
  FromJsonFactory().registerAll([
    GetActiveParticipationInvitations(''),
    GetParticipantData(''),
    GetParticipantDataList(['']),
    SetParticipantData(''),
    GetStudyDeploymentStatus(''),
    GetStudyDeploymentStatusList(['']),
    RegisterDevice('', '', DefaultDeviceRegistration()),
    UnregisterDevice('', ''),
    GetDeviceDeploymentFor('', ''),
    DeviceDeployed('', '', DateTime.now()),
    Stop(''),
    Add(StudyProtocol(ownerId: '', name: ''), ''),
    AddVersion(StudyProtocol(ownerId: '', name: ''), ''),
    UpdateParticipantDataConfiguration('', null, null),
    GetBy('', null),
    GetAllForOwner(''),
    GetVersionHistoryFor(''),
    CreateCustomProtocol('', '', '', ''),
    OpenDataStreams(DataStreamsConfiguration(
      studyDeploymentId: '',
      expectedDataStreams: {},
    )),
    AppendToDataStreams('', []),
    GetDataStream(
        DataStreamId(
          studyDeploymentId: '',
          deviceRoleName: '',
          dataType: '',
        ),
        0),
    CloseDataStreams([]),
    RemoveDataStreams([])
  ]);

  // DATA TYPES
  FromJsonFactory().registerAll([
    Data(),
    // SensorData(),
    Acceleration(),
    Rotation(),
    MagneticField(),
    Geolocation(),
    SignalStrength(),
    StepCount(),
    HeartRate(),
    ECG(),
    EDA(),
    CompletedTask(taskName: ''),
    TriggeredTask(
        triggerId: 0,
        taskName: '',
        destinationDeviceRoleName: '',
        control: Control.Start),
    Error(message: '')
  ]);

  // INPUT DATA TYPES
  FromJsonFactory().register(
    CustomInput(''),
    type: CustomInput.CUSTOM_INPUT_TYPE_NAME,
  );
  FromJsonFactory().register(
    SexCustomInput(Sex.Female),
    type: SexCustomInput.SEX_INPUT_TYPE_NAME,
  );

  _fromJsonFunctionsRegistered = true;
}
