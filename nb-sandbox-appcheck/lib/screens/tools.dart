import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart';
import 'package:sbarsmartbrainapp/supps/wp_api.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../supps/constants.dart';

class Briefcase extends StatelessWidget {
  Briefcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // PatientEducationCard(),
                  LabValuesCard(),
                  // Blog Tile
                  // if (!UniversalPlatform.isWeb)
                  ListTile(
                    onTap: () {
                      launch('https://nursebrain.com/blog');
                    },
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.rss,
                        color: kDarkSky,
                      ),
                    ),
                    title: Text(
                      'Nursing Articles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kMidNightSkyBlend,
                      ),
                    ),
                    tileColor: kDawnSky,
                    selectedTileColor: Colors.blue,
                  ),
                  Container(
                    height: 300,
                    child: FutureBuilder(
                      future: getData(), //api call
                      builder: (context, snapshot) {
                        // print(snapshot.data.length);
                        if (snapshot.hasData) {
                          var data = (snapshot.data as List).toList();
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                Map wpPost = data[index];
                                var imgUrl = wpPost["_embedded"]
                                    ["wp:featuredmedia"][0]["source_url"];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                launch(wpPost["link"] +
                                                    blogPostUTM);
                                              },
                                              child: Image.network(imgUrl)),
                                          //remove html tags
                                          GestureDetector(
                                            onTap: () {
                                              launch(
                                                  wpPost["link"] + blogPostUTM);
                                            },
                                            child: Text(
                                              parse(wpPost["title"]["rendered"])
                                                  .documentElement!
                                                  .text,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: kDarkSky,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }
                        return Text('\nfetching latest articles...');
                      },
                    ),
                  ),
                  AppInfoCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const appDesc =
    'The NurseBrain App is a an organization app for Nurses and Nursing Students to record and share pertinent information, practice safely and improve patient outcomes and satisfaction using the latest evidence based research.';
const contactLink =
    'https://nursebrain.com/contact?utm_source=nursebrain_briefcase&utm_medium=text_link&utm_campaign=in_app_cta&utm_content=contact_link';
const homeLink =
    'https://nursebrain.com?utm_source=nursebrain_briefcase&utm_medium=text_link&utm_campaign=in_app_cta&utm_content=home_page_link';
const blogLink =
    'https://nursebrain.com/blog?utm_source=nursebrain_briefcase&utm_medium=text_link&utm_campaign=in_app_cta&utm_content=blog_link';
const blogPostUTM =
    '?utm_source=nursebrain_briefcase&utm_medium=text_link&utm_campaign=in_app_cta&utm_content=nursing_articles_link';

class AppInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              // Contact us
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: kDawnSky, elevation: 8.0),
                        onPressed: () {
                          launch(contactLink);
                        },
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Review, Share
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    // Review app
                    if (!UniversalPlatform.isWeb)
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[200]),
                          onPressed: () {
                            UniversalPlatform.isIOS
                                ? launch(
                                    'https://apps.apple.com/us/app/nursebrain/id1528871626')
                                : launch(
                                    'https://play.google.com/store/apps/details?id=samucreates.sbarsmartbrainapp');
                          },
                          icon: Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.yellow,
                          ),
                          label: Text(
                            'Write a 5 Star Review!',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    if (!UniversalPlatform.isWeb) SizedBox(width: 8.0),
                    // Share button
                    Expanded(
                      child: ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blue[200]),
                        onPressed: () {
                          _shareApp(context);
                        },
                        icon: Icon(
                          FontAwesomeIcons.solidShareSquare,
                          color: kDarkSky,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Tell a Friend!',
                            style: TextStyle(
                              color: kDarkSky,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Please like and follow us:',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Container(
                height: 150,
                child: Card(
                  shadowColor: kMidNightSkyBlend,
                  color: Colors.grey[200],
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      // 2 centered items/links in first row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[200]),
                            onPressed: () {
                              launch('https://instagram.com/mynursebrain');
                            },
                            icon: Icon(FontAwesomeIcons.instagram),
                            label: Text(
                              '@mynursebrain',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[200]),
                            onPressed: () {
                              launch('https://www.twitter.com/mynursebrain');
                            },
                            icon: Icon(FontAwesomeIcons.twitter),
                            label: Text(
                              '@mynursebrain',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 2 centered items/links in second row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[200]),
                            onPressed: () {
                              launch('https://www.facebook.com/mynursebrain/');
                            },
                            icon: Icon(FontAwesomeIcons.facebook),
                            label: Text(
                              'mynursebrain',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[200]),
                            onPressed: () {
                              launch('https://nursebrain.com/info');
                            },
                            icon: Icon(FontAwesomeIcons.info),
                            label: Text(
                              'Share Info Sheet',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabValuesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Card(
          shadowColor: kMidNightSkyBlend,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Lab Reference Values',
                        style: kBriefcaseTitle,
                      )),
                  collapsed: Text(
                    'Expand to view the most common lab ranges',
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'The values below are for educational purposes only. Always consult with your medical facility for their approved lab ranges.',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SingleChildScrollView(
                        padding: EdgeInsets.all(8.0),
                        child: DataTable(
                          columnSpacing: 10,
                          dataRowHeight: 90,
                          columns: [
                            DataColumn(
                              label: Container(
                                child: Text('Name'),
                              ),
                            ),
                            DataColumn(
                              label: Text('Normal Range'),
                            ),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Alanine aminotransferase (ALT)')),
                                DataCell(Text('7-55 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Albumin')),
                                DataCell(Text(
                                    '3.5–5 g/dL (adults), 3.4–4.2 g/dL (children)')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Alkaline phosphatase (ALP)')),
                                DataCell(Text('50-100 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Ammonia')),
                                DataCell(Text('15–45 mcg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Amylase')),
                                DataCell(Text('27–131 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Aspartate aminotransferase (AST)')),
                                DataCell(Text('8-48 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Bilirubin')),
                                DataCell(Text('0.1-1.2 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Blood urea nitrogen (BUN)')),
                                DataCell(Text('8–23 mg/dL ')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Calcium, ionized')),
                                DataCell(Text('4.6–5.1 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Calcium, total serum')),
                                DataCell(Text('8.5-10.2 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Carbon dioxide (CO2)')),
                                DataCell(Text('23–29 mEq/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Chloride (Cl)')),
                                DataCell(Text('95–105 mEq/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('C-reactive protein (CRP)')),
                                DataCell(Text('0.08–3.1 mg/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Creatinine kinase (CK)')),
                                DataCell(Text('40–150 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Creatinine, serum (SCr)')),
                                DataCell(Text(
                                    '0.6–1.3 mg/dL (adults), 0.2–0.7 mg/dL (children)')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Creatinine (clearance) (CrCl)')),
                                DataCell(Text('75–125 mL/minute/1.73 m\u00B2')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Ferritin')),
                                DataCell(Text('15–200 ng/mL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Glucose, serum')),
                                DataCell(Text('70–110 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hemoglobin A1C ')),
                                DataCell(Text('4%–7%')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Lactate dehydrogenase (LDH)')),
                                DataCell(Text('100–200 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Lipase')),
                                DataCell(Text('31–186 U/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Magnesium')),
                                DataCell(Text('1.5-2 mEq/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Osmolality, serum')),
                                DataCell(Text('275–295 mOsm/kg')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Phosphorus')),
                                DataCell(Text(
                                    '3.0-4.5 mg/dL (adults), 4.5-6.5 mg/dL (children)')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Potassium')),
                                DataCell(Text('3.5–5.0 mEq/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Prealbumin')),
                                DataCell(Text('19.5–35.8 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Sodium')),
                                DataCell(Text('136–142 mEq/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Uric acid, serum')),
                                DataCell(Text('4–8 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hematocrit (Hct)')),
                                DataCell(
                                    Text('42%–50% (men), 36%–45% (women)')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Hemoglobin (Hgb)')),
                                DataCell(Text(
                                    '14–18 g/dL (men), 12–16 g/dL (women)')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'International normalized ratio (INR)')),
                                DataCell(Text('0.9-1.2')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Mean corpuscular hemoglobin(MCH)')),
                                DataCell(Text('26–34 pg/cell')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Mean corpuscular hemoglobin concentration (MCHC)')),
                                DataCell(Text('33–37 g/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Mean corpuscular volume (MCV)')),
                                DataCell(Text('80–100 fL/cell')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(
                                    Text('Partial thromboplastin time (PTT)')),
                                DataCell(Text('60-70 seconds')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Platelet count (Plt)')),
                                DataCell(
                                    Text('150,000–450,000 cells/mm\u00B3')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Prothrombin time (PT)')),
                                DataCell(Text('11-13.5 seconds')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Red blood cell count (RBC)')),
                                DataCell(Text(
                                    '4.5–5.9 × 106 cells/mm\u00B3 (men), 4.1–5.1 × 106 cells/mm\u00B3 (women)')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Reticulocyte percent of RBC')),
                                DataCell(Text('0.5%–1.5%')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Cholesterol, total (TC)')),
                                DataCell(Text('< 200 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'High-density lipoprotein cholesterol (HDL)')),
                                DataCell(Text('≥ 60 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Low-density lipoprotein cholesterol (LDL)')),
                                DataCell(Text('< 100 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Triglycerides (TG)')),
                                DataCell(Text('< 150 mg/dL')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('pH: Venous, Arterial')),
                                DataCell(Text('7.35–7.45, 7.31–7.41')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Partial pressure of carbon dioxide (PCO2): Partial, Arterial')),
                                DataCell(Text('35–45 mm Hg, 40–52 mm Hg')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Partial pressure of oxygen (PO2): Partial, Arterial')),
                                DataCell(Text('80–100 mm Hg, 30–50 mm Hg')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Oxygen saturation (SaO2): Partial, Arterial')),
                                DataCell(Text('> 90%, 60%–75%')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Serum bicarbonate (HCO3): Partial, Arterial')),
                                DataCell(Text('22–26 mEq/L, 21–28 mEq/L')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('Specific gravity')),
                                DataCell(Text('1.010–1.025')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text(
                                    'Urine: leukocyte esterase, nitrite, protein, blood, ketones, bilirubin, glucose')),
                                DataCell(Text('Negative')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                DataCell(Text('White blood cell count (WBC)')),
                                DataCell(Text('4.5–10 × 103 cells/mm\u00B3')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _shareApp(BuildContext context) async {
  List _links = [
    'https://play.google.com/store/apps/details?id=samucreates.sbarsmartbrainapp',
    'https://apps.apple.com/us/app/nursebrain/id1528871626',
    'https://nursebrain.app'
  ];
  int? _type;
  if (UniversalPlatform.isWeb) {
    _type = 2;
  } else if (UniversalPlatform.isAndroid) {
    _type = 0;
  } else if (UniversalPlatform.isIOS) {
    _type = 1;
  }
  String message =
      'Checkout NurseBrain, the Nurse Workflow App I\'m using to organize my shift and give great handoff reports! ${_links[_type!]}';
  final box = context.findRenderObject() as RenderBox;
  Share.share(message,
      subject: 'My Nurse Workflow App',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

//Patient Education
/*class PatientEducationCard extends StatefulWidget {
  @override
  _PatientEducationCardState createState() => _PatientEducationCardState();
}

class _PatientEducationCardState extends State<PatientEducationCard> {
  String selectedValue;
  final PtDiagnosisDropDown _icdDropDownBloc = PtDiagnosisDropDown();
  String teachingJsonUrl =
      'https://connect.medlineplus.gov/service?mainSearchCriteria.v.cs=2.16.840.1.113883.6.90&mainSearchCriteria.v.dn=&informationRecipient.languageCode.c=en&knowledgeResponseType=application%2Fjson&mainSearchCriteria.v.c=';
  String teachingWebUrl =
      'https://connect.medlineplus.gov/application?mainSearchCriteria.v.cs=2.16.840.1.113883.6.90&mainSearchCriteria.v.dn=&informationRecipient.languageCode.c=en&mainSearchCriteria.v.c=';
  String title;
  String summary;
  var teachingData;
  var results;
  var icd;
  var medlineJsonUrl;
  var medlineWebUrl;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _icdDropDownBloc.loadBriefcaseDiags(),
        builder: (context, snapshot) {
          return ExpandableNotifier(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Card(
                shadowColor: kDarkSky,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[
                    ScrollOnExpand(
                      scrollOnExpand: true,
                      scrollOnCollapse: false,
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          tapBodyToCollapse: false,
                        ),
                        header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Patient Education',
                            style: kBriefcaseTitle,
                          ),
                        ),
                        collapsed: Text(
                          'Expand to search patient education topics',
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var _ in Iterable.generate(1))
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Use the searchbox below to search for patient education based on a specific diagnosis',
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            // ICD 10 Patient Education dropdown search widget
                            SearchableDropdown.single(
                              items: _icdDropDownBloc
                                  .diagnosisDropDownBriefcaseItems,
                              value: selectedValue,
                              hint: "Enter Diagnosis",
                              searchHint: "Type @ for most common Dx",
                              onChanged: (icdCode) {
                                setState(
                                  () {
                                    selectedValue = icdCode;
                                    selectedValue = null;
                                    print(icdCode);

                                    if (icdCode != null) {
                                      // next lines delete ICD description and remain with just the code
                                      String str = icdCode;
                                      // 1) split the string into a list of 2 strings
                                      var icdValue = str.split('--');
                                      // 2) assign variable to just the icd code
                                      icdCode = icdValue.last;
                                      // 3) add "." to icd code in preperation for json call
                                      icdCode = icdCode.replaceAllMapped(
                                          RegExp(r".{3}"),
                                          (match) => "${match.group(0)}.");
                                      icd = icdCode;
                                      medlineJsonUrl = '$teachingJsonUrl$icd';

                                      getTeaching();
                                      medlineWebUrl = '$teachingWebUrl$icd';
                                    }
                                  },
                                );
                              },
                              isExpanded: true,
                              onClear: () {
                                icd = null;
                              },
                            ),
                            // Get patient education button
                            Center(
                              child: FlatButton.icon(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.grey[200],
                                onPressed: () {
                                  if (icd != null &&
                                      title != null &&
                                      summary != null) {
                                    print(summary);
                                    launch(medlineWebUrl);
                                  } else if (icd != null &&
                                      (title == null || summary == null)) {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        duration: kRegularSnack,
                                        backgroundColor: kMidNightSkyBlend,
                                        content: Text(
                                          'Connecting to server. Please make sure that you have an internet connection and try again',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        duration: kShortSnack,
                                        backgroundColor: kMidNightSkyBlend,
                                        content: Text(
                                          'Please choose a Diagnosis',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.bookReader),
                                label: Text('Get Patient Education'),
                              ),
                            )
                          ],
                        ),
                        builder: (_, collapsed, expanded) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Expandable(
                              collapsed: collapsed,
                              expanded: expanded,
                              theme:
                                  const ExpandableThemeData(crossFadePoint: 0),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future getTeaching() async {
    NetworkHelper networkHelper = NetworkHelper(Uri.parse(medlineJsonUrl));
    var teachingData = await networkHelper.getData();
    title = teachingData['feed']['entry'][0]['title']['_value'];
    summary = teachingData['feed']['entry'][0]['summary']['_value'];
  }
}*/
