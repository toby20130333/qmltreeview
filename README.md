# 自定义QML-TreeView开发简单指导

QtQuick Website: http://www.heilqt.com

###Getting Started
* Features:
* 自定义C++的QAbstractItemModel
* 自由定制树形视图样式
* 保持QML绘制UI，C++处理数据


#### 编译方法
* 打开QtCreator IDE
* 清理项目进行编译
* 记得在QtCreator项目配置加入make install的步骤
* 点击运行

#### 使用方法
* 可以修改该项目的C++的QAbstractItemModel部分
* 主要涉及到model数据的初始化
* 枚举类型的声明和使用

```
    enum DelegateEnum
    {
        NameEnum = 0,
        SummaryEnum,
        SizeEnum,
    };
```

* 重写roleNames方法
```
QHash<int, QByteArray> TreeModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameEnum] = "name";
    roles[SummaryEnum] = "summary";
    roles[SizeEnum]="size";
    return roles;
}
```

* 初始化model和角色
```
TreeModel::TreeModel(const QString &data, QObject *parent)
    : QAbstractItemModel(parent)
{
    QList<QVariant> rootData;
    rootData << "Title" << "Summary"<<"Size";
    rootItem = new TreeItem(rootData);
    setupModelData(data.split(QString("\n")), rootItem);
}
```
* 根据role返回不同列的数据到UI
```
QVariant TreeModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    TreeItem *item = static_cast<TreeItem*>(index.internalPointer());

    switch (role) {
    case NameEnum:
        return item->data(0);
    case SummaryEnum:
        return item->data(1);
    case SizeEnum:
        return item->data(2);
    }
}
```

* QML部分

```
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQml.Models 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("File System")

    ItemSelectionModel {
        id: sel
        model: fileSystemModel
        onSelectionChanged: {
            console.log("selected", selected)
            console.log("deselected", deselected)
        }
        onCurrentChanged: console.log("current", current)
    }
    TreeView {
        id: view
        anchors.fill: parent
        anchors.margins: 2 * 12
        model: fileSystemModel
        selection: sel
        onCurrentIndexChanged: console.log("current index", currentIndex)

        itemDelegate: Rectangle {
            color: ( styleData.row % 2 == 0 ) ? "white" : "lightblue"
            height: 40
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                text: styleData.value 
            }
        }
        TableViewColumn {
            title: "Title"
            role: "name"
            resizable: true
        }
        TableViewColumn {
            title: "Summary"
            role: "summary"
            width: view.width/2
        }
        onClicked: console.log("clicked the index is ?", index)
        onDoubleClicked: isExpanded(index) ? collapse(index) : expand(index)
    }
}

```