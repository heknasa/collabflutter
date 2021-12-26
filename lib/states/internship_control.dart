import 'package:collabflutter/models/internship_model.dart';
import 'package:collabflutter/services/internship_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InternshipController extends StateNotifier<AsyncValue<List<InternshipModel>>> {
  InternshipController(this._read) : super(const AsyncValue.loading()) {
    getInternship();
  }

  final Reader _read;

  static final internshipControllerProvider = StateNotifierProvider.autoDispose<
      InternshipController, AsyncValue<List<InternshipModel>>>((ref) {
        return InternshipController(ref.read);
    }
  );

  Future<void> getInternship() async {
    final _internshipRepository = _read(InternshipRepository.internshipRepositoryProvider);
    final _internships = await _internshipRepository.readInternship();
    state = AsyncValue.data(_internships);
  }
}