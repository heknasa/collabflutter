import 'package:flutter/material.dart';
import 'package:collabflutter/providers/theme_provider.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  int i = 0;  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: widget.width <= breakpoint ? widget.width : widget.width * 0.6,
        height: widget.height * 0.6,
        child: Stepper(
          currentStep: i,
          type: StepperType.horizontal,
          steps: [
            Step(
              title: Text('PRODUCT'),                                      
              isActive: i >= 0,
              state: i > 0 ? StepState.complete : StepState.disabled,
              content: SizedBox(
                height: widget.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product',
                      style: TextStyle(
                        fontSize: widget.width <= breakpoint ? headline4 * mobile : headline4,
                        fontWeight: bold
                      ),
                    ),
                    SizedBox(height: widget.height * 0.02),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Course Title',
                                style: TextStyle(
                                  fontSize: widget.width <= breakpoint ? headline6 * mobile : headline6,
                                )
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                      fontSize: widget.width <= breakpoint ? headline6 * mobile : headline6,
                                    )
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Belajar Digital Marketing lewat Instagram Paid Marketing Hacks',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: widget.width <= breakpoint ? headline6 * mobile : headline6,
                                        fontWeight: semibold
                                      )
                                    ),
                                  ),
                                ]                                                    
                              ),
                            ),                                                    
                          ]
                        ),
                        SizedBox(height: widget.height * 0.01),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Course Price',
                                style: TextStyle(
                                  fontSize: widget.width <= breakpoint ? headline6 * mobile : headline6,
                                )
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' : ',
                                    style: TextStyle(
                                      fontSize: widget.width <= breakpoint ? headline6 * mobile : headline6,
                                    )
                                  ),
                                  Flexible(
                                    child: Text(
                                      '30 K',
                                      style: TextStyle(
                                        fontSize: widget.width <= breakpoint ? headline6 * mobile : headline6,
                                        fontWeight: semibold
                                      )
                                    ),
                                  ),
                                ]                                                    
                              ),
                            ),                                                    
                          ]
                        ),
                      ],
                    ),                                        
                  ],
                ),
              ),
            ),
            Step(
              title: Text('PAYMENT'),
              content: Center(
                child: SizedBox(
                  height: widget.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment',
                        style: TextStyle(
                          fontSize: widget.width <= breakpoint ? headline4 * mobile : headline4,
                          fontWeight: bold
                        ),
                      ),
                      SizedBox(height: widget.height * 0.02),                                            
                      TextField(
                        controller: TextEditingController(),
                        maxLength: 50,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontWeight: bold,
                            fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1
                          ),
                          hintText: 'should be the same as your name in Zoom Meetings',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                            )
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                            )
                          ),
                          counter: SizedBox.shrink()
                        ),
                        style: TextStyle(
                          fontWeight: regular,
                          fontSize: widget.width <= breakpoint ? subtitle2 * mobile : subtitle2
                        ),
                      ),
                      SizedBox(height: widget.height * 0.01),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                          fontWeight: bold,
                          fontSize: widget.width <= breakpoint ? 2 * mobile : subtitle2
                        )
                      ),
                      Text(
                        'anggoraniwari@gmail.com',
                        style: TextStyle(
                          fontWeight: regular,
                          fontSize: widget.width <= breakpoint ? subtitle2 * mobile : subtitle2
                        )
                      ),
                    ],
                  ),
                )
              ),
              isActive: i >= 1,
              state: i > 1 ? StepState.complete : StepState.disabled
            ),
            Step(
              title: Text('CONFIRMATION'),
              content: Center(
                child: SizedBox(
                  height: widget.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirmation',
                        style: TextStyle(
                          fontSize: widget.width <= breakpoint ? headline5 * mobile : headline5,
                          fontWeight: bold
                        ),
                      ),
                      SizedBox(height: widget.height * 0.02),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                  )
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                      )
                                    ),
                                    Flexible(
                                      child: Text(
                                        'anggoraniwari@gmail.com',
                                        style: TextStyle(
                                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                          fontWeight: semibold
                                        )
                                      ),
                                    ),
                                  ]                                                    
                                ),
                              ),                                                    
                            ]
                          ),
                          SizedBox(height: widget.height * 0.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                  )
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                      )
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Muhammad Anggoran Iwari Dos Santos El Espana',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                          fontWeight: semibold
                                        )
                                      ),
                                    ),
                                  ]                                                    
                                ),
                              ),                                                    
                            ]
                          ),
                          SizedBox(height: widget.height * 0.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Course Title',
                                  style: TextStyle(
                                    fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                  )
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                      )
                                    ),
                                    Flexible(
                                      child: Text(
                                        'Belajar Digital Marketing lewat Instagram Paid Marketing Hacks',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                          fontWeight: semibold
                                        )
                                      ),
                                    ),
                                  ]                                                    
                                ),
                              ),                                                    
                            ]
                          ),
                          SizedBox(height: widget.height * 0.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Course Price',
                                  style: TextStyle(
                                    fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                  )
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ' : ',
                                      style: TextStyle(
                                        fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                      )
                                    ),
                                    Flexible(
                                      child: Text(
                                        '30 K',
                                        style: TextStyle(
                                          fontSize: widget.width <= breakpoint ? subtitle1 * mobile : subtitle1,
                                          fontWeight: semibold
                                        )
                                      ),
                                    ),
                                  ]                                                    
                                ),
                              ),                                                    
                            ]
                          ),
                        ],
                      ),
                      SizedBox(height: widget.height * 0.02),
                      Text(
                        '(note: mohon segera membayar demi mendapatkan akses)',
                        style: TextStyle(
                          fontSize: widget.width <= breakpoint ? subtitle2 * mobile : subtitle2,
                        ),
                      )
                    ],
                  ),
                )
              ),
              isActive: i >= 2,
              state: i > 2 ? StepState.complete : StepState.disabled
            ),
          ],
          onStepContinue: () {
            if (i == 2) {
              print('complete');
              Get.back();
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.width * 0.01)
                    ),
                    elevation: 10,
                    child: SizedBox.square(
                      dimension: widget.width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox.square(
                            dimension: widget.width * 0.1,
                            child: Lottie.asset('assets/lottiefiles/success.json')
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Thank you, please kindly check your inbox or spam :)',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(height: widget.height * 0.02),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('OKAY'),
                          ),
                        ],
                      )
                    ),
                  );
                }
              );
            } else {
              setState(() {
                i++;
              });
            }                                 
          },
          onStepCancel: () {
            if (i == 0) {
              Get.back();
            } else {
              setState(() {
                i--;
              });
            }
          },
          controlsBuilder: (context, controls) {
            return Row(
              children: [
                SizedBox(height: widget.height * 0.1),
                Expanded(
                  child: ElevatedButton(
                    onPressed: controls.onStepContinue,
                    child: Text(
                      i < 2 ? 'NEXT' : 'CONFIRM'
                    ),
                  ),
                ),
                SizedBox(width: widget.width * 0.01),
                Expanded(
                  child: TextButton(
                    onPressed: controls.onStepCancel,
                    child: Text(
                      i > 0 ? 'BACK' : 'CANCEL'
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )
    );
  }
}