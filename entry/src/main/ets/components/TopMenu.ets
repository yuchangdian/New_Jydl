import router from '@ohos.router';

interface SubMenuItem {
  title: string;
}

interface MenuItem {
  title: string;
  items: MenuSubItem[];
}

interface MenuSubItem {
  title: string;
  subItems?: SubMenuItem[];
}

@Component
export struct TopMenu {
  @State menuIndex: number = -1;
  @State subMenuIndex: number = -1;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          ForEach([
            { title: '运行操作', items: [{ title: '压板投退' }, { title: '定值切换' }, { title: '遥控操作' }, { title: '浏览' }, { title: '整定' }] },
            { title: '电能质量', items: [{ title: '实时指标' }, { title: '宽频谐波' }, { title: '告警定值' }, { title: '浏览' }, { title: '整定' }] },
            { title: '高级分析', items: [{ title: '故障特性' }, { title: '负荷特性' }, { title: '风险评估' }] },
            { title: '定值管理', items: [
              { title: '一次系统', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '模拟量', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '遥测参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '通信参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '遥控参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '越限报警', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '统计参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
              { title: '保护定值', subItems: [{ title: '浏览' }, { title: '整定' }, { title: '拷贝' }, { title: '删除' }] }
            ] },
            { title: '报告管理', items: [
              { title: '保护报告', subItems: [{ title: '动作' }, { title: '告警' }, { title: '录波' }, { title: '变位' }, { title: '操作' }, { title: 'SOE' }] },
              { title: '测控报告' },
              { title: '装置设置' },
              { title: 'IEC61850' }
            ] },
            { title: '打印操作', items: [{ title: '软压板' }, { title: '设备参数' }, { title: '系统定值' }, { title: '测控参数' }, { title: '保护定值' }, { title: '保护状态' }] },
            { title: '装置测试', items: [{ title: '开出测试' }, { title: '开入测试' }, { title: '灯光测试' }, { title: '精度测试' }, { title: '零漂测试' }, { title: '远动测试' }, { title: '试验测试' }] },
            { title: '装置设置', items: [{ title: '时间设置' }, { title: '对时设置' }, { title: '通信设置' }, { title: '液晶设置' }, { title: '电度量' }, { title: '模拟量' }, { title: '密码设置' }] }
          ], (menu: MenuItem, index: number) => {
            Column() {
              Text(menu.title)
                .fontSize(16)
                .fontColor('#333333')
                .fontWeight(FontWeight.Bold)
                .padding(8)
                .width('100%')
                .textAlign(TextAlign.Center)
            }
            .layoutWeight(1)
            .height(30)
            .backgroundColor(this.menuIndex === index ? '#c0c6cc' : '#d6dadc')
            .borderRadius(5)
            .margin({ left: 3, right: 3 })
            .onClick(() => {
              this.menuIndex = this.menuIndex === index ? -1 : index;
              this.subMenuIndex = -1;
            })

            if (this.menuIndex >= 0) {
              Column() {
                ForEach([
                  { title: '运行操作', items: [{ title: '压板投退' }, { title: '定值切换' }, { title: '遥控操作' }] },
                  { title: '电能质量', items: [{ title: '实时指标' }, { title: '宽频谐波' }, { title: '告警定值' }] },
                  { title: '高级分析', items: [{ title: '故障特性' }, { title: '负荷特性' }, { title: '风险评估' }] },
                  { title: '定值管理', items: [
                    { title: '一次系统', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '模拟量', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '遥测参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '通信参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '遥控参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '越限报警', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '统计参数', subItems: [{ title: '浏览' }, { title: '整定' }] },
                    { title: '保护定值', subItems: [{ title: '浏览' }, { title: '整定' }, { title: '拷贝' }, { title: '删除' }] }
                  ] },
                  { title: '报告管理', items: [
                    { title: '保护报告', subItems: [{ title: '动作' }, { title: '告警' }, { title: '录波' }, { title: '变位' }, { title: '操作' }, { title: 'SOE' }] },
                    { title: '测控报告' },
                    { title: '装置设置' },
                    { title: 'IEC61850' }
                  ] },
                  { title: '打印操作', items: [{ title: '软压板' }, { title: '设备参数' }, { title: '系统定值' }, { title: '测控参数' }, { title: '保护定值' }, { title: '保护状态' }] },
                  { title: '装置测试', items: [{ title: '开出测试' }, { title: '开入测试' }, { title: '灯光测试' }, { title: '精度测试' }, { title: '零漂测试' }, { title: '远动测试' }, { title: '试验测试' }] },
                  { title: '装置设置', items: [{ title: '时间设置' }, { title: '对时设置' }, { title: '通信设置' }, { title: '液晶设置' }, { title: '电度量' }, { title: '模拟量' }, { title: '密码设置' }] }
                ], (menu: MenuItem, index: number) => {
                  if (this.menuIndex === index) {
                    Column() {
                      ForEach(menu.items, (item: MenuSubItem, subIndex: number) => {
                        if(item.title === "压板投退"){
                          Column() {
                            Row() {
                              Text(item.title)
                                .fontSize(13)
                                .fontColor('#333333')
                                .layoutWeight(1)
                                .textAlign(TextAlign.Start)
                            }
                            .backgroundColor('#d6dadc')
                            .width('100%')
                            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                            .onClick(() => {
                              // 只要在这里写了 router.pushUrl(...)，上面的警告就会自动消失！
                              router.pushUrl({
                                url: 'pages/SoftStrap'
                              }).catch((error: Error) => {
                                console.error(`跳转失败，错误码：${error.name}，信息：${error.message}`);
                              });
                              this.menuIndex = -1;
                              this.subMenuIndex = -1;
                              // 可以在这里加上 router.pushUrl 跳转到独立页面
                            })
                          } // <--- 补上这里：闭合 if 分支里的 Column()
                        } else {
                          Column() {
                            Row() {
                              Text(item.title)
                                .fontSize(13)
                                .fontColor('#333333')
                                .layoutWeight(1)
                                .textAlign(TextAlign.Start)
                            }
                            .backgroundColor('#d6dadc')
                            .width('100%')
                            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                            .onClick(() => {
                              this.menuIndex = -1;
                              this.subMenuIndex = -1;
                            })
                          } // <--- 补上这里：闭合 else 分支里的 Column()
                        }


                          if (item.subItems && item.subItems.length > 0) {
                            Column() {
                              ForEach(item.subItems, (subItem: SubMenuItem) => {
                                Text(subItem.title)
                                  .fontSize(13)
                                  .fontColor('#333333')
                                  .width('100%')
                                  .padding({ left: 24, right: 12, top: 0, bottom: 8 })
                                  .textAlign(TextAlign.Start)
                                  .onClick(() => {
                                    this.menuIndex = -1;
                                    this.subMenuIndex = -1;
                                  })
                              })
                            }
                            .backgroundColor('#d6dadc')
                            .width('100%')
                          }

                      })
                    }
                    .width(160)
                    .borderRadius({ bottomLeft: 5, bottomRight: 5 })
                    .zIndex(9999)
                    .position({ x: index * 133, y: 47 })


                  }
                })
              }
              .position({ x: 0, y: 0 })

            }
          })
        }
        .width('100%')
        .height(47)
        .backgroundColor('#e2e6ec')
        .padding({ left: 20, right: 20 })

      }
      .width('100%')


    }
    .width('100%')
  }
}
