import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  Map<String, PreviewData> datas = {};

  List<String> informativeArticles = [
    "https://education.nationalgeographic.org/resource/resource-library-plastic-pollution",
    "https://www.theguardian.com/environment/plastic",
    "https://www.unep.org/",
    "https://www.worldbank.org/en/topic/climatechange",
    "https://www.treehugger.com/",
    "https://www.greenpeace.org/international/",
    "https://the.ethicalfashionforum.com/about-1",
    "https://www.fashionrevolution.org/",
    "https://www.futureoffood.ox.ac.uk/article/food-climate-research-network",
    "https://eatforum.org/eat-lancet-commission/",
    "https://techcrunch.com/",
    "https://trellis.net/",
    "https://350.org/",
    "https://www.sunrisemovement.org/",
    "https://www.epa.gov/climate-change",
    "https://www.wwf.org/",
    "https://www.ucsusa.org/",
    "https://www.edf.org/",
    "https://www.sierraclub.org/",
    "https://www.nature.org/",
    "https://www.greenpeace.org/usa/",
    "https://www.ucsusa.org/climate-change",
    "https://www.edf.org/climate-change",
    "https://www.sierraclub.org/climate",
    "https://www.nature.org/climate-change",
    "https://www.greenpeace.org/usa/climate-change",
    "https://www.ucsusa.org/clean-energy",
    "https://www.edf.org/clean-energy",
    "https://www.sierraclub.org/clean-energy",
    "https://www.nature.org/climate-change"
  ];

  @override
  void initState() {
    super.initState();
    informativeArticles.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: informativeArticles.length,
            itemBuilder: (context, index) => Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    key: ValueKey(informativeArticles[index]),
                    margin: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: LinkPreview(
                            enableAnimation: true,
                            onPreviewDataFetched: (data) => setState(() =>
                                datas = {
                                  ...datas,
                                  informativeArticles[index]: data
                                }),
                            previewData: datas[informativeArticles[index]],
                            text: informativeArticles[index],
                            width: double.infinity))))));
  }
}
