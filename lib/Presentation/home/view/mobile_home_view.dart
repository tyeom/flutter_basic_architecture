import 'package:basic_architecture/Presentation/authentication/bloc/authentication_bloc.dart';
import 'package:basic_architecture/Presentation/component/placeholders.dart';
import 'package:basic_architecture/Presentation/home/bloc/sample_data_bloc.dart';
import 'package:basic_architecture/Presentation/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shimmer/shimmer.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
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
            (cur.status == DataLoadStatus.empty ||
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

                      // showFlexibleBottomSheet(
                      //   context: context,
                      //   builder: (innerContext, sc, bottomSheetOffset) =>
                      //       BlocProvider.value(
                      //     value: context.read<SampleDataBloc>(),
                      //     child: _buildBottomSheet(),
                      //   ),
                      // );
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<SampleDataBloc>(),
                          child: _buildBottomSheet(),
                        ),
                      );
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
            return const Text('Error loading data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
          }
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [
        // left
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          Image.asset("assets/images/13028129.jpg").image,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "tyeom",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "This is Flutter's basic architecture demo app.",
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)),
                    child: const Text(
                      'Edit profile',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 20,
                ),
                _line(),
                const SizedBox(
                  height: 20,
                ),
                _line(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),

        _listViewWidget(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SpeedDial(
              switchLabelPosition: true,
              icon: Icons.menu,
              activeIcon: Icons.close,
              spacing: 3,
              direction: SpeedDialDirection.down,
              children: [
                SpeedDialChild(
                    onTap: () => Navigator.of(context)
                        .pushNamed(Routes.subscriptionKeyInfoRoute),
                    label: 'Get SubscriptionKey'),
                SpeedDialChild(
                    onTap: () => context
                        .read<SampleDataBloc>()
                        .add(GetSampleDataListEvent()),
                    label: 'Get Sample data'),
                SpeedDialChild(
                    onTap: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested());
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.splashRoute);
                    },
                    label: 'Logout'),
              ],
            ),
            Expanded(
              child: Container(
                  alignment: Alignment.center, child: const Icon(Icons.hub)),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: _bodyWidget(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
