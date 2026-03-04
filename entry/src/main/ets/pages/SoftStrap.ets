// SoftPlatenPanel.ets
import router from '@ohos.router';

@Component
struct CbItem {
  @Prop label: string;
  @Prop isChecked: boolean = true;
  @Prop itemWidth: Length = 'auto';

  build() {
    Row() {
      // 在支持的 API 版本中可以使用 shape(CheckBoxShape.ROUNDED_SQUARE) 让复选框变方
      Checkbox({ name: this.label, group: 'checkboxGroup' })
        .select(this.isChecked)
        .width(16)
        .height(16)
        .selectedColor('#000000') // 黑色选中状态，符合工业软件风格

      Text(this.label)
        .fontSize(14)
        .fontColor(Color.Black)
        .margin({ left: 4 })
    }
    .width(this.itemWidth)
    .margin({ top: 6, bottom: 6 })
  }
}

@Builder
function DashedDivider() {
  Line()
    .width('100%')
    .height(1)
    .strokeWidth(1)
    .stroke('#999999')
    .strokeDashArray([4, 4]) // 虚线效果
    .margin({ top: 4, bottom: 4 })
}

@Entry
@Component
export struct SoftStrap {
  build() {
    Column() {
      // --- 顶部标题栏 (固定在顶部) ---
      Row() {
        Text('温馨提醒：软压板已被改动！')
          .fontColor(Color.Red)
          .fontSize(14)
          .width('25%')

        Text('运行操作—软压板投退')
          .fontWeight(FontWeight.Bold)
          .fontSize(18)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Row() {
          CbItem({ label: '投入', isChecked: true })
          Blank().width(10)
          CbItem({ label: '退出', isChecked: false })
          Blank().width(20)
          // 使用文本符号代替图标，方便直接运行展示
          Text('↺').fontSize(22).margin({ right: 16 }).fontWeight(FontWeight.Bold)
          Text('✕').fontSize(20)
        }
        .width('30%')
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })

      DashedDivider()

      // --- 中间滚动区域 (自适应剩余高度) ---
      Scroll() {
        Column() {
          // --- 公共 ---
          Row() {
            Text('公共: ').fontWeight(FontWeight.Bold).fontSize(16).width('12%')
            CbItem({ label: '远方投退软压板' })
            Blank().width(20)
            CbItem({ label: '远方修改定值' })
            Blank().width(20)
            CbItem({ label: '远方切换定值区' })
            Blank().width(20)
            CbItem({ label: '遥控' })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          DashedDivider()

          // --- 纵联保护 ---
          Row() {
            Text('纵联保护: ').fontWeight(FontWeight.Bold).fontSize(16).width('15%')
            CbItem({ label: '分相电流差动保护' })
            Blank().width(20)
            CbItem({ label: '零序纵联保护' })
            Blank().width(20)
            CbItem({ label: '低频减载保护' })
          }
          .width('100%')

          DashedDivider()

          // --- 过电流保护 ---
          Row() {
            Text('过电流保护: ').fontWeight(FontWeight.Bold).fontSize(16).width('15%')
            CbItem({ label: 'I段' })
            Blank().width(15)
            CbItem({ label: 'II段' })
            Blank().width(15)
            CbItem({ label: 'III段' })
            Blank().width(15)
            CbItem({ label: '反时限' })
            Blank().width(15)
            CbItem({ label: 'PT断线相过流' })
            Blank().width(15)
            CbItem({ label: '加速段' })
          }
          .width('100%')

          DashedDivider()

          // --- 零序过流保护 ---
          Row() {
            Text('零序过流保护: ').fontWeight(FontWeight.Bold).fontSize(16).width('18%')
            CbItem({ label: 'I段' })
            Blank().width(20)
            CbItem({ label: 'II段' })
            Blank().width(20)
            CbItem({ label: 'III段' })
            Blank().width(20)
            CbItem({ label: '反时限' })
            Blank().width(20)
            CbItem({ label: '加速段' })
          }
          .width('100%')

          DashedDivider()

          // --- 自适应零序过流保护 ---
          Row() {
            Text('自适应零序过流保护: ').fontWeight(FontWeight.Bold).fontSize(16).width('25%')
            CbItem({ label: 'I段' })
            Blank().width(20)
            CbItem({ label: 'II段' })
            Blank().width(20)
            CbItem({ label: 'III段' })
            Blank().width(20)
            CbItem({ label: '反时限' })
            Blank().width(20)
            CbItem({ label: '加速段' })
          }
          .width('100%')

          DashedDivider()

          // --- 综合保护网格 (使用 Flex 排版保证 5 列对齐) ---
          Flex({ wrap: FlexWrap.Wrap }) {
            CbItem({ label: '母线保护', itemWidth: '20%' })
            CbItem({ label: '停用重合闸', itemWidth: '20%' })
            CbItem({ label: '过负荷保护', itemWidth: '20%' })
            CbItem({ label: '低电压保护', itemWidth: '20%' })
            CbItem({ label: '过电压保护', itemWidth: '20%' })

            CbItem({ label: '低频保护', itemWidth: '20%' })
            CbItem({ label: '高频保护', itemWidth: '20%' })
            CbItem({ label: '逆功率保护', itemWidth: '20%' })
            CbItem({ label: '谐波电流保护', itemWidth: '20%' })
            CbItem({ label: '谐波电压保护', itemWidth: '20%' })
          }
          .width('100%')

          DashedDivider()

          // --- GOOSE 保护 ---
          Flex({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.Center }) {
            Text('GOOSE保护: ')
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
              .width('20%')
              .margin({ top: 6, bottom: 6 })

            CbItem({ label: '过负荷保护', itemWidth: '20%' })
            CbItem({ label: '低电压保护', itemWidth: '20%' })
            CbItem({ label: '过电压保护', itemWidth: '20%' })
            CbItem({ label: '低频保护', itemWidth: '20%' })

            // 第二行占位，保证与上面对齐
            Row().width('20%')
            CbItem({ label: '高频保护', itemWidth: '20%' })
            CbItem({ label: '逆功率保护', itemWidth: '20%' })
            CbItem({ label: '谐波电流保护', itemWidth: '20%' })
            CbItem({ label: '谐波电压保护', itemWidth: '20%' })
          }
          .width('100%')
        }
      }
      .layoutWeight(1) // 关键：利用剩余高度，撑满容器并支持滚动
      .scrollBar(BarState.Auto)
      .width('100%')

      // --- 底部按钮与时间栏 (固定在底部) ---
      Row() {
        Row() {
          Button('确认', { type: ButtonType.Normal })
            .backgroundColor('#E2E2E2')
            .fontColor(Color.Black)
            .width(80)
            .height(32)
            .margin({ right: 40 })

          Button('取消', { type: ButtonType.Normal }) // 将"关闭"更改为了"取消"
            .backgroundColor('#E2E2E2')
            .fontColor(Color.Black)
            .width(80)
            .height(32)
            .margin({ right: 40 })

          Button('返回', { type: ButtonType.Normal })
            .backgroundColor('#E2E2E2')
            .fontColor(Color.Black)
            .width(80)
            .height(32)
            .onClick(() => {
              router.back();
            })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        Column() {
          Text('2024/12/30').fontSize(14)
          Text('12:12:30').fontSize(14).margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.End)
        .width('20%')
      }
      .width('100%')
      .padding({ top: 15, bottom: 5, right: 10 }) // 稍微调整留白空间

    }
    .width('100%')
    .height('100%') // 关键：锁定总高度为屏幕高度，适配1024*600等固定分辨率
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .backgroundColor('#F8F8F8') // 设置浅灰底色适配工业应用风格
    .border({ width: 1, color: Color.Black }) // 外层黑色边框
  }
}