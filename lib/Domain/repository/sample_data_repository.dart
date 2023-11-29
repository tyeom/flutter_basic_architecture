import 'package:basic_architecture/Domain/models/sample_data.dart';
import 'package:dartz/dartz.dart';

abstract class SampleDataRepository {
  Future<Either<String, List<SampleData>>> getSampleData();
  Future<Either<String, SampleData>> getDetailSampleData(int id);
}
