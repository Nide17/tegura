import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:tegura/utilities/appbar.dart';

class IgazetiBook extends StatefulWidget {
  const IgazetiBook({super.key});

  @override
  State<IgazetiBook> createState() => _IgazetiBookState();
}

class _IgazetiBookState extends State<IgazetiBook> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    _loadPdfDoc();
  }

  _loadPdfDoc() async {
    document = await PDFDocument.fromURL(
        "https://firebasestorage.googleapis.com/v0/b/tegura-rw.appspot.com/o/docs%2FIGAZETI-%5BShared%20by%20QuizBlog%5D.PDF?alt=media&token=dd96dc37-679a-48c8-8416-0312d615dc76");
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    print("IgazetiBook _isLoading: $_isLoading");
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      // APP BAR
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(58.0),
        child: AppBarTegura(),
      ),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 8,
              ),
      ),
    );
  }
}
