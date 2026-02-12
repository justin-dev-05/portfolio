import 'package:equatable/equatable.dart';

class InspectionModel extends Equatable {
  final String customerName;
  final String address;
  final String date;
  final String status;
  final String vehicleNumber;
  final String vehicleModel;
  final String phone;
  final String inspectionType;

  const InspectionModel({
    required this.customerName,
    required this.address,
    required this.date,
    required this.status,
    required this.vehicleNumber,
    required this.vehicleModel,
    required this.phone,
    required this.inspectionType,
  });

  @override
  List<Object?> get props => [
        customerName,
        address,
        date,
        status,
        vehicleNumber,
        vehicleModel,
        phone,
        inspectionType,
      ];
}
