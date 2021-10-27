import 'package:collabflutter/models/plan_model.dart';
import 'package:collabflutter/providers/firebase_provider.dart';
import 'package:collabflutter/states/auth_control.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BasePlanRepository {
  Future<String> createPlan(PlanModel plan);
  Future<List<PlanModel>> readPlan();
  Future<void> updatePlan(PlanModel plan);
  Future<void> deletePlan(String id);
}

class PlanRepository implements BasePlanRepository {
  final Reader _read;
  PlanRepository(this._read);

  static final planRepositoryProvider = Provider<PlanRepository>((ref) {
    return PlanRepository(ref.read);
  });

  @override
  Future<String> createPlan(PlanModel plan) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    final _plans = _firestore.collection('plans').doc(_uid).collection('plan');
    final _plan = await _plans.add(plan.toMap());
    return _plan.id;
  }

  @override
  Future<List<PlanModel>> readPlan() async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    final _todos = await _firestore.collection('plans').doc(_uid).collection('plan').get();
    return _todos.docs.map((x) => PlanModel.fromDocument(x)).toList();
  }

  @override
  Future<void> updatePlan(PlanModel plan) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    _firestore.collection('plans').doc(_uid).collection('plan').doc(plan.id).update(plan.toMap());
  }

  @override
  Future<void> deletePlan(String id) async {
    final _firestore = _read(FirebaseProvider.firestoreProvider);
    final _uid = _read(AuthController.authControllerProvider)?.uid;
    _firestore.collection('plans').doc(_uid).collection('plan').doc(id).delete();
  }
}