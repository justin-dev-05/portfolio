import '../../features/portfolio/domain/entities/project_entity.dart';

class PortfolioConstants {
  static const String name = "Justin Mahida";
  static const String designation = "Mobile & Cross-Platform App Developer";

  static const List<ProjectEntity> projects = [
    // 1. Flagship & AI Projects
    ProjectEntity(
      id: "scanhub",
      name: "ScanHub (AI Card Scanner)",
      category: "Enterprise Systems",
      clientOrPlatform: "Android",
      isFeatured: true,
      technologies: [
        "Flutter",
        "Google Gemini AI",
        "Google ML Kit OCR",
        "REST API",
        "Google Sheets API"
      ],
      description:
          "AI-powered business card scanner and workflow automation mobile app built with Flutter. Uses Google Gemini AI and ML Kit OCR to intelligently parse physical business cards and synchronize structured lead data to Google Sheets CRM.",
      keyFeatures: [
        "Google Gemini AI & ML Kit OCR dual-engine card extraction",
        "Direct Google Sheets CRM synchronization via REST API",
        "Automatic fallback parsing to ensure high accuracy",
        "Structured contact, company, GST, and social handle extraction"
      ],
    ),
    ProjectEntity(
      id: "pdi-dost",
      name: "PDI-Dost (Vehicle Inspection Platform)",
      category: "Enterprise Systems",
      clientOrPlatform: "Android",
      isFeatured: true,
      technologies: [
        "Flutter",
        "Firebase FCM",
        "Video Compression",
        "REST API",
        "BLoC"
      ],
      description:
          "Vehicle pre-delivery inspection (PDI) and booking mobile application connecting vehicle owners and dealerships with certified inspection professionals for multi-point digital diagnostic reports.",
      keyFeatures: [
        "Multi-point evaluation recording with high-res photo & video capture",
        "Integrated video compression and media upload pipelines",
        "Real-time Firebase Push Notifications for task alerts",
        "Lead management and automated digital PDF diagnostic reports"
      ],
    ),

    // 2. Healthcare & Medical Apps
    ProjectEntity(
      id: "meditrack",
      name: "MYMEDITRACK (Family Healthcare Records)",
      category: "Mobile Apps",
      clientOrPlatform: "Android & iOS",
      isFeatured: true,
      technologies: [
        "Flutter",
        "PDF Kit",
        "Firebase FCM",
        "WhatsApp API",
        "Localization"
      ],
      description:
          "Family medical history tracking app to archive prescriptions, diagnostic reports, vaccination schedules, and export encrypted records via PDF or WhatsApp. Published live on Google Play Store & Apple App Store.",
      keyFeatures: [
        "Family medical history & diagnostic report PDF vault",
        "Vaccination scheduling & pregnancy tracking timelines",
        "Instant record export and encrypted WhatsApp sharing",
        "Multi-language support and automated prescription reminders"
      ],
    ),
    ProjectEntity(
      id: "cama-expo",
      name: "CAMA Expo (Multi-Role Event App)",
      category: "Mobile Apps",
      clientOrPlatform: "Android & iOS",
      isFeatured: true,
      technologies: [
        "Flutter",
        "Stripe",
        "QR Scanner",
        "Gamification",
        "Firebase FCM"
      ],
      description:
          "Multi-role conference and exhibition mobile app with tailored portals for Attendees, Exhibitors, Sponsors, Publishers, and Admins for grand trade shows.",
      keyFeatures: [
        "Role-based portals (Attendees, Exhibitors, Sponsors, Admins)",
        "Stripe ticket purchasing and QR badge scanning verification",
        "Exhibitor lead retrieval and real-time in-event networking chat",
        "Gamification challenges and speaker schedule navigation"
      ],
    ),

    ProjectEntity(
      id: "frimline",
      name: "Frimline (Healthcare & Personal Care E-Commerce)",
      category: "Mobile Apps",
      clientOrPlatform: "Native Android (Kotlin & Java)",
      isFeatured: false,
      technologies: [
        "Kotlin Native",
        "Java",
        "DataBinding",
        "MVVM",
        "Payment Gateway"
      ],
      description:
          "Consumer healthcare, wellness, and personal care e-commerce mobile application for online health product retail, multi-address management, and offline cart persistence.",
      keyFeatures: [
        "Multi-category health & wellness product showcase",
        "Local database caching for offline cart persistence",
        "Online payment gateway integration & push notifications",
        "Health blog module and automated order tracking"
      ],
    ),

    // 3. Enterprise & Industrial Operations
    ProjectEntity(
      id: "saapl",
      name: "SAAPL (Industrial Work Order & Quality Inspection)",
      category: "Enterprise Systems",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "GPS Geofencing",
        "PDF Certificate Generator",
        "Firebase FCM",
        "REST API"
      ],
      description:
          "Saapl is an industrial work order tracking and quality inspection mobile application developed using Flutter to streamline field engineering and site auditing operations, GPS-verified check-ins, and automated PDF certificates.",
      keyFeatures: [
        "Digital work order management & contractor deliverable tracking",
        "GPS-verified site check-ins and location-stamped photo auditing",
        "Automated work order & inspection certificate PDF generation",
        "Real-time push notification alerts for urgent job assignments"
      ],
    ),
    ProjectEntity(
      id: "neat-everyday",
      name: "Neat Everyday (Universal POS & Inventory)",
      category: "Enterprise Systems",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "SQLite Offline-First",
        "Barcode Scanner",
        "Pine Labs POS",
        "PDF Print"
      ],
      description:
          "Point of Sale (POS) and inventory management mobile app built with Flutter. Supports offline-first order processing, Pine Labs POS integration, barcode scanning, and instant PDF receipts.",
      keyFeatures: [
        "Offline-first local database architecture with cloud sync",
        "Pine Labs POS terminal & multi-payment split options",
        "Integrated camera barcode scanner for fast item lookups",
        "Instant invoice receipt generation and thermal printing"
      ],
    ),
    ProjectEntity(
      id: "ibh",
      name: "IBH - Indian Business Hub",
      category: "Enterprise Systems",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "Razorpay",
        "Google Sign-In",
        "Firebase FCM",
        "REST API"
      ],
      description:
          "Comprehensive B2B business networking, directory, and CRM mobile app for Indian enterprises and service providers with multi-step onboarding and monetization tools.",
      keyFeatures: [
        "Multi-step verified business onboarding pipeline and CRM lead module",
        "Razorpay Payment Gateway integration for subscriptions & ads",
        "Location-based business discovery and dynamic analytics dashboards",
        "Contact synchronization and real-time lead alerts"
      ],
    ),
    ProjectEntity(
      id: "omc",
      name: "OMC (Sales & Subscription Management)",
      category: "Enterprise Systems",
      clientOrPlatform: "Native Android (Kotlin)",
      isFeatured: false,
      technologies: [
        "Kotlin Native",
        "Google ML Kit OCR",
        "Razorpay",
        "GPS Tracking",
        "MVVM"
      ],
      description:
          "Enterprise customer acquisition and subscription management native Android app. Uses Google ML Kit OCR for automated document parsing and Razorpay for online renewals.",
      keyFeatures: [
        "Digital Customer Acquisition Form (CAF) pipeline",
        "Google ML Kit Text Recognition (OCR) for document parsing",
        "Razorpay payment gateway integration for subscription renewals",
        "GPS field visit tracking and sales target dashboards"
      ],
    ),

    // 4. Retail & E-Commerce Apps
    ProjectEntity(
      id: "gifthampertz",
      name: "Gifthampertz",
      category: "Mobile Apps",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "Razorpay",
        "Firebase FCM",
        "Multi-Language",
        "Node.js"
      ],
      description:
          "Specialized e-commerce mobile application for purchasing and customizing curated gift hampers, featuring scheduled delivery dispatches and secure payments.",
      keyFeatures: [
        "Custom gift hamper basket builder with live price recalculation",
        "Razorpay checkout via UPI, Cards, Net Banking & Wallet",
        "Scheduled date-time delivery dispatch options",
        "Real-time order tracking notifications and localization support"
      ],
    ),
    ProjectEntity(
      id: "funny-bunny",
      name: "Funny Bunny (Modern Retail E-Commerce)",
      category: "Mobile Apps",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: ["Flutter", "Stripe", "Dio REST API", "Firebase FCM"],
      description:
          "Engaging retail e-commerce app with dynamic product catalogs, interactive category browsing, user reviews, and Stripe payment gateway integration.",
      keyFeatures: [
        "Stripe Payment Gateway integration supporting Cards & Wallets",
        "Dio-powered REST API backend with offline cart caching",
        "Real-time product reviews, ratings, and push notifications",
        "Modern fluid shopping cart & order tracking workflow"
      ],
    ),
    ProjectEntity(
      id: "swooosh",
      name: "Swooosh Eco Cleaning Platform",
      category: "Mobile Apps",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "PDF Generator",
        "Play Store Live",
        "REST API",
        "Google Maps"
      ],
      description:
          "B2B e-commerce and field sales management platform serving industrial cleaning distribution across India for over 5 years with sales visit reporting.",
      keyFeatures: [
        "Multi-tiered industrial product catalog for commercial buyers",
        "Location-verified sales visit reporting for field agents",
        "Instant quote PDF document generation and order history",
        "Published live on Google Play Store with active commercial users"
      ],
    ),

    // 5. Booking, Services & Social Networks
    ProjectEntity(
      id: "ams",
      name: "AMS (Appointment & Salon Management)",
      category: "Mobile Apps",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "WhatsApp API",
        "Firebase FCM",
        "SQLite",
        "GetIt"
      ],
      description:
          "Salon, spa & professional academy appointment booking system with automated WhatsApp receipt dispatch, calendar management, and retail POS counter.",
      keyFeatures: [
        "End-to-end appointment booking engine with specialist selection",
        "Integrated Academy module for course enrollment & student records",
        "One-click WhatsApp invoice and reminder receipt dispatch",
        "Retail POS counter for service and product sales"
      ],
    ),
    ProjectEntity(
      id: "market-theory",
      name: "The Market Theory (Lifestyle Discovery & Booking)",
      category: "Mobile Apps",
      clientOrPlatform: "Native Android (Kotlin)",
      isFeatured: false,
      technologies: [
        "Kotlin Native",
        "Google Maps",
        "Stripe",
        "MVVM",
        "DataBinding"
      ],
      description:
          "Hyper-local lifestyle discovery native Android app for table bookings at restaurants, salon appointments, and gym session reservations.",
      keyFeatures: [
        "Multi-vertical reservation engine (Dining, Wellness, Fitness)",
        "Location-based venue discovery on interactive maps",
        "Promotional deal coupon redemption and online checkout"
      ],
    ),
    ProjectEntity(
      id: "family-tree",
      name: "Family Tree (Genealogy & Family Network)",
      category: "Mobile Apps",
      clientOrPlatform: "Android",
      isFeatured: false,
      technologies: [
        "Flutter",
        "Socket.IO",
        "Hierarchical Graph",
        "Encrypted Storage"
      ],
      description:
          "Genealogical networking app to map multi-generational family trees, preserve biographical life stories, and engage in family group messaging.",
      keyFeatures: [
        "Interactive hierarchical graph engine mapping extended relatives",
        "Socket.IO real-time family group messaging and document vault",
        "Secure referral invitation codes for verified family members",
        "Anniversary reminders and historical media archiving"
      ],
    ),

    // 6. Native Android Utility & Specialized Systems
    ProjectEntity(
      id: "brand-mania",
      name: "Brand Mania (Automated Poster Studio)",
      category: "Mobile Apps",
      clientOrPlatform: "Native Android (Kotlin)",
      isFeatured: false,
      technologies: [
        "Kotlin Native",
        "iText PDF",
        "Video Renderer",
        "Razorpay",
        "DataBinding"
      ],
      description:
          "Digital branding and poster creation studio enabling business owners to design custom marketing visuals, business cards, and video posters.",
      keyFeatures: [
        "Photo editing studio with custom typography, filters & layering",
        "iText PDF engine for digital business cards & marketing brochures",
        "Video poster preview rendering engine and template store",
        "Razorpay subscription gateway for premium branding assets"
      ],
    ),
    ProjectEntity(
      id: "leo-polymers",
      name: "Leo Polymers (Supply Chain & Barcode)",
      category: "Enterprise Systems",
      clientOrPlatform: "Native Android (Kotlin)",
      isFeatured: false,
      technologies: [
        "Kotlin Native",
        "Barcode Scanning",
        "MVVM",
        "Async Processing"
      ],
      description:
          "Enterprise sales order and supply chain tracking system with camera barcode scanning for rapid packing slip entry and warehouse inventory tracking.",
      keyFeatures: [
        "Camera-based barcode scanning for instant packing slip entry",
        "Complete order lifecycle tracking from warehouse to delivery",
        "Asynchronous data processing and instant push dispatch alerts"
      ],
    ),
    ProjectEntity(
      id: "ssn",
      name: "Sky Sports Network (SSN Streaming)",
      category: "Mobile Apps",
      clientOrPlatform: "Native Android (Kotlin)",
      isFeatured: false,
      technologies: [
        "Kotlin Native",
        "HLS / DASH",
        "Razorpay",
        "Google Play Billing",
        "MVVM"
      ],
      description:
          "Digital video streaming and media subscription app with adaptive HLS/DASH media playback, video-on-demand, and pay-per-view access.",
      keyFeatures: [
        "Adaptive HLS and DASH video streaming playback engine",
        "Google Play In-App Billing and Razorpay payment integration",
        "Native Android MVVM architecture with smooth UI responsiveness",
        "OTP-based authentication and watchlist management"
      ],
    ),
    ProjectEntity(
      id: "topper-27",
      name: "Topper-27 (Competitive Exam Learning)",
      category: "Mobile Apps",
      clientOrPlatform: "Native Android (Java)",
      isFeatured: false,
      technologies: ["Java Native", "PDF Viewer", "Exam Engine", "DataBinding"],
      description:
          "Educational e-learning native Android app for civil services and entrance exam preparation with timed mock tests, performance analytics, and e-books.",
      keyFeatures: [
        "Online examination engine with timed mock tests & score analytics",
        "Digital learning hub with video lectures & PDF e-books",
        "Integrated digital store for purchasing test series packages"
      ],
    ),
    ProjectEntity(
      id: "smwc",
      name: "SMWC (Secure My Will Call)",
      category: "Enterprise Systems",
      clientOrPlatform: "Native Android (Kotlin)",
      isFeatured: false,
      technologies: ["Kotlin Native", "QR Scanner", "ViewBinding", "REST API"],
      description:
          "Event ticket verification and package pickup validation native Android app with high-speed camera QR/barcode scanning for instant gate access control.",
      keyFeatures: [
        "High-speed camera QR code & barcode ticket validation",
        "Anti-fraud ticket authentication & real-time scan history",
        "Venue profile management and secure access control"
      ],
    ),
  ];
}
