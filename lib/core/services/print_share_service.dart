import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';

@injectable
class PrintShareService {
  /// Print PDF using system print dialog
  Future<bool> printPdf(Uint8List pdfBytes) async {
    try {
      await Printing.layoutPdf(onLayout: (format) async => pdfBytes);
      return true;
    } catch (e) {
      print('Error printing PDF: $e');
      return false;
    }
  }

  /// Print to thermal printer (58mm format)
  Future<bool> printThermal(String thermalData) async {
    try {
      // For thermal printing, we'll use the printing package's capability
      // This can be extended to work with specific thermal printer SDKs

      // Convert thermal text to PDF for printing
      final pdfBytes = await _thermalTextToPdf(thermalData);

      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        format: PdfPageFormat(
          58 * PdfPageFormat.mm, // 58mm width
          200 * PdfPageFormat.mm, // Dynamic height
          marginAll: 2 * PdfPageFormat.mm,
        ),
      );
      return true;
    } catch (e) {
      print('Error printing thermal: $e');
      return false;
    }
  }

  /// Share PDF file
  Future<bool> sharePdfFile(Uint8List pdfBytes, String fileName) async {
    try {
      // Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName.pdf');
      await file.writeAsBytes(pdfBytes);

      // Share the file
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Receipt from RestoApp');
      return true;
    } catch (e) {
      print('Error sharing PDF: $e');
      return false;
    }
  }

  /// Share thermal receipt as text
  Future<bool> shareThermalText(String thermalData, String fileName) async {
    try {
      // Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName.txt');
      await file.writeAsString(thermalData);

      // Share the file
      await Share.shareXFiles([
        XFile(file.path),
      ], text: 'Receipt from RestoApp');
      return true;
    } catch (e) {
      print('Error sharing thermal text: $e');
      return false;
    }
  }

  /// Share receipt as plain text
  Future<bool> shareText(String text) async {
    try {
      await Share.share(text, subject: 'Receipt from RestoApp');
      return true;
    } catch (e) {
      print('Error sharing text: $e');
      return false;
    }
  }

  /// Check if printing is available
  Future<bool> isPrintingAvailable() async {
    try {
      await Printing.info();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Show print preview
  Future<bool> showPrintPreview(Uint8List pdfBytes, String title) async {
    try {
      await Printing.layoutPdf(
        onLayout: (format) async => pdfBytes,
        name: title,
      );
      return true;
    } catch (e) {
      print('Error showing print preview: $e');
      return false;
    }
  }

  // Helper method to convert thermal text to PDF
  Future<Uint8List> _thermalTextToPdf(String thermalData) async {
    // This is a simplified version - in a real app you'd want to
    // properly format the thermal text with monospace font
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(
          58 * PdfPageFormat.mm,
          200 * PdfPageFormat.mm,
          marginAll: 2 * PdfPageFormat.mm,
        ),
        build: (context) =>
            pw.Text(thermalData, style: const pw.TextStyle(fontSize: 8)),
      ),
    );

    return await pdf.save();
  }
}
