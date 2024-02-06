// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Partner _$PartnerFromJson(Map<String, dynamic> json) => Partner(
      id: json['id'] as int,
      name: json['name'] as String,
      taxName: json['taxName'] as String,
      address: json['address'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      aboutText: json['aboutText'] as String,
      cityId: json['cityId'] as int,
      city: json['city'] as String,
      district: json['district'] as String,
      districtId: json['districtId'] as int,
      sector: json['sector'] as String,
      category: json['category'] as String,
      customerGender: json['customerGender'] as String,
      authorizedNameSurname: json['authorizedNameSurname'] as String,
      authorizedTelephone: json['authorizedTelephone'] as String,
      taxNumber: json['taxNumber'] as String,
      taxAdministration: json['taxAdministration'] as String,
      taxAddress: json['taxAddress'] as String,
      status: json['status'] as String,
      cash: json['cash'] as bool,
      creditCard: json['creditCard'] as bool,
      creditCardOnline: json['creditCardOnline'] as bool,
      createdDate: json['createdDate'] as String,
      featured: json['featured'] as bool,
      agentAccessPermission: json['agentAccessPermission'] as bool?,
      pastMonthData: json['pastMonthData'] as bool?,
      timezone: json['timezone'] as String,
      workDays: (json['workDays'] as List<dynamic>)
          .map((e) => WorkDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      vatRate: (json['vatRate'] as num?)?.toDouble(),
      available: json['available'] as bool,
      voteCount: json['voteCount'] as int?,
      monthlyPrice: (json['monthlyPrice'] as num?)?.toDouble(),
      hourFormat: json['hourFormat'] as String,
      subscription: json['subscription'] as String,
      appointmentResolution: json['appointmentResolution'] as int,
      appointmentReminder: json['appointmentReminder'] as bool,
      coverImageUrl: json['coverImageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      hasWifi: json['hasWifi'] as bool,
      hasOutDoor: json['hasOutDoor'] as bool,
      hasParkingSpace: json['hasParkingSpace'] as bool,
      hasAirCondition: json['hasAirCondition'] as bool,
      urlPostfix: json['urlPostfix'] as String,
      priceRange: json['priceRange'] as int,
      promotion: json['promotion'] == null
          ? null
          : Promotion.fromJson(json['promotion'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PartnerToJson(Partner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'taxName': instance.taxName,
      'address': instance.address,
      'telephone': instance.telephone,
      'email': instance.email,
      'aboutText': instance.aboutText,
      'cityId': instance.cityId,
      'city': instance.city,
      'district': instance.district,
      'districtId': instance.districtId,
      'sector': instance.sector,
      'category': instance.category,
      'customerGender': instance.customerGender,
      'authorizedNameSurname': instance.authorizedNameSurname,
      'authorizedTelephone': instance.authorizedTelephone,
      'taxNumber': instance.taxNumber,
      'taxAdministration': instance.taxAdministration,
      'taxAddress': instance.taxAddress,
      'status': instance.status,
      'cash': instance.cash,
      'creditCard': instance.creditCard,
      'creditCardOnline': instance.creditCardOnline,
      'createdDate': instance.createdDate,
      'featured': instance.featured,
      'agentAccessPermission': instance.agentAccessPermission,
      'pastMonthData': instance.pastMonthData,
      'timezone': instance.timezone,
      'workDays': instance.workDays,
      'vatRate': instance.vatRate,
      'available': instance.available,
      'voteCount': instance.voteCount,
      'monthlyPrice': instance.monthlyPrice,
      'hourFormat': instance.hourFormat,
      'subscription': instance.subscription,
      'appointmentResolution': instance.appointmentResolution,
      'appointmentReminder': instance.appointmentReminder,
      'coverImageUrl': instance.coverImageUrl,
      'videoUrl': instance.videoUrl,
      'hasWifi': instance.hasWifi,
      'hasOutDoor': instance.hasOutDoor,
      'hasParkingSpace': instance.hasParkingSpace,
      'hasAirCondition': instance.hasAirCondition,
      'urlPostfix': instance.urlPostfix,
      'priceRange': instance.priceRange,
      'promotion': instance.promotion,
    };

WorkDay _$WorkDayFromJson(Map<String, dynamic> json) => WorkDay(
      id: json['id'] as int,
      working: json['working'] as bool,
      day: json['day'] as String,
      dayShortName: json['dayShortName'] as String,
      start: json['start'] as int,
      end: json['end'] as int,
      breakStart: json['breakStart'] as int?,
      breakEnd: json['breakEnd'] as int?,
      dayNumber: json['dayNumber'] as int,
    );

Map<String, dynamic> _$WorkDayToJson(WorkDay instance) => <String, dynamic>{
      'id': instance.id,
      'working': instance.working,
      'day': instance.day,
      'dayShortName': instance.dayShortName,
      'start': instance.start,
      'end': instance.end,
      'breakStart': instance.breakStart,
      'breakEnd': instance.breakEnd,
      'dayNumber': instance.dayNumber,
    };

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      id: json['id'] as int,
      createdDate: json['createdDate'] as String,
      paymentsWithCash: json['paymentsWithCash'] as int,
      paymentsWithCard: json['paymentsWithCard'] as int,
      birthdaySpecialDiscount: json['birthdaySpecialDiscount'] as int,
      onlineBookingDiscount: json['onlineBookingDiscount'] as int,
      pointsUsageLowerLimit:
          (json['pointsUsageLowerLimit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate,
      'paymentsWithCash': instance.paymentsWithCash,
      'paymentsWithCard': instance.paymentsWithCard,
      'birthdaySpecialDiscount': instance.birthdaySpecialDiscount,
      'onlineBookingDiscount': instance.onlineBookingDiscount,
      'pointsUsageLowerLimit': instance.pointsUsageLowerLimit,
    };
