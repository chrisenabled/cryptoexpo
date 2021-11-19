import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:cryptoexpo/modules/models/country_model.dart';
import 'package:cryptoexpo/utils/ui/widgets.dart';
import 'package:flutter/material.dart';

class CountryList extends StatelessWidget {
  final List<CountryModel> countryModels;

  final Function(CountryModel) onPressed;

  const CountryList({
    Key? key,
    required this.countryModels,
    required this.onPressed
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlphabetScrollView(
        list: countryModels
            .map((country) => AlphaModel(country.countryDetails.alpha2Code!))
            .toList(),
        // isAlphabetsFiltered: false,
        alignment: LetterAlignment.right,
        itemExtent: 50,
        unselectedTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Theme.of(context).colorScheme.secondaryVariant,
            ),
        selectedTextStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
            decoration: TextDecoration.underline),
        overlayWidget: (value) => Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 50,
                  color: Colors.red,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // color: Theme.of(context).primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$value'.toUpperCase(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
        itemBuilder: (_, k, id) {
          CountryModel country = countryModels[k];
          return Container(
            key: Key('$id'),
            margin: const EdgeInsets.only(right: 35),
            child: ListTile(
              leading: circularImage(asset: country.asset, size: 20, package: 'country_icons'),
              title: Text(
                '${country.countryDetails.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${country.countryDetails.alpha2Code}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.bold)),
              trailing: Text('${country.countryDetails.dialCode}'),
              onTap: () {
                Navigator.pop(context);
                onPressed(country);
                },
              // trailing: Radio<bool>(
              //   value: false,
              //   groupValue: selectedCountryIndex != k,
              //   onChanged: (value) {
              //     // setState(() {
              //     //   selectedCountryIndex = k;
              //     // });
              //   },
              // ),
            ),
          );
        });
  }
}
