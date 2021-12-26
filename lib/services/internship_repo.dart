import 'package:collabflutter/models/internship_model.dart';
import 'package:collabflutter/providers/gsheets_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseInternshipRepository {
  Future<List<InternshipModel>> readInternship();
}

class InternshipRepository implements BaseInternshipRepository {
  final Reader _read;
  InternshipRepository(this._read);  
  static const spreadsheetID = '1u3330CEUGgB3DAXrzpxNC9doXcHcSXs_0Uawj2Zm6WM';
  static const worksheetTitle = 'internship';

  static final internshipRepositoryProvider = Provider<InternshipRepository>((ref) {
    return InternshipRepository(ref.read);
  });

  @override
  Future<List<InternshipModel>> readInternship() async {    
    final gsheets = _read(GsheetsProvider.gsheetsProvider);    
    final _spreadsheet = await gsheets.spreadsheet(spreadsheetID);
    final _internshipSheet = _spreadsheet.worksheetByTitle(worksheetTitle);
    final internships = await _internshipSheet!.values.map.allRows();
    return internships!.map((x) => InternshipModel.fromGsheets(x)).toList();
  }
}