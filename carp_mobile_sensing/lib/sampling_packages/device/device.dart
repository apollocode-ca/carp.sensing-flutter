/// A library containing a sampling package for collecting information from the device hardware:
///  - device info
///  - battery
///  - screen
///  - free memory
library device;

import 'dart:async';
import 'dart:io' show Platform;

import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';

import 'package:battery_plus/battery_plus.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_state/screen_state.dart';
import 'package:system_info2/system_info2.dart';

part 'device.g.dart';
part 'device_datum.dart';
part 'device_package.dart';
part 'device_probes.dart';
