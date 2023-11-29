import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/component/placeholders.dart';
import 'package:basic_architecture/Presentation/home/bloc/sample_data_bloc.dart';
import 'package:basic_architecture/Presentation/routes_manager.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class DesktopHomeView extends StatefulWidget {
  const DesktopHomeView({super.key});

  @override
  State<DesktopHomeView> createState() => _DesktopHomeViewState();
}

class _DesktopHomeViewState extends State<DesktopHomeView> {
  @override
  void initState() {
    super.initState();
  }

  // 경계선
  Widget _line() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _listLoadingWidget() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              BannerPlaceholder(),
              TitlePlaceholder(width: double.infinity),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
              SizedBox(height: 16.0),
              TitlePlaceholder(width: 200.0),
              SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.twoLines,
              ),
            ],
          ),
        ));
  }

  Widget _listViewWidget() {
    return Expanded(
      child: BlocBuilder<SampleDataBloc, SampleDataState>(
        buildWhen: (prev, cur) =>
            (prev.status == DataLoadStatus.empty ||
                prev.status == DataLoadStatus.error ||
                prev.status == DataLoadStatus.loading ||
                prev.status == DataLoadStatus.loaded) &&
            (cur.status == DataLoadStatus.empty ||
                cur.status == DataLoadStatus.error ||
                cur.status == DataLoadStatus.loading ||
                cur.status == DataLoadStatus.loaded) &&
            prev.sampleDataList != cur.sampleDataList,
        builder: (context, state) {
          if (state is EmptyDataState) {
            return const Text('No data.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          } else if (state is LoadingState) {
            return _listLoadingWidget();
          } else if (state is LoadedState) {
            // 로드 완료 데이터
            final dataList = state.sampleDataList!;

            return ListView.separated(
              itemCount: dataList.length,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const ClampingScrollPhysics(), // bounce 효과 제거
              itemBuilder: (context, index) {
                final item = dataList[index];

                return Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<SampleDataBloc>()
                          .add(GetDetailSampleDataEvent(item.id));

                      showFlexibleBottomSheet(
                        context: context,
                        builder: (innerContext, sc, bottomSheetOffset) =>
                            BlocProvider.value(
                          value: context.read<SampleDataBloc>(),
                          child: _buildBottomSheet(),
                        ),
                      );
                      // showModalBottomSheet(
                      //   context: context,
                      //   builder: (_) => BlocProvider.value(
                      //     value: context.read<SampleDataBloc>(),
                      //     child: _buildBottomSheet(),
                      //   ),
                      // );
                    },
                    child: Row(children: [
                      Text(item.id.toString(),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey)),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(item.title.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey)),
                      )
                    ]),
                  ),
                );
              },
              separatorBuilder: (_, index) => const Divider(),
            );
          } else {
            return const Text('Error loading data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }
        },
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Material(
      child: BlocBuilder<SampleDataBloc, SampleDataState>(
        buildWhen: (prev, cur) =>
            (prev.status == DataLoadStatus.detailError ||
                prev.status == DataLoadStatus.feteching ||
                prev.status == DataLoadStatus.detailLoaded) &&
            (cur.status == DataLoadStatus.detailError ||
                cur.status == DataLoadStatus.feteching ||
                cur.status == DataLoadStatus.detailLoaded) &&
            prev.detailSampleData != cur.detailSampleData,
        builder: (context, state) {
          if (state is DetailFetechingState) {
            return const Center(
                child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 252, 113, 49)));
          } else if (state is DetailLoadedState) {
            return Center(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.detailSampleData!.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(state.detailSampleData!.body,
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Error loading data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // left
        SizedBox(
          width: 350,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              Image.asset("assets/images/13028129.jpg").image,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "tyeom",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(300, 50)),
                            child: const Text(
                              'Edit profile',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 5),
                    Text(
                      '30',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text('followers'),
                    SizedBox(width: 5),
                    Text('·'),
                    SizedBox(width: 5),
                    Text(
                      '9',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text('following'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _line(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.deepPurple[300],
                      height: 120,
                    )),
                const SizedBox(
                  height: 20,
                ),
                _line(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.deepPurple[300],
                      height: 120,
                    )),
              ],
            ),
          ),
        ),

        // right
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(Routes.subscriptionKeyInfoRoute),
                          child: const Text(
                            'Get SubscriptionKey',
                            style: TextStyle(fontSize: 14),
                          )),
                      TextButton(
                          onPressed: () => context
                              .read<SampleDataBloc>()
                              .add(GetSampleDataListEvent()),
                          child: const Text(
                            'Get Sample data',
                            style: TextStyle(fontSize: 14),
                          )),
                      TextButton(
                          onPressed: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested());
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.splashRoute);
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(fontSize: 14),
                          )),
                    ],
                  ),
                ),
              ),
              _listViewWidget(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.hub),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Main Home",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
        ],
      ),
      body: _bodyWidget(),
    );
  }
}
