/*
 * Copyright 2018-2020 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

part of context;

/// The precision of the Location. A lower precision will provide a greater battery life.
///
/// This is modelled following [LocationAccuracy](https://pub.dev/documentation/location_platform_interface/latest/location_platform_interface/LocationAccuracy.html)
/// in the location plugin. This is good comprimise between the iOS and Android models:
///
///  * iOS [CLLocationAccuracy](https://developer.apple.com/documentation/corelocation/cllocationaccuracy?language=objc)
///  * Android [LocationRequest](https://developers.google.com/android/reference/com/google/android/gms/location/LocationRequest)
enum GeolocationAccuracy {
  powerSave,
  low,
  balanced,
  high,
  navigation,
  reduced,
}

/// A mixin class for all [Measure] definition using location.
abstract class LocationConfiguration {
  /// Defines the desired accuracy that should be used to determine the location
  /// data. Default value is [GeolocationAccuracy.balanced].
  GeolocationAccuracy accuracy = GeolocationAccuracy.balanced;

  /// The minimum distance in meters a device must move horizontally
  /// before an update event is generated.
  /// Specify 0 when you want to be notified of all movements.
  double distance = 0;

  /// The interval between location updates.
  Duration interval = const Duration(minutes: 1);

  /// The title of the notification to be shown to the user when
  /// location tracking takes place in the background.
  /// Only used on Android.
  String? notificationTitle;

  /// The message in the notification to be shown to the user when
  /// location tracking takes place in the background.
  /// Only used on Android.
  String? notificationMessage;

  /// The longer description in the notification to be shown to the user when
  /// location tracking takes place in the background.
  /// Only used on Android.
  String? notificationDescription;

  String toString() => '$runtimeType - accuracy: $accuracy, '
      'distance: $distance, '
      'interval: $interval, '
      'notificationTitle: $notificationTitle, '
      'notificationMessage: $notificationMessage, '
      'notificationDescription: $notificationDescription';
}

/// A manger that knows how to configure and get location.
/// Provide access to location data while the app is in the background.
///
/// Use as a singleton:
///
///  `LocationManager()...`
///
/// Note that this [LocationManager] **does not** handle location permissions.
/// This should be handled and granted on an application level before using
/// probes that depend on location.
class LocationManager {
  final location.Location locationManager = location.Location();
  static final LocationManager _instance = LocationManager._();

  /// Get the singleton [LocationManager] instance
  factory LocationManager() => _instance;

  LocationManager._();

  bool _enabled = false, _configuring = false;

  /// Is the location service enabled, which entails that
  ///  * location service is enabled
  ///  * permissions granted
  ///  * configuration is done
  bool get enabled => _enabled;

  /// Is service enabled in background mode?
  Future<bool> isBackgroundModeEnabled() async =>
      await locationManager.isBackgroundModeEnabled();

  /// Has the app permission to access location?
  ///
  /// If the result is [PermissionStatus.deniedForever], no dialog will be
  /// shown on [requestPermission].
  Future<location.PermissionStatus> hasPermission() async =>
      await locationManager.hasPermission();

  /// Configures the [LocationManager], incl. sensing a notification to the
  /// Android notification system.
  ///
  /// Configuration is done based on the [LocationConfiguration]. If not provided,
  /// as set of default configurations are used.
  Future<void> configure([LocationConfiguration? configuration]) async {
    // fast out if already enabled or is in the process of configuring (this is a singleton class)
    if (enabled) return;
    if (_configuring) return;

    _configuring = true;
    info('Configuring $runtimeType - configuration: $configuration');

    _enabled = false;

    bool serviceEnabled = await locationManager.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationManager.requestService();
      if (!serviceEnabled) {
        warning('$runtimeType - Location service could not be enabled.');
        return;
      }
    }

    if (await locationManager.hasPermission() !=
        location.PermissionStatus.granted) {
      warning(
          "$runtimeType - Permission to collect location data 'Always' in the background has not been granted. "
          "Make sure to grant this BEFORE sensing is resumed. "
          "The context sampling package does not handle permissions. This should be handled on the application level.");
      return;
    }

    try {
      await locationManager.changeSettings(
        accuracy: location.LocationAccuracy.values[
            configuration?.accuracy.index ??
                GeolocationAccuracy.balanced.index],
        distanceFilter: configuration?.distance,
        interval: configuration?.interval.inMilliseconds,
      );

      await locationManager.changeNotificationOptions(
        title: configuration?.notificationTitle ?? 'CARP Location Service',
        subtitle: configuration?.notificationMessage ??
            'The location service is running in the background',
        description: configuration?.notificationDescription ??
            'Background location is on to keep the app up-to-date with your location. '
                'This is required for main features to work properly when the app is not running.',
        onTapBringToFront: false,
      );
    } catch (error) {
      warning('$runtimeType - Configuration failed - $error');
      return;
    }

    _enabled = true;

    bool _backgroundMode = false;
    try {
      _backgroundMode = await locationManager.enableBackgroundMode();
    } catch (error) {
      warning('$runtimeType - Could not enable background mode - $error');
    }
    info(
        '$runtimeType - configured, background mode enabled: $_backgroundMode');
  }

  /// Gets the current location of the phone.
  /// Throws an error if the app has no permission to access location.
  Future<location.LocationData> getLocation() async =>
      await locationManager.getLocation();

  /// Get the last known location.
  Future<location.LocationData> getLastKnownLocation() async =>
      await locationManager.getLocation();

  /// Returns a stream of [LocationData] objects.
  /// Throws an error if the app has no permission to access location.
  Stream<location.LocationData> get onLocationChanged =>
      locationManager.onLocationChanged;
}