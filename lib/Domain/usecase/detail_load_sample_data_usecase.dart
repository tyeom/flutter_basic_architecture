import 'package:basic_architecture/Domain/models/sample_data.dart';
import 'package:basic_architecture/Domain/repository/sample_data_repository.dart';
import 'package:basic_architecture/Domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class DetailLoadSampleDataUseCase implements BaseUseCase<int, SampleData> {
  final SampleDataRepository _sampleDataRepository;

  DetailLoadSampleDataUseCase(this._sampleDataRepository);

  @override
  Future<Either<String, SampleData>> execute(int input) async {
    return await _sampleDataRepository.getDetailSampleData(input);
  }
}
