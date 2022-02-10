class ApplicationInfo {
  String applicationName;
  String buildVersion;
  String buildTimestamp;

  ApplicationInfo(
      {required this.applicationName,
      required this.buildVersion,
      required this.buildTimestamp});

  ApplicationInfo.fromJson(Map<String, dynamic> json)
      : applicationName = json['applicationName'],
        buildVersion = json['buildVersion'],
        buildTimestamp = json['buildTimestamp'];

  Map<String, dynamic> toJson() => {
        'applicationName': applicationName,
        'buildVersion': buildVersion,
        'buildTimestamp': buildTimestamp,
      };
}
