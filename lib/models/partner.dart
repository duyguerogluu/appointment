import 'package:json_annotation/json_annotation.dart';

part 'partner.g.dart';

@JsonSerializable()
class Partner {
  final int id;
  final String name;
  final String taxName;
  final String address;
  final String telephone;
  final String email;
  final String aboutText;
  final int cityId;
  final String city;
  final String district;
  final int districtId;
  final String sector;
  final String category;
  final String customerGender;
  final String authorizedNameSurname;
  final String authorizedTelephone;
  final String taxNumber;
  final String taxAdministration;
  final String taxAddress;
  final String status;
  final bool cash;
  final bool creditCard;
  final bool creditCardOnline;
  final String createdDate;
  final bool featured;
  final bool? agentAccessPermission;
  final bool? pastMonthData;
  final String timezone;
  final List<WorkDay> workDays;
  final double? vatRate;
  final bool available;
  final int? voteCount;
  final double? monthlyPrice;
  final String hourFormat;
  final String subscription;
  final int appointmentResolution;
  final bool appointmentReminder;
  final String? coverImageUrl;
  final String? videoUrl;
  final bool hasWifi;
  final bool hasOutDoor;
  final bool hasParkingSpace;
  final bool hasAirCondition;
  final String urlPostfix;
  final int priceRange;
  final Promotion? promotion;
  Partner({
    required this.id,
    required this.name,
    required this.taxName,
    required this.address,
    required this.telephone,
    required this.email,
    required this.aboutText,
    required this.cityId,
    required this.city,
    required this.district,
    required this.districtId,
    required this.sector,
    required this.category,
    required this.customerGender,
    required this.authorizedNameSurname,
    required this.authorizedTelephone,
    required this.taxNumber,
    required this.taxAdministration,
    required this.taxAddress,
    required this.status,
    required this.cash,
    required this.creditCard,
    required this.creditCardOnline,
    required this.createdDate,
    required this.featured,
    required this.agentAccessPermission,
    required this.pastMonthData,
    required this.timezone,
    required this.workDays,
    required this.vatRate,
    required this.available,
    required this.voteCount,
    required this.monthlyPrice,
    required this.hourFormat,
    required this.subscription,
    required this.appointmentResolution,
    required this.appointmentReminder,
    required this.coverImageUrl,
    required this.videoUrl,
    required this.hasWifi,
    required this.hasOutDoor,
    required this.hasParkingSpace,
    required this.hasAirCondition,
    required this.urlPostfix,
    required this.priceRange,
    required this.promotion,
  });

  Map<String, dynamic> toJson() {
    return _$PartnerToJson(this);
  }

  factory Partner.fromJson(Map<String, dynamic> map) {
    return _$PartnerFromJson(map);
  }
}

@JsonSerializable()
class WorkDay {
  final int id;
  final bool working;
  final String day;
  final String dayShortName;
  final int start;
  final int end;
  final int? breakStart;
  final int? breakEnd;
  final int dayNumber;
  WorkDay({
    required this.id,
    required this.working,
    required this.day,
    required this.dayShortName,
    required this.start,
    required this.end,
    required this.breakStart,
    required this.breakEnd,
    required this.dayNumber,
  });

  Map<String, dynamic> toJson() {
    return _$WorkDayToJson(this);
  }

  factory WorkDay.fromJson(Map<String, dynamic> map) {
    return _$WorkDayFromJson(map);
  }
}

@JsonSerializable()
class Promotion {
  final int id;
  final String createdDate;
  final int paymentsWithCash;
  final int paymentsWithCard;
  final int birthdaySpecialDiscount;
  final int onlineBookingDiscount;
  final double? pointsUsageLowerLimit;
  Promotion({
    required this.id,
    required this.createdDate,
    required this.paymentsWithCash,
    required this.paymentsWithCard,
    required this.birthdaySpecialDiscount,
    required this.onlineBookingDiscount,
    required this.pointsUsageLowerLimit,
  });

  Map<String, dynamic> toJson() {
    return _$PromotionToJson(this);
  }

  factory Promotion.fromJson(Map<String, dynamic> map) {
    return _$PromotionFromJson(map);
  }
}
