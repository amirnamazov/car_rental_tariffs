import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tariff_app/components/error_state.dart';
import 'package:tariff_app/components/loading.dart';
import 'package:tariff_app/components/no_interner_state.dart';
import 'package:tariff_app/pages/tariffs/components/tariffs_list_item.dart';
import 'package:tariff_app/pages/tariffs/cubit/tariffs_cubit.dart';
import 'package:tariff_app/services/request.dart';
import '../../model/common_state.dart';

class TariffsPage extends StatefulWidget {
  @override
  _TariffsPageState createState() => _TariffsPageState();
}

class _TariffsPageState extends State<TariffsPage>{

  TariffsCubit? tariffsCubit;
  var currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tariffsCubit = BlocProvider.of<TariffsCubit>(context)..getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(230, 230, 230, 1),
        appBar: AppBar(
          title: Text("Тарифы"),
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {  },
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            tariffsCubit!.getData();
            return Future.delayed(Duration(seconds: 1));
          },
          child: buildView(),
        )
    );
  }

  Widget buildView() {
    return BlocBuilder<TariffsCubit, CommonState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return LoadingPage();
        } else if (state is ContentState) {
          return buildContent();
        } else if (state is ErrorState) {
          return ErrorPage();
        } else if (state is InternetErrorState) {
          return NoInternetPage();
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 170,
            viewportFraction: 0.4,
            enableInfiniteScroll: false,
            onPageChanged: (n, reason) {
              setState(() {
                currentPage = n;
              });
            },
          ),
          items: tariffsCubit!.tariffs.map((tariff) {
            return Builder(
              builder: (BuildContext context) {
                return CachedNetworkImage(
                  imageUrl: RequestClient.baseUrl + tariff.car!.picturecardurl_small!,
                  imageBuilder: (context, imageProvider) => Opacity(
                    opacity: currentPage == tariffsCubit!.tariffs.indexOf(tariff) ? 1 : 0.6,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      padding: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Text(tariff.car!.models!, textAlign: TextAlign.center,),
                    ),
                  ),
                  placeholder: (context, url) => LoadingPage(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              },
            );
          }).toList(),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 3,
          color: Colors.black.withOpacity(0.1),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
            children: tariffsCubit!.tariffs[currentPage].rate.map((rate) =>
                Column(
                  children: [
                    SizedBox(height: 10),
                    TariffsListItem(rateModel: rate),
                  ],
                )
            ).toList(),
          ),
        ),
      ],
    );
  }
}