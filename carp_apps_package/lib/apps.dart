/// A library for collecting data from apps on the phone.
library carp_apps_package;

import 'package:json_annotation/json_annotation.dart';
import 'package:device_apps/device_apps.dart';
import 'dart:async';
import 'package:app_usage/app_usage.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

part 'apps_datum.dart';
part 'app_probes.dart';
part 'apps_package.dart';
part 'apps.g.dart';