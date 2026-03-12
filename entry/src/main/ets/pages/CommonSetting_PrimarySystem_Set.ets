import router from '@ohos.router';
import display from '@ohos.display';

@Observed
class BottomActionState {
  defaultText: string = '默认值';
  submitText: string = '提交';
  backText: string = '返回';
}

@Observed
class CommonSettingPrimarySystemVM {
  noticeText: string = '';
  titleLeft: string = '定值管理';
  titleRight: string = '—整定一次系统参数';
  actions: BottomActionState = new BottomActionState();
  timeText: string = '2024/12/30\n12:12:30';
}

@Entry
@Component
export struct CommonSetting_PrimarySystem_Set {
  @State vm: CommonSettingPrimarySystemVM = new CommonSettingPrimarySystemVM();
  @State uiScale: number = 1;

  @State busPtPrimary: string = '10.0';
  @State busPtSecondary: string = '100';
  @State busZeroPtPrimary: string = '10.0';
  @State busZeroPtSecondary: string = '100';
  @State linePtPrimary: string = '10.0';
  @State linePtSecondary: string = '100';
  @State protectCtPrimary: string = '600';
  @State protectCtSecondary: string = '5';
  @State zeroCtPrimary: string = '120';
  @State zeroCtSecondary: string = '5';
  @State measureCtPrimary: string = '600';
  @State measureCtSecondary: string = '5';
  @State ratedPower: string = '1200';

  @State linePhase: string = 'A相';
  @State ctConnectionMode: string = '两相式';
  @State zeroCurrentMode: string = '外部';

  private readonly noticeFontSize: number = 16;
  private readonly titleLeftFontSize: number = 20;
  private readonly titleRightFontSize: number = 18;
  private readonly bodyFontSize: number = 16;
  private readonly rowHeight: number = 54;
  private readonly separatorSpace: number = 12;
  private readonly separatorStroke: number = 3;
  private readonly inputHeight: number = 35;
  private readonly inputWidth: number = 117;
  private readonly bottomButtonHeight: number = 55;
  private readonly pageMaxWidth: number = 1155;
  private readonly titleIconSize: number = 24;
  private readonly linePhaseBoxWidth: number = 96;
  private readonly modeBoxWidth: number = 100;
  private readonly separatorColor: string = '#9E9E9E';
  private readonly fieldBorderColor: string = '#B8B8B8';
  private readonly fieldBackgroundColor: string = '#FFFFFF';

  private readonly linePhaseOptions: string[] = ['A相', 'B相', 'C相', 'AB相', 'CA相', 'BC相', '三相'];
  private readonly ctConnectionOptions: string[] = ['两相式', '三相式'];
  private readonly zeroCurrentOptions: string[] = ['外部', '自产'];

  private s(v: number): number {
    return Math.round(v * this.uiScale);
  }

  aboutToAppear(): void {
    try {
      let d = display.getDefaultDisplaySync();
      let sx = d.width / 1024;
      let sy = d.height / 600;
      let val = Math.min(sx, sy);
      this.uiScale = val > 0 ? val : 1;
    } catch (e) {
      this.uiScale = 1;
    }
  }

  private getInputValue(fieldKey: string): string {
    switch (fieldKey) {
      case 'bus_pt_primary':
        return this.busPtPrimary;
      case 'bus_pt_secondary':
        return this.busPtSecondary;
      case 'bus_zero_pt_primary':
        return this.busZeroPtPrimary;
      case 'bus_zero_pt_secondary':
        return this.busZeroPtSecondary;
      case 'line_pt_primary':
        return this.linePtPrimary;
      case 'line_pt_secondary':
        return this.linePtSecondary;
      case 'protect_ct_primary':
        return this.protectCtPrimary;
      case 'protect_ct_secondary':
        return this.protectCtSecondary;
      case 'zero_ct_primary':
        return this.zeroCtPrimary;
      case 'zero_ct_secondary':
        return this.zeroCtSecondary;
      case 'measure_ct_primary':
        return this.measureCtPrimary;
      case 'measure_ct_secondary':
        return this.measureCtSecondary;
      case 'rated_power':
        return this.ratedPower;
      default:
        return '';
    }
  }

  private setInputValue(fieldKey: string, value: string): void {
    switch (fieldKey) {
      case 'bus_pt_primary':
        this.busPtPrimary = value;
        break;
      case 'bus_pt_secondary':
        this.busPtSecondary = value;
        break;
      case 'bus_zero_pt_primary':
        this.busZeroPtPrimary = value;
        break;
      case 'bus_zero_pt_secondary':
        this.busZeroPtSecondary = value;
        break;
      case 'line_pt_primary':
        this.linePtPrimary = value;
        break;
      case 'line_pt_secondary':
        this.linePtSecondary = value;
        break;
      case 'protect_ct_primary':
        this.protectCtPrimary = value;
        break;
      case 'protect_ct_secondary':
        this.protectCtSecondary = value;
        break;
      case 'zero_ct_primary':
        this.zeroCtPrimary = value;
        break;
      case 'zero_ct_secondary':
        this.zeroCtSecondary = value;
        break;
      case 'measure_ct_primary':
        this.measureCtPrimary = value;
        break;
      case 'measure_ct_secondary':
        this.measureCtSecondary = value;
        break;
      case 'rated_power':
        this.ratedPower = value;
        break;
      default:
        break;
    }
  }

  private getSelectValue(fieldKey: string): string {
    switch (fieldKey) {
      case 'line_phase':
        return this.linePhase;
      case 'ct_connection':
        return this.ctConnectionMode;
      case 'zero_current_mode':
        return this.zeroCurrentMode;
      default:
        return '';
    }
  }

  private setSelectValue(fieldKey: string, value: string): void {
    switch (fieldKey) {
      case 'line_phase':
        this.linePhase = value;
        break;
      case 'ct_connection':
        this.ctConnectionMode = value;
        break;
      case 'zero_current_mode':
        this.zeroCurrentMode = value;
        break;
      default:
        break;
    }
  }

  private getSelectOptions(fieldKey: string): string[] {
    switch (fieldKey) {
      case 'line_phase':
        return this.linePhaseOptions;
      case 'ct_connection':
        return this.ctConnectionOptions;
      case 'zero_current_mode':
        return this.zeroCurrentOptions;
      default:
        return [];
    }
  }

  private cycleSelectValue(fieldKey: string): void {
    let currentValue = this.getSelectValue(fieldKey);
    let options = this.getSelectOptions(fieldKey);
    let index = options.findIndex((item: string) => item === currentValue);
    if (options.length === 0) {
      return;
    }
    let nextIndex = index >= 0 && index < options.length - 1 ? index + 1 : 0;
    this.setSelectValue(fieldKey, options[nextIndex]);
  }

  private resetDefaults(): void {
    this.busPtPrimary = '10.0';
    this.busPtSecondary = '100';
    this.busZeroPtPrimary = '10.0';
    this.busZeroPtSecondary = '100';
    this.linePtPrimary = '10.0';
    this.linePtSecondary = '100';
    this.protectCtPrimary = '600';
    this.protectCtSecondary = '5';
    this.zeroCtPrimary = '120';
    this.zeroCtSecondary = '5';
    this.measureCtPrimary = '600';
    this.measureCtSecondary = '5';
    this.ratedPower = '1200';
    this.linePhase = this.linePhaseOptions[0];
    this.ctConnectionMode = this.ctConnectionOptions[0];
    this.zeroCurrentMode = this.zeroCurrentOptions[0];
  }

  build() {
    Column() {
      Column() {
        this.HeaderBar();

        Scroll() {
          Column() {
            this.StandardRatedRow('母线PT', 'bus_pt_primary', 'kV', 'bus_pt_secondary', 'V');
            this.SeparatorRow();
            this.StandardRatedRow('母线零序PT', 'bus_zero_pt_primary', 'kV', 'bus_zero_pt_secondary', 'V');
            this.SeparatorRow();
            this.LinePtRow();
            this.SeparatorRow();
            this.StandardRatedRow('保护CT', 'protect_ct_primary', 'A', 'protect_ct_secondary', 'A');
            this.SeparatorRow();
            this.StandardRatedRow('零序CT', 'zero_ct_primary', 'A', 'zero_ct_secondary', 'A');
            this.SeparatorRow();
            this.StandardRatedRow('测量CT', 'measure_ct_primary', 'A', 'measure_ct_secondary', 'A');
            this.SeparatorRow();
            this.ModeAndCapacityRow();
            Blank().height(this.s(200));
          }
          .width('100%')
          .constraintSize({ minHeight: this.s(700) });
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor('#FFFFFF');

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
  }

  @Builder
  HeaderBar() {
    Row() {
      Text(this.vm.noticeText)
        .layoutWeight(8)
        .minFontSize(12)
        .maxLines(1)
        .fontSize(this.s(this.noticeFontSize))
        .fontColor('#EF2929')
        .fontFamily('STKaiti')
        .textAlign(TextAlign.Center);

      Text(this.vm.titleLeft)
        .layoutWeight(3)
        .fontSize(this.s(this.titleLeftFontSize))
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .fontFamily('sans-serif-condensed')
        .textAlign(TextAlign.End);

      Text(this.vm.titleRight)
        .layoutWeight(8)
        .fontSize(this.s(this.titleRightFontSize))
        .fontColor('#000000')
        .fontFamily('STKaiti')
        .textAlign(TextAlign.Start);

      Button() {
        Image($r('app.media.return'))
          .width(this.s(37))
          .height(this.s(40));
      }
      .layoutWeight(2)
      .height(this.s(40))
      .padding(0)
      .backgroundColor('#D3D3D3')
      .border({ width: 0 })
      .borderRadius(0)
      .onClick(() => {
        router.back();
      });

      Button() {
        Image($r('app.media.close'))
          .width(this.s(32))
          .height(this.s(40));
      }
      .layoutWeight(2)
      .height(this.s(40))
      .padding(0)
      .backgroundColor('#D3D3D3')
      .border({ width: 0 })
      .borderRadius(0)
      .onClick(() => {
        router.back();
      });
    }
    .width('100%')
    .height(this.s(70))
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#D3D3D3');
  }

  @Builder
  SeparatorRow() {
    Row() {
      Divider()
        .strokeWidth(this.s(this.separatorStroke))
        .color(this.separatorColor)
        .width('100%');
    }
    .width('100%')
    .height(this.s(this.separatorSpace))
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  StandardRatedRow(title: string, primaryField: string, primaryUnit: string, secondaryField: string, secondaryUnit: string) {
    Row() {
      this.TitleBlock(title, 10);
      Blank().layoutWeight(3);
      this.RatedFieldBlock('一次额定值:', primaryField, primaryUnit, 13);
      Blank().layoutWeight(3);
      this.RatedFieldBlock('二次额定值:', secondaryField, secondaryUnit, 13);
      Blank().layoutWeight(10);
    }
    .width('100%')
    .height(this.s(this.rowHeight))
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  LinePtRow() {
    Row() {
      this.TitleBlock('线路PT', 10);
      Blank().layoutWeight(3);
      this.RatedFieldBlock('一次额定值:', 'line_pt_primary', 'kV', 13);
      Blank().layoutWeight(3);
      this.RatedFieldBlock('二次额定值:', 'line_pt_secondary', 'V', 13);
      Blank().layoutWeight(3);
      this.SelectFieldBlock('相别:', 'line_phase', 7, this.s(this.linePhaseBoxWidth));
    }
    .width('100%')
    .height(this.s(this.rowHeight))
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  ModeAndCapacityRow() {
    Row() {
      this.SelectFieldBlock('CT接线方式:', 'ct_connection', 70, this.s(this.modeBoxWidth));
      Blank().layoutWeight(9);
      this.SelectFieldBlock('零序电流采集模式:', 'zero_current_mode', 100, this.s(this.modeBoxWidth));
      Blank().layoutWeight(20);
      this.CapacityFieldBlock();
    }
    .width('100%')
    .height(this.s(this.rowHeight))
    .padding({ right: this.s(50) })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  TitleBlock(title: string, blockWeight: number) {
    Row() {
      Image($r('app.media.right_black'))
        .width(this.s(this.titleIconSize))
        .height(this.s(this.titleIconSize))
        .margin({ right: this.s(6) });

      Text(title)
        .layoutWeight(1)
        .fontSize(this.s(this.bodyFontSize))
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .maxLines(1)
        .textAlign(TextAlign.Start);
    }
    .layoutWeight(blockWeight)
    .height('100%')
    .padding({ left: this.s(6), right: this.s(6) })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  RatedFieldBlock(label: string, fieldKey: string, unit: string, blockWeight: number) {
    Row() {
      Text(label)
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .maxLines(1)
        .margin({ right: this.s(8) });

      this.InputField(fieldKey);

      Text(unit)
        .width(this.s(28))
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .textAlign(TextAlign.Center)
        .margin({ left: this.s(6) });
    }
    .layoutWeight(blockWeight)
    .height('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  InputField(fieldKey: string) {
    Row() {
      TextInput({ text: this.getInputValue(fieldKey), placeholder: '' })
        .layoutWeight(1)
        .height('100%')
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#111111')
        .fontFamily('Ubuntu')
        .backgroundColor(this.fieldBackgroundColor)
        .border({ width: 0 })
        .padding({ left: this.s(6), right: this.s(6), top: 0, bottom: 0 })
        .textAlign(TextAlign.Start)
        .onChange((value: string) => {
          this.setInputValue(fieldKey, value);
        });
    }
    .width(this.s(this.inputWidth))
    .height(this.s(this.inputHeight))
    .backgroundColor(this.fieldBackgroundColor)
    .border({ width: 1, color: this.fieldBorderColor })
    .borderRadius(0)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  SelectFieldBlock(label: string, fieldKey: string, blockWeight: number, boxWidth: number) {
    Row() {
      Text(label)
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .maxLines(1)
        .margin({ right: this.s(6) });

      this.ComboField(fieldKey, boxWidth);
    }
    .layoutWeight(blockWeight)
    .height('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  ComboField(fieldKey: string, boxWidth: number) {
    Row() {
      Text(this.getSelectValue(fieldKey))
        .layoutWeight(1)
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#111111')
        .fontFamily('Ubuntu')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })
        .textAlign(TextAlign.Start);

      Text('▼')
        .width(this.s(14))
        .fontSize(this.s(11))
        .fontColor('#111111')
        .textAlign(TextAlign.Center)
        .margin({ left: this.s(4) });
    }
    .width(boxWidth)
    .height(this.s(this.inputHeight))
    .padding({ left: this.s(6), right: this.s(4) })
    .backgroundColor(this.fieldBackgroundColor)
    .border({ width: 1, color: this.fieldBorderColor })
    .borderRadius(0)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.cycleSelectValue(fieldKey);
    });
  }

  @Builder
  CapacityFieldBlock() {
    Row() {
      Text('线路额定容量')
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .margin({ right: this.s(8) });

      this.InputField('rated_power');

      Text('kVA')
        .width(this.s(38))
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .textAlign(TextAlign.Center)
        .margin({ left: this.s(6) });
    }
    .layoutWeight(100)
    .height('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BottomBar() {
    Row() {
      Blank().layoutWeight(5);

      Button(this.vm.actions.defaultText)
        .layoutWeight(20)
        .height(this.s(this.bottomButtonHeight))
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('sans-serif-condensed')
        .fontWeight(FontWeight.Bold)
        .backgroundColor('#BEBEBE')
        .border({ width: 0 })
        .borderRadius(0)
        .padding(0)
        .onClick(() => {
          this.resetDefaults();
        });

      Blank().layoutWeight(15);

      Button(this.vm.actions.submitText)
        .layoutWeight(20)
        .height(this.s(this.bottomButtonHeight))
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .backgroundColor('#BEBEBE')
        .border({ width: 0 })
        .borderRadius(0)
        .padding(0);

      Blank().layoutWeight(10);

      Button(this.vm.actions.backText)
        .layoutWeight(20)
        .height(this.s(this.bottomButtonHeight))
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('Ubuntu')
        .backgroundColor('#BEBEBE')
        .border({ width: 0 })
        .borderRadius(0)
        .padding(0)
        .onClick(() => {
          router.back();
        });

      Blank().layoutWeight(20);

      Text(this.vm.timeText)
        .layoutWeight(20)
        .height(this.s(this.bottomButtonHeight))
        .fontSize(this.s(this.bodyFontSize))
        .fontColor('#000000')
        .fontFamily('STKaiti')
        .lineHeight(this.s(18))
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .height(this.s(70))
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#D3D3D3');
  }
}
