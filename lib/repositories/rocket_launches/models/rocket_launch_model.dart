class RocketLaunch {
  final DateTime dateUtc;
  final String missionName;
  final String launchSiteName;
  final String rocketId;
  final String? wikipedia;

  const RocketLaunch({
    required this.dateUtc,
    required this.missionName,
    required this.launchSiteName,
    required this.rocketId,
    this.wikipedia,
  });

  factory RocketLaunch.fromJson(Map<String, dynamic> j) {
    final site   = (j['launch_site'] as Map?) ?? {};
    final rocket = (j['rocket'] as Map?) ?? {};
    final links  = (j['links']  as Map?) ?? {};

    return RocketLaunch(
      dateUtc: DateTime.parse(j['launch_date_utc'] as String).toUtc(),
      missionName: j['mission_name'] as String,
      launchSiteName: (site['site_name_long'] as String),
      rocketId: (rocket['rocket_id'] as String),
      wikipedia: links['wikipedia'] as String?,
    );
  }
  
  String get dateDmy => '${dateUtc.day}:${dateUtc.month}:${dateUtc.year}';
  String get timeHmAmPm {
    final h = dateUtc.hour;
    final m = dateUtc.minute.toString().padLeft(2, '0');
    final ampm = h >= 12 ? 'PM' : 'AM';
    final h12 = (h % 12 == 0) ? 12 : h % 12;
    return '$h12:$m $ampm';
  }
}
