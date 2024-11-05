import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_mobile/settings/assets.dart';
import 'package:projeto_mobile/settings/color.dart';
import 'package:projeto_mobile/settings/fonts.dart';
import 'package:intl/intl.dart';

class NewTripPage extends StatefulWidget {
  const NewTripPage({super.key});

  @override
  State<NewTripPage> createState() => _NewTripPageState();
}

class _NewTripPageState extends State<NewTripPage> {
  final TextEditingController _departureDateController =
      TextEditingController();
  final TextEditingController _departureTimeController =
      TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _nomeTutorController = TextEditingController();
  final TextEditingController _especieController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _compController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();

  String? serviceSelected;

  Map<String, String> services = {
    "Hospedagem": AppAssets.hotelIcon,
    "Transporte": AppAssets.carIcon,
    "Petshop": AppAssets.cutIcon
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.menuTextColor,
        ),
        title: Text('Home',
            style: AppFonts.defaultLarger
                .copyWith(color: AppColors.menuTextColor)),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            // Ação para buscar passagens ou processar dados
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: AppColors.backgroundColor,
          ),
          child: Text('Adicionar Viagem',
              style: AppFonts.defaultRegular.copyWith(
                color: AppColors.menuTextColor,
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo para escolher a data de ida
              LayoutBuilder(builder: (context, constrains) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: constrains.maxWidth / 2 - 10,
                      child: TextFormField(
                        controller: _departureDateController,
                        decoration: InputDecoration(
                          labelText: 'Data ',
                          labelStyle: AppFonts.boldLarge
                              .copyWith(color: AppColors.textColor),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final pickedDate = await _selectDate(context);
                          if (pickedDate != null) {
                            setState(() {
                              _departureDateController.text = pickedDate;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: constrains.maxWidth / 2 - 10,
                      child: TextFormField(
                        controller: _departureTimeController,
                        decoration: InputDecoration(
                          labelText: 'Horário ',
                          labelStyle: AppFonts.boldLarge
                              .copyWith(color: AppColors.textColor),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final pickedTime = await _selectTime(
                              context); // Chama a função de seleção de hora
                          if (pickedTime != null) {
                            setState(() {
                              _departureDateController.text =
                                  pickedTime; // Atualiza com o horário formatado
                            });
                          }
                        },
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do Pet ',
                  labelStyle:
                      AppFonts.boldLarge.copyWith(color: AppColors.textColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nomeTutorController,
                decoration: InputDecoration(
                  labelText: 'Nome do Tutor ',
                  labelStyle:
                      AppFonts.boldLarge.copyWith(color: AppColors.textColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _especieController,
                decoration: InputDecoration(
                  labelText: 'Especíe ',
                  labelStyle:
                      AppFonts.boldLarge.copyWith(color: AppColors.textColor),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: services.entries
                    .map((x) => GestureDetector(
                          onTap: () => setState(() => serviceSelected = x.key),
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 60,
                            decoration: BoxDecoration(
                                color: serviceSelected == x.key
                                    ? AppColors.backgroundColor.withOpacity(0.6)
                                    : Colors.transparent,
                                border: serviceSelected == x.key
                                    ? Border.all(
                                        color: AppColors.backgroundColor)
                                    : null,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  x.value,
                                  color: serviceSelected == x.key
                                      ? AppColors.menuTextColor
                                      : AppColors.textColor,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(x.key,
                                    style: AppFonts.defaultaSmall.copyWith(
                                      color: serviceSelected == x.key
                                          ? AppColors.menuTextColor
                                          : AppColors.textColor,
                                    ))
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _cepController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  labelStyle:
                      AppFonts.boldLarge.copyWith(color: AppColors.textColor),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Endereço',
                  labelStyle:
                      AppFonts.boldLarge.copyWith(color: AppColors.greyColor),
                ),
                enabled: false,
              ),

              const SizedBox(
                height: 20,
              ),

              LayoutBuilder(builder: (context, contrains) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: contrains.maxWidth * 1 / 4 - 10,
                      child: TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Numero',
                          labelStyle: AppFonts.boldLarge
                              .copyWith(color: AppColors.textColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: contrains.maxWidth * 3 / 4 - 10,
                      child: TextFormField(
                        controller: _compController,
                        decoration: InputDecoration(
                          labelText: 'Complemento',
                          labelStyle: AppFonts.boldLarge
                              .copyWith(color: AppColors.textColor),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(
                height: 20,
              ),

              LayoutBuilder(builder: (context, contrains) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: contrains.maxWidth * 3 / 4 - 10,
                      child: TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(
                          labelText: 'Cidade',
                          labelStyle: AppFonts.boldLarge
                              .copyWith(color: AppColors.greyColor),
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: contrains.maxWidth * 1 / 4 - 10,
                      child: TextFormField(
                        controller: _ufController,
                        decoration: InputDecoration(
                          labelText: 'UF',
                          labelStyle: AppFonts.boldLarge
                              .copyWith(color: AppColors.greyColor),
                        ),
                        enabled: false,
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Função para selecionar data
  Future<String?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return '${picked.day}/${picked.month}/${picked.year}';
    }
    return null;
  }
}

Future<String?> _selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime != null) {
    // Formata o horário para o formato HH:mm
    final now = DateTime.now();
    final pickedDateTime = DateTime(
        now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
    final formattedTime = DateFormat('HH:mm').format(pickedDateTime);
    return formattedTime;
  }
  return null;
}
