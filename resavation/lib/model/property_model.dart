import 'package:resavation/utility/assets.dart';

class Property {
  final int id;
  final String image;
  final int? amountPerYear;
  final String location;
  final String address;
  final int numberOfBedrooms;
  final int numberOfBathrooms;
  final int squareFeet;
  final bool isFavoriteTap;
  final String? category;

  ///
  final String description;
  final String ownerProfileImage;
  final String ownerProfileName;
  final String ownerAgentType;
  final List<String> houseRules;

  Property({
    required this.id,
    this.ownerAgentType = '',
    required this.image,
    this.amountPerYear,
    this.houseRules = const [],
    this.description = '',
    this.ownerProfileImage = '',
    this.ownerProfileName = '',
    required this.location,
    this.address = '',
    required this.numberOfBedrooms,
    required this.numberOfBathrooms,
    required this.squareFeet,
    required this.isFavoriteTap,
    this.category,
  });
}

final listOfProperties = <Property>[
  Property(
    id: 1,
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
    ownerAgentType: 'Property Owner',
    ownerProfileImage: Assets.profile_image2,
    ownerProfileName: 'Jimoh Samuel',
    houseRules: [
      "Timely Rent Payments and Late Fees.",
      "Maintenance, Repairs, and Cleanliness.",
      "Renters Insurance.",
      "Pet Policies.",
      "Quiet Hours.",
      "Lease Renewals and Notice Periods.",
      "Damage Deductions from the Security Deposit.",
      "Consequences of Lease Breaking.",
    ],
    image: Assets.sitting_room_placeholder,
    amountPerYear: 13050,
    location: 'Murea Properties',
    address: '57 Fajuyi Rd, 220212, Ife',
    numberOfBathrooms: 10,
    numberOfBedrooms: 5,
    squareFeet: 200,
    isFavoriteTap: true,
    category: 'Apartment',
  ),
  Property(
      id: 2,
      image: Assets.house_placeholder,
      amountPerYear: 230000,
      houseRules: [
        "Timely Rent Payments and Late Fees.",
        "Maintenance, Repairs, and Cleanliness.",
        "Renters Insurance.",
        "Pet Policies.",
        "Quiet Hours.",
        "Lease Renewals and Notice Periods.",
        "Damage Deductions from the Security Deposit.",
        "Consequences of Lease Breaking.",
      ],
      location: 'Trinity Estate and Co',
      address: 'No. 72, opposite Old Nitel building, Parakin Rd, 220101, Ife',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
      ownerAgentType: 'Listing Agent',
      ownerProfileImage: Assets.profile_image3,
      ownerProfileName: 'Samuel Adeyeye',
      isFavoriteTap: false,
      category: 'Apartment'),
  Property(
      id: 3,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 134200,
      location: 'Banana Estate',
      address: 'No. 72, opposite Old Nitel building, Parakin Rd, 220101, Ife',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      squareFeet: 200,
      houseRules: [
        "Timely Rent Payments and Late Fees.",
        "Maintenance, Repairs, and Cleanliness.",
        "Renters Insurance.",
        "Pet Policies.",
        "Quiet Hours.",
        "Lease Renewals and Notice Periods.",
        "Damage Deductions from the Security Deposit.",
        "Consequences of Lease Breaking.",
      ],
      isFavoriteTap: true,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
      ownerAgentType: 'Property Owner',
      ownerProfileImage: Assets.profile_image,
      ownerProfileName: 'Jimoh Samuel',
      category: 'Office Space'),
  Property(
      id: 4,
      image: Assets.lagos_location_placeholder,
      amountPerYear: 322000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      houseRules: [
        "Timely Rent Payments and Late Fees.",
        "Maintenance, Repairs, and Cleanliness.",
        "Renters Insurance.",
        "Pet Policies.",
        "Quiet Hours.",
        "Lease Renewals and Notice Periods.",
        "Damage Deductions from the Security Deposit.",
        "Consequences of Lease Breaking.",
      ],
      numberOfBedrooms: 5,
      squareFeet: 200,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
      ownerAgentType: 'Property Owner',
      ownerProfileImage: Assets.profile_image2,
      ownerProfileName: 'Jimoh Samuel',
      isFavoriteTap: true,
      category: 'Apartment'),
  Property(
      id: 5,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      houseRules: [
        "Timely Rent Payments and Late Fees.",
        "Maintenance, Repairs, and Cleanliness.",
        "Renters Insurance.",
        "Pet Policies.",
        "Quiet Hours.",
        "Lease Renewals and Notice Periods.",
        "Damage Deductions from the Security Deposit.",
        "Consequences of Lease Breaking.",
      ],
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
      ownerAgentType: 'Property Owner',
      ownerProfileImage: Assets.profile_image2,
      ownerProfileName: 'Jimoh Samuel',
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Kitchen'),
  Property(
      id: 6,
      image: Assets.sitting_room_placeholder,
      amountPerYear: 10000,
      houseRules: [
        "Timely Rent Payments and Late Fees.",
        "Maintenance, Repairs, and Cleanliness.",
        "Renters Insurance.",
        "Pet Policies.",
        "Quiet Hours.",
        "Lease Renewals and Notice Periods.",
        "Damage Deductions from the Security Deposit.",
        "Consequences of Lease Breaking.",
      ],
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      numberOfBedrooms: 5,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
      ownerAgentType: 'Property Owner',
      ownerProfileImage: Assets.profile_image2,
      ownerProfileName: 'Jimoh Samuel',
      squareFeet: 200,
      isFavoriteTap: true,
      category: 'Apartment'),
  Property(
      id: 7,
      image: Assets.sitting_room_placeholder,
      houseRules: [
        "Timely Rent Payments and Late Fees.",
        "Maintenance, Repairs, and Cleanliness.",
        "Renters Insurance.",
        "Pet Policies.",
        "Quiet Hours.",
        "Lease Renewals and Notice Periods.",
        "Damage Deductions from the Security Deposit.",
        "Consequences of Lease Breaking.",
      ],
      amountPerYear: 10000,
      location: 'Eleko Estate',
      address: '57B lagos street',
      numberOfBathrooms: 10,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent interdum nisi nec fringilla bibendum. Sed malesuada diam ut ipsum hendrerit, mattis feugiat leo molestie. Sed sit amet venenatis ipsum. Sed faucibus aliquet lacinia. Donec nec urna massa. Aliquam id mattis nibh. Duis feugiat maximus iaculis. Mauris volutpat dictum lorem, ac scelerisque purus consectetur sit amet.Duis laoreet, quam sit amet sodales hendrerit, elit nunc ullamcorper tellus, vitae dignissim tortor lorem vel magna. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aenean scelerisque facilisis nisi, ut eleifend metus volutpat et. Maecenas maximus malesuada tempus. Etiam aliquam lacinia tristique. Suspendisse vitae tortor gravida, vulputate nulla quis, sagittis sem. Phasellus ante ex, feugiat eu porta ut, ullamcorper in sem. ",
      ownerAgentType: 'Property Owner',
      ownerProfileImage: Assets.profile_image2,
      ownerProfileName: 'Jimoh Samuel',
      numberOfBedrooms: 5,
      squareFeet: 200,
      isFavoriteTap: true,
      category: "Apartment"),
];
