import 'package:collabflutter/models/plan_model.dart';
import 'package:collabflutter/services/plan_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collabflutter/models/todo_model.dart';
import 'package:collabflutter/services/todo_repo.dart';

class PlanController extends StateNotifier<AsyncValue<List<PlanModel>>> {
  PlanController(this._read) : super(const AsyncValue.loading()) {
    getPlan();
  }

  final Reader _read;

  static final planControllerProvider = StateNotifierProvider.autoDispose<
      PlanController, AsyncValue<List<PlanModel>>>((ref) {
        return PlanController(ref.read);
    }
  );

  Future<void> addPlan(PlanModel plan) async {
    final _planRepository = _read(PlanRepository.planRepositoryProvider);
    final id = await _planRepository.createPlan(plan);
    state.whenData((items) => state = AsyncValue.data(items..add(plan.copyWith(id: id))));
  }

  Future<void> getPlan() async {
    final _planRepository = _read(PlanRepository.planRepositoryProvider);
    final _plans = await _planRepository.readPlan();
    state = AsyncValue.data(_plans);
  }

  Future<void> editPlan(PlanModel plan) async {
    final _planRepository = _read(PlanRepository.planRepositoryProvider);
    _planRepository.updatePlan(plan);
    state.whenData((items) {
      state = AsyncValue.data([
        for (final item in items)
          if (item.id == plan.id) plan else item
      ]);
    });
  }

  Future<void> removePlan(String id) async {
    final _planRepository = _read(PlanRepository.planRepositoryProvider);
    _planRepository.deletePlan(id);
    state.whenData((items) {
      items.removeWhere((item) => item.id == id);
      state = AsyncValue.data(items);
    });
  }
}