/*
 * Copyright 2021 Copenhagen Center for Health Technology (CACHET) at the
 * Technical University of Denmark (DTU).
 * Use of this source code is governed by a MIT-style license that can be
 * found in the LICENSE file.
 */

library carp_backend;

import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:carp_serializable/carp_serializable.dart';
import 'package:carp_core/carp_core.dart';
import 'package:carp_mobile_sensing/carp_mobile_sensing.dart';
import 'package:carp_webservices/carp_services/carp_services.dart';
import 'package:carp_webservices/carp_auth/carp_auth.dart';
import 'package:research_package/model.dart';

part 'carp_data_manager.dart';
part 'carp_study_manager.dart';
part 'localization_manager.dart';
part 'informed_consent_manager.dart';
part 'carp_resource_manager.dart';
part 'carp_localization.dart';
part 'carp_backend.g.dart';
part 'carp_deployment_service.dart';
part 'message_manager.dart';

/// Specify a CARP Service endpoint for uploading data.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class CarpDataEndPoint extends FileDataEndPoint {
  /// The default collection name.
  static const String DEFAULT_COLLECTION = "carp_sensing";

  /// The method used to upload to CARP.
  /// See [CarpUploadMethod] for options.
  CarpUploadMethod uploadMethod;

  /// The name of the CARP endpoint. Can be anything, but its recommended
  /// to name it according to the CARP service name.
  String name;

  /// The URI of the CARP endpoint.
  String? uri;

  /// The CARP web service client ID
  String? clientId;

  /// The CARP web service client secret
  String? clientSecret;

  /// Email used as username in password authentication.
  String? email;

  /// Password used in password authentication.
  ///
  /// Note that the password is in **clear text** and should hence only be used
  /// if the study is created locally on the phone in Dart.
  ///
  /// If the study configuration is downloaded from CARP (e.g., via a
  /// [CarpStudyProtocolManager]), then the authentication used for downloading
  /// is used and the [email] and [password] may be `null`.
  String? password;

  /// When uploading to the CARP using the [CarpUploadMethod.DOCUMENT] method,
  /// [collection] hold the name of the collection to store json objects.
  late String collection;

  /// When uploading to CARP using file in the [CarpUploadMethod.BATCH_DATA_POINT]
  /// or [CarpUploadMethod.FILE] methods, specifies if the local file on the phone
  /// should be deleted once uploaded.
  bool deleteWhenUploaded = true;

  /// Creates a [CarpDataEndPoint].
  ///
  /// [uploadMethod] specified the upload method as enumerated in [CarpUploadMethod].
  CarpDataEndPoint({
    required this.uploadMethod,
    required this.name,
    this.uri,
    this.clientId,
    this.clientSecret,
    this.email,
    this.password,
    String? collection,
    this.deleteWhenUploaded = true,
    super.dataFormat,
    super.bufferSize,
    super.zip,
    super.encrypt,
    super.publicKey,
  }) : super(
          type: DataEndPointTypes.CARP,
        ) {
    this.collection = collection ?? DEFAULT_COLLECTION;
    // the CARP server cannot handle zipped or encrypted files (yet)
    if (this.uploadMethod == CarpUploadMethod.BATCH_DATA_POINT) {
      this.zip = false;
      this.encrypt = false;
    }
  }

  /// Creates a [CarpDataEndPoint] based on a [CarpApp] [app].
  CarpDataEndPoint.fromCarpApp({
    required CarpUploadMethod uploadMethod,
    required String name,
    String? collection,
    bool deleteWhenUploaded = true,
    String dataFormat = NameSpace.CARP,
    int bufferSize = 500 * 1000,
    bool zip = true,
    bool encrypt = false,
    String? publicKey,
    required CarpApp app,
  }) : this(
          uploadMethod: uploadMethod,
          name: app.name,
          uri: app.uri.toString(),
          clientId: app.oauth.clientID,
          clientSecret: app.oauth.clientSecret,
          dataFormat: dataFormat,
          bufferSize: bufferSize,
          zip: zip,
          deleteWhenUploaded: deleteWhenUploaded,
        );

  Function get fromJsonFunction => _$CarpDataEndPointFromJson;

  factory CarpDataEndPoint.fromJson(Map<String, dynamic> json) =>
      FromJsonFactory().fromJson(json) as CarpDataEndPoint;
  Map<String, dynamic> toJson() => _$CarpDataEndPointToJson(this);

  String toString() =>
      '$runtimeType [$name] - method: ${uploadMethod.toString().split('.').last}';
}

/// A enumeration of upload methods to CARP
enum CarpUploadMethod {
  /// Upload each data point separately
  DATA_POINT,

  /// Collect data points in a file locally and then upload as a batch
  BATCH_DATA_POINT,

  /// Collect data points in a file locally and upload it as a file
  FILE,

  /// Upload each data point as a json document in the [collection] folder
  DOCUMENT,
}

enum CarpBackendEvents {
  /// The CarpBackend is successfully initialized.
  Initialized,

  /// The status of the deployment has successfully been downloaded from the CARP server.
  DeploymentStatusRetrieved,

  /// The study protocol has successfully been downloaded from the CARP server.
  ProtocolRetrieved,

  /// The deployment has successfully been downloaded from the CARP server.
  DeploymentRetrieved,

  /// The deployment has been marked as successfully at the CARP server.
  DeploymentSuccessful,

  /// An error occured in the communication with the CARP server.
  Error,
}

/// Exception for CARP backend communication.
class CarpBackendException implements Exception {
  String? message;
  CarpBackendException([this.message]);
  String toString() => "$runtimeType - ${message ?? ""}";
}

String _encode(Object? object) =>
    const JsonEncoder.withIndent(' ').convert(object);
