import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'resume_downloader_stub.dart'
    if (dart.library.html) 'resume_downloader_web.dart';

class ResumeHelper {
  static const String resumePath = 'assets/pdf/resume.pdf';

  static Future<void> downloadResume() async {
    try {
      final ByteData data = await rootBundle.load(resumePath);
      final List<int> bytes = data.buffer.asUint8List();

      if (kIsWeb) {
        downloadResumeWeb(bytes, 'Justin_Resume.pdf');
      } else {
        // Mobile / Desktop fallback using Data URI
        final String base64Pdf = base64Encode(bytes);
        final Uri dataUri = Uri.parse('data:application/pdf;base64,$base64Pdf');
        
        if (await canLaunchUrl(dataUri)) {
          await launchUrl(dataUri, mode: LaunchMode.externalApplication);
        } else {
          final Uri fallbackUri = Uri.parse(resumePath);
          await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      debugPrint('Error downloading resume: $e');
    }
  }
}
