import 'package:basic_architecture/Domain/models/sample_data.dart';
import 'package:basic_architecture/Domain/repository/sample_data_repository.dart';
import 'package:basic_architecture/Domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoadSampleDataUseCase implements BaseUseCase<void, List<SampleData>> {
  final SampleDataRepository _sampleDataRepository;

  LoadSampleDataUseCase(this._sampleDataRepository);

  @override
  Future<Either<String, List<SampleData>>> execute(void input) async {
    return await _sampleDataRepository.getSampleData();
  }
}
