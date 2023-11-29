import 'package:basic_architecture/Presentation/subscription_info/bloc/subscription_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubscriptionInfoView extends StatefulWidget {
  const SubscriptionInfoView({super.key});

  @override
  State<SubscriptionInfoView> createState() => _SubscriptionInfoViewState();
}

class _SubscriptionInfoViewState extends State<SubscriptionInfoView> {
  @override
  void initState() {
    super.initState();

    context.read<SubscriptionInfoBloc>().add(GetSubscriptionInfoEvent());
  }

  Widget _bodyWidget() {
    return BlocBuilder<SubscriptionInfoBloc, SubscriptionInfoState>(
      buildWhen: (prev, cur) => prev != cur,
      builder: (context, state) {
        if (state is EmptyDataState) {
          return const Text('No data.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        } else if (state is LoadingState) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 252, 113, 49)));
        } else if (state is LoadedState) {
          // 로드 완료 데이터
          final subscriptionKeyInfo = state.subscriptionKeyInfo;

          if (subscriptionKeyInfo == null) {
            return const Center(
              child: Text(
                  'There is no subscription information for your current login account.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            );
          }

          return Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.subscriptionKey} : ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subscriptionKeyInfo.key,
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.subscriptionType} : ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subscriptionKeyInfo.keyType,
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        '${AppLocalizations.of(context)!.subscriptionStartDT} : ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subscriptionKeyInfo.startDT.toString(),
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                        '${AppLocalizations.of(context)!.subscriptionEndDT} : ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subscriptionKeyInfo.endDT.toString(),
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    Text('${AppLocalizations.of(context)!.subscriptionMemo} : ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subscriptionKeyInfo.memo,
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Text('Error loading data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.subscriptionKeyInfo,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: _bodyWidget(),
    );
  }
}
