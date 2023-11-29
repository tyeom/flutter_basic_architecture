import 'package:basic_architecture/Data/network/api_endpoint.dart';
import 'package:basic_architecture/Data/responses/sample_data_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_sample_data_service.g.dart';

@RestApi()
abstract class ApiSampleDataService {
  factory ApiSampleDataService(final Dio dio) = _ApiSampleDataService;

  /// 샘플 데이터 정보 요청
  @GET("${ApiEndpoint.sampleDataApi}")
  Future<List<SampleDataResponse>> getSampleData();

  /// 샘플 데이터 상세 정보 요청
  @GET("${ApiEndpoint.sampleDataApi}/{id}")
  Future<SampleDataResponse> getDetailSampleData(
    @Path("id") int id,
  );
}
