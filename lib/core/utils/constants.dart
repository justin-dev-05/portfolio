import '../../features/portfolio/domain/entities/project_entity.dart';

class PortfolioConstants {
  static const String name = "Justin Mahida";
  static const String designation = "Mobile App Developer";

  static const List<ProjectEntity> projects = [
    ProjectEntity(
      name: "Gifthampertz",
      description: "Our e-commerce app offers a seamless shopping experience with categorized gift products, secure checkout, order tracking, and a scalable backend.",
    ),
    ProjectEntity(
      name: "Appointment Management System",
      description: "A salon appointment booking app with reminders, calendar management, billing generation, WhatsApp sharing, and income/expense tracking.",
    ),
    ProjectEntity(
      name: "Swooosh App",
      description: "An eco-friendly cleaning solutions app serving the Indian market for over 5 years, promoting sustainable and innovative products.",
    ),
    ProjectEntity(
      name: "Family Tree",
      description: "A family record management app allowing users to create trees, invite members via reference codes, and manage relationships securely.",
    ),
    ProjectEntity(
      name: "MYMEDITRACK",
      description: "A medical history tracking app for families with sharing support via WhatsApp and social platforms.",
    ),
    ProjectEntity(
      name: "OMC",
      description: "A sales and customer renewal management app handling active users, purchases, and renewals.",
    ),
    ProjectEntity(
      name: "The Market Theory",
      description: "A food and restaurant management app supporting table booking, food delivery, coupons, and loyalty points.",
    ),
    ProjectEntity(
      name: "SMWC (Secure My Will Call)",
      description: "A QR-based order verification app that fetches order codes and notifies users to complete orders.",
    ),
  ];
}
