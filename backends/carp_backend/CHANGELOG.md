## 0.40.1

* Upgrade to `research_package: ^1.2.0`

## 0.40.0

* update to `carp_mobile_sensing` v. 0.40.0
* deployment are no longer caches locally in the `CustomProtocolDeploymentService`. This is now handled directly by CAMS v. 0.40.0

## 0.33.0

* upgrade to `carp_mobile_sensing` v. 0.33.0

## 0.32.3

* upgrade to `research_package: ^0.7.0`

## 0.32.2

* support for messages in CARP

## 0.32.0+1

* update to `carp_mobile_sensing` v. 0.32.0
* update to README file

## 0.31.2

* support for stopping (permanently) a study deployment.

## 0.31.1+1

* bug fix of [#221](https://github.com/cph-cachet/carp.sensing-flutter/issues/221).

## 0.31.0

* upgrade to `carp_mobile_sensing` v. 0.31.0
* remove support for handling study description in `ResourceManager` since this is now part of a `SmartphoneStudyProtocol` and handled there.

## 0.30.5

* upgrade to `carp_mobile_sensing` v. 0.30.5
* upgrade to `carp_webservices` v. 0.30.1

## 0.30.3

* upgrade to `carp_mobile_sensing` v. 0.30.3
* support for set/get/delete `StudyDescription` in the `ResourceManager`

## 0.30.0

* upgrade to null-safety

## 0.21.2+1

* upgrade to `carp_mobile_sensing` and `carp_webservices` v. 0.21.4
* small fix of missing initialization of RP json serialization

## 0.21.0

* upgrade to `carp_mobile_sensing` and `carp_webservices` v. 0.21.x
* added the `CarpStudyProtocolManager` which allow getting `CAMSStudyProtocol`s from CARP
* support for uploading and downloading informed consent to be shown to the user
* support for uploading and downloading localization setting for different languages

## 0.20.3

* update to `carp_core` v. 0.20.3 (json serialization)

## 0.20.0

* **BREAKING**: Now using the [`carp_core`](https://pub.dev/packages/carp_core) domain models in order to align with the overall [domain-driven design of CARP](https://carp.cachet.dk/core/)
* upgrade to `carp_mobile_sensing` v. 0.20.x
* upgrade to `carp_webservices` v. 0.20.x

## 0.13.0

* updated to carp_webservices v. 0.13.x

## 0.12.0

* updated to carp_mobile_sensing v. 0.12.x

## 0.11.2

* updated to carp_webservices v. 0.11.3
* support for getting study id via application data from CARP server

## 0.11.1

* updated to carp_mobile_sensing v. 0.11.1
* updated to carp_webservices v. 0.11.2
* added the `CarpStudyManager` with support for getting a CAMS `Study` from a CARP server.

## 0.11.0

* updated to carp_mobile_sensing v. 0.11.x

## 0.10.0

* updated to carp_mobile_sensing v. 0.10.x

## 0.9.0

* updated to carp_mobile_sensing v. 0.9.x

## 0.8.0

* updated to carp_mobile_sensing v. 0.8.x

## 0.7.0

* update to `carp_mobile_sensing` version 0.7.0
* update to `carp_webservices` version 0.4.0
* support for upload of files that are referenced in a `FileDatum`.

## 0.6.0+1

* auto-generate of json serialization files

## 0.6.0

* `CarpUploadMethod` is now an enumeration
* Support for JSON serialization v. 3.0.0
* update to `carp_mobile_sensing` version 0.6.0

## 0.3.4+2

* bug in authentication fixed
* delete on uploaded support

## 0.3.4

* upgrade to `carp_webservices` v.0.2.6

## 0.3.3

* upgrade to `carp_mobile_sensing` v.0.5.0

## 0.3.2

* upgrade to json_serializable v.2

## 0.3.1

* adjustment to new CARP web service API as implemented in `carp_webservices` package.
* small update to pubspec

## 0.3.0

* Adjustment to refactoring of `carp_mobile_sensing` library to version 0.3.0

## 0.1.1

* Fixed errors in documentation.

## 0.1.0

* Initial version.
