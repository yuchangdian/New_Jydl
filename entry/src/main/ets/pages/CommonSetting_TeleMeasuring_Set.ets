import router from '@ohos.router';
import display from '@ohos.display';

interface CommonSettingTeleMeasuringData {
  cycleDetection: string;
  primaryEnergyMode: string;
  frequencyDeadBand: string;
  acVoltageDeadBand: string;
  dcVoltageDeadBand: string;
  acCurrentDeadBand: string;
  powerDeadBand: string;
  powerFactorDeadBand: string;
}

function createDefaultCommonSettingTeleMeasuringData(): CommonSettingTeleMeasuringData {
  return {
    cycleDetection: '00.00',
    primaryEnergyMode: '一次值',
    frequencyDeadBand: '00.00',
    acVoltageDeadBand: '00.00',
    dcVoltageDeadBand: '00.00',
    acCurrentDeadBand: '00.00',
    powerDeadBand: '00.00',
    powerFactorDeadBand: '00.00'
  };
}

@Observed
class BottomActionState {
  defaultText: string = '默认值';
  submitText: string = '提交';
  closeText: string = '关闭';
  backText: string = '返回';
}

@Observed
class CommonSettingTeleMeasuringVM {
  noticeText: string = '';
  titleLeft: string = '定值管理';
  titleRight: string = '—整定遥测参数';
  actions: BottomActionState = new BottomActionState();
  timeText: string = '2024/12/30\n12:12:30';
}

class CommonSettingTeleMeasuringFontSize {
  notice: number = 18;
  title: number = 20;
  fieldLabel: number = 18;
  inputValue: number = 18;
  button: number = 18;
  timeText: number = 17;
  dialogTitle: number = 18;
  dialogBody: number = 18;
  titleMin: number = 14;
  noticeMin: number = 12;
  arrow: number = 11;
  timeLineHeight: number = 20;
}

@Entry
@Component
export struct CommonSetting_TeleMeasuring_Set {
  @State vm: CommonSettingTeleMeasuringVM = new CommonSettingTeleMeasuringVM();
  @State formData: CommonSettingTeleMeasuringData = createDefaultCommonSettingTeleMeasuringData();
  @State uiScale: number = 1;
  @State primaryEnergyOverlayVisible: boolean = false;
  @State feedbackDialogVisible: boolean = false;
  @State feedbackMessage: string = '';

  private readonly fontSize: CommonSettingTeleMeasuringFontSize = new CommonSettingTeleMeasuringFontSize();
  private readonly primaryEnergyOptions: string[] = ['一次值', '二次值'];

  private readonly pageMaxWidth: number = 1024;
  private readonly headerHeight: number = 80;
  private readonly footerHeight: number = 80;
  private readonly bodyRowHeight: number = 70;
  private readonly rowContentHeight: number = 40;
  private readonly rowSeparatorHeight: number = 20;
  private readonly rowTopMargin: number = 10;
  private readonly bodyWidth: number = 980;
  private readonly inputHeight: number = 40;
  private readonly inputWidth: number = 90;
  private readonly comboWidth: number = 110;
  private readonly bottomButtonRadius: number = 12;
  private readonly fieldBorderColor: string = '#B8B8B8';
  private readonly fieldBackgroundColor: string = '#FFFFFF';
  private readonly separatorColor: string = '#B8B8B8';
  private readonly overlayCardWidth: number = 280;
  private readonly overlayCardRadius: number = 10;

  private s(v: number): number {
    return Math.round(v * this.uiScale);
  }

  aboutToAppear(): void {
    try {
      let d = display.getDefaultDisplaySync();
      let sx = d.width / 1024;
      let sy = d.height / 600;
      let scale = Math.min(sx, sy);
      this.uiScale = scale > 0 ? scale : 1;
    } catch (error) {
      this.uiScale = 1;
    }
  }

  private resetDefaults(): void {
    this.formData = createDefaultCommonSettingTeleMeasuringData();
  }

  private submitCurrentData(): void {
    this.feedbackMessage = '提交成功';
    this.feedbackDialogVisible = true;
  }

  private closeFeedback(): void {
    this.feedbackDialogVisible = false;
    this.feedbackMessage = '';
  }

  private openPrimaryEnergyOverlay(): void {
    this.primaryEnergyOverlayVisible = true;
  }

  private closePrimaryEnergyOverlay(): void {
    this.primaryEnergyOverlayVisible = false;
  }

  private applyPrimaryEnergyMode(value: string): void {
    this.formData.primaryEnergyMode = value;
    this.closePrimaryEnergyOverlay();
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Column() {
          this.HeaderBar();
          this.BodyArea();
          this.BottomBar();
        }
        .width('100%')
        .height('100%')
        .constraintSize({ maxWidth: this.s(this.pageMaxWidth) })
        .backgroundColor('#FFFFFF');
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#FFFFFF');

      if (this.primaryEnergyOverlayVisible) {
        this.PrimaryEnergyOverlay();
      }

      if (this.feedbackDialogVisible) {
        this.FeedbackOverlay();
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF');
  }

  @Builder
  HeaderBar() {
    Row() {
      Text(this.vm.noticeText)
        .layoutWeight(8)
        .minFontSize(this.s(this.fontSize.noticeMin))
        .maxLines(1)
        .fontSize(this.s(this.fontSize.notice))
        .fontColor('#EF2929')
        .fontFamily('STKaiti')
        .textAlign(TextAlign.Start)
        .padding({ left: this.s(10) });

      Text(this.vm.titleLeft)
        .layoutWeight(3)
        .minFontSize(this.s(this.fontSize.titleMin))
        .fontSize(this.s(this.fontSize.title))
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .fontFamily('sans-serif-condensed')
        .textAlign(TextAlign.End);

      Text(this.vm.titleRight)
        .layoutWeight(8)
        .minFontSize(this.s(this.fontSize.titleMin))
        .fontSize(this.s(this.fontSize.title))
        .fontColor('#000000')
        .fontFamily('STKaiti')
        .textAlign(TextAlign.Start);

      Button() {
        Image($r('app.media.return'))
          .width(this.s(37))
          .height(this.s(40));
      }
      .layoutWeight(2)
      .height(this.s(60))
      .padding(0)
      .backgroundColor('#D3D3D3')
      .border({ width: 0 })
      .borderRadius(this.s(this.bottomButtonRadius))
      .onClick(() => {
        router.back();
      });

      Button() {
        Image($r('app.media.close'))
          .width(this.s(32))
          .height(this.s(40));
      }
      .layoutWeight(2)
      .height(this.s(60))
      .padding(0)
      .backgroundColor('#D3D3D3')
      .border({ width: 0 })
      .borderRadius(this.s(this.bottomButtonRadius))
      .onClick(() => {
        router.back();
      });
    }
    .width('100%')
    .height(this.s(this.headerHeight))
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#D3D3D3');
  }

  @Builder
  BodyArea() {
    Column() {
      this.CycleDetectionRow();
      this.FrequencyAndAcVoltageRow();
      this.DcVoltageAndAcCurrentRow();
      this.PowerAndPowerFactorRow();
      Blank().layoutWeight(1);
    }
    .layoutWeight(1)
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF');
  }

  @Builder
  CycleDetectionRow() {
    Column() {
      Row() {
        Blank().width(this.s(40));
        this.FieldLabel('遥测变化检测周期', 210);
        this.InputField(this.formData.cycleDetection, (value: string) => {
          this.formData.cycleDetection = value;
        });
        this.UnitLabel('S', 20);
        Blank().width(this.s(150));
        this.FieldLabel('电度量上送值:', 160);
        this.ComboField(this.formData.primaryEnergyMode, this.comboWidth, () => {
          this.openPrimaryEnergyOverlay();
        });
        Blank().width(this.s(200));
      }
      .width(this.s(this.bodyWidth))
      .height(this.s(this.rowContentHeight))
      .margin({ top: this.s(this.rowTopMargin) })
      .alignItems(VerticalAlign.Center);

      this.RowSeparator();
    }
    .width(this.s(this.bodyWidth))
    .height(this.s(this.bodyRowHeight));
  }

  @Builder
  FrequencyAndAcVoltageRow() {
    Column() {
      Row() {
        Blank().width(this.s(40));
        this.FieldLabel('频率死区:', 110);
        this.InputField(this.formData.frequencyDeadBand, (value: string) => {
          this.formData.frequencyDeadBand = value;
        });
        this.UnitLabel('%', 20);
        Blank().width(this.s(250));
        this.FieldLabel('交流电压死区:', 160);
        this.InputField(this.formData.acVoltageDeadBand, (value: string) => {
          this.formData.acVoltageDeadBand = value;
        });
        this.UnitLabel('%', 20);
        Blank().width(this.s(200));
      }
      .width(this.s(this.bodyWidth))
      .height(this.s(this.rowContentHeight))
      .margin({ top: this.s(this.rowTopMargin) })
      .alignItems(VerticalAlign.Center);

      this.RowSeparator();
    }
    .width(this.s(this.bodyWidth))
    .height(this.s(this.bodyRowHeight));
  }

  @Builder
  DcVoltageAndAcCurrentRow() {
    Column() {
      Row() {
        Blank().width(this.s(40));
        this.FieldLabel('直流电压死区:', 160);
        this.InputField(this.formData.dcVoltageDeadBand, (value: string) => {
          this.formData.dcVoltageDeadBand = value;
        });
        this.UnitLabel('%', 20);
        Blank().width(this.s(200));
        this.FieldLabel('交流电流死区:', 160);
        this.InputField(this.formData.acCurrentDeadBand, (value: string) => {
          this.formData.acCurrentDeadBand = value;
        });
        this.UnitLabel('%', 20);
        Blank().width(this.s(200));
      }
      .width(this.s(this.bodyWidth))
      .height(this.s(this.rowContentHeight))
      .margin({ top: this.s(this.rowTopMargin) })
      .alignItems(VerticalAlign.Center);

      this.RowSeparator();
    }
    .width(this.s(this.bodyWidth))
    .height(this.s(this.bodyRowHeight));
  }

  @Builder
  PowerAndPowerFactorRow() {
    Column() {
      Row() {
        Blank().width(this.s(40));
        this.FieldLabel('功率死区:', 110);
        this.InputField(this.formData.powerDeadBand, (value: string) => {
          this.formData.powerDeadBand = value;
        });
        this.UnitLabel('%', 20);
        Blank().width(this.s(250));
        this.FieldLabel('功率因数死区:', 160);
        this.InputField(this.formData.powerFactorDeadBand, (value: string) => {
          this.formData.powerFactorDeadBand = value;
        });
        this.UnitLabel('%', 20);
        Blank().width(this.s(200));
      }
      .width(this.s(this.bodyWidth))
      .height(this.s(this.rowContentHeight))
      .margin({ top: this.s(this.rowTopMargin) })
      .alignItems(VerticalAlign.Center);

      this.RowSeparator();
    }
    .width(this.s(this.bodyWidth))
    .height(this.s(this.bodyRowHeight));
  }

  @Builder
  FieldLabel(text: string, width: number) {
    Text(text)
      .width(this.s(width))
      .fontSize(this.s(this.fontSize.fieldLabel))
      .fontColor('#000000')
      .textAlign(TextAlign.Start);
  }

  @Builder
  UnitLabel(text: string, width: number) {
    Text(text)
      .width(this.s(width))
      .fontSize(this.s(this.fontSize.fieldLabel))
      .fontColor('#000000')
      .textAlign(TextAlign.Center);
  }

  @Builder
  InputField(value: string, onChangeEvent: (value: string) => void) {
    Row() {
      TextInput({ text: value, placeholder: '' })
        .layoutWeight(1)
        .height('100%')
        .fontSize(this.s(this.fontSize.inputValue))
        .fontColor('#111111')
        .backgroundColor(this.fieldBackgroundColor)
        .border({ width: 0 })
        .padding({ left: this.s(6), right: this.s(6), top: 0, bottom: 0 })
        .textAlign(TextAlign.Start)
        .onChange((text: string) => {
          onChangeEvent(text);
        });
    }
    .width(this.s(this.inputWidth))
    .height(this.s(this.inputHeight))
    .backgroundColor(this.fieldBackgroundColor)
    .border({ width: 1, color: this.fieldBorderColor })
    .borderRadius(this.s(this.bottomButtonRadius))
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  ComboField(value: string, width: number, onClickEvent: () => void) {
    Row() {
      Text(value)
        .layoutWeight(1)
        .fontSize(this.s(this.fontSize.inputValue))
        .fontColor('#111111')
        .maxLines(1)
        .textAlign(TextAlign.Start);

      Text('▾')
        .width(this.s(14))
        .fontSize(this.s(this.fontSize.arrow))
        .fontColor('#111111')
        .textAlign(TextAlign.Center)
        .margin({ left: this.s(4) });
    }
    .width(this.s(width))
    .height(this.s(this.inputHeight))
    .padding({ left: this.s(6), right: this.s(4) })
    .backgroundColor(this.fieldBackgroundColor)
    .border({ width: 1, color: this.fieldBorderColor })
    .borderRadius(this.s(this.bottomButtonRadius))
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      onClickEvent();
    });
  }

  @Builder
  RowSeparator() {
    Row() {
      Divider()
        .strokeWidth(this.s(2))
        .color(this.separatorColor)
        .width('100%');
    }
    .width(this.s(this.bodyWidth))
    .height(this.s(this.rowSeparatorHeight))
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  PrimaryEnergyOverlay() {
    Stack() {
      Row() {
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#55000000')
      .onClick(() => {
        this.closePrimaryEnergyOverlay();
      });

      Column() {
        Text('电度量上送值')
          .width('100%')
          .fontSize(this.s(this.fontSize.dialogTitle))
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .fontFamily('STKaiti')
          .textAlign(TextAlign.Center)
          .margin({ bottom: this.s(10) });

        ForEach(this.primaryEnergyOptions, (option: string) => {
          Button() {
            Text(option)
              .fontSize(this.s(this.fontSize.dialogBody))
              .fontColor('#000000')
              .fontFamily('STKaiti');
          }
          .width('100%')
          .height(this.s(42))
          .margin({ bottom: this.s(6) })
          .backgroundColor(option === this.formData.primaryEnergyMode ? '#D9E9F8' : '#FFFFFF')
          .border({ width: 1, color: option === this.formData.primaryEnergyMode ? '#7A9CC0' : '#BEBEBE' })
          .borderRadius(this.s(6))
          .onClick(() => {
            this.applyPrimaryEnergyMode(option);
          });
        }, (option: string) => option)

        Button('取消')
          .width('100%')
          .height(this.s(40))
          .margin({ top: this.s(4) })
          .fontSize(this.s(this.fontSize.dialogBody))
          .fontColor('#000000')
          .fontFamily('STKaiti')
          .backgroundColor('#E5E5E5')
          .border({ width: 0 })
          .borderRadius(this.s(6))
          .onClick(() => {
            this.closePrimaryEnergyOverlay();
          });
      }
      .width(this.s(this.overlayCardWidth))
      .padding({ left: this.s(14), right: this.s(14), top: this.s(14), bottom: this.s(14) })
      .backgroundColor('#F7F7F7')
      .border({ width: 1, color: '#D2D2D2' })
      .borderRadius(this.s(this.overlayCardRadius));
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  FeedbackOverlay() {
    Stack() {
      Row() {
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#55000000')
      .onClick(() => {
        this.closeFeedback();
      });

      Column() {
        Text('提示')
          .width('100%')
          .fontSize(this.s(this.fontSize.dialogTitle))
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .fontFamily('STKaiti')
          .textAlign(TextAlign.Center)
          .margin({ bottom: this.s(10) });

        Text(this.feedbackMessage)
          .width('100%')
          .fontSize(this.s(this.fontSize.dialogBody))
          .fontColor('#000000')
          .fontFamily('STKaiti')
          .textAlign(TextAlign.Center)
          .margin({ bottom: this.s(18) });

        Button('确定')
          .width('100%')
          .height(this.s(40))
          .fontSize(this.s(this.fontSize.dialogBody))
          .fontColor('#000000')
          .fontFamily('STKaiti')
          .backgroundColor('#E5E5E5')
          .border({ width: 0 })
          .borderRadius(this.s(8))
          .onClick(() => {
            this.closeFeedback();
          });
      }
      .width(this.s(280))
      .padding({ left: this.s(16), right: this.s(16), top: this.s(16), bottom: this.s(16) })
      .backgroundColor('#F7F7F7')
      .border({ width: 1, color: '#D2D2D2' })
      .borderRadius(this.s(this.overlayCardRadius));
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  BottomBar() {
    Row() {
      Blank().width(this.s(37));

      this.BottomActionButton(this.vm.actions.defaultText, () => {
        this.resetDefaults();
      });

      Blank().width(this.s(117));

      this.BottomActionButton(this.vm.actions.submitText, () => {
        this.submitCurrentData();
      });

      Blank().width(this.s(78));

      this.BottomActionButton(this.vm.actions.closeText, () => {
        router.back();
      });

      Blank().width(this.s(78));

      this.BottomActionButton(this.vm.actions.backText, () => {
        router.back();
      });

      Blank().width(this.s(97));

      Text(this.vm.timeText)
        .width(this.s(160))
        .height(this.s(60))
        .fontSize(this.s(this.fontSize.timeText))
        .fontColor('#000000')
        .fontFamily('STKaiti')
        .lineHeight(this.s(this.fontSize.timeLineHeight))
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .height(this.s(this.footerHeight))
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#D3D3D3');
  }

  @Builder
  BottomActionButton(text: string, onClickEvent: () => void) {
    Button(text)
      .width(this.s(110))
      .height(this.s(60))
      .fontSize(this.s(this.fontSize.button))
      .fontColor('#000000')
      .backgroundColor('#BEBEBE')
      .border({ width: 0 })
      .borderRadius(this.s(this.bottomButtonRadius))
      .padding(0)
      .onClick(() => {
        onClickEvent();
      });
  }
}