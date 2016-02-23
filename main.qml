/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

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
        anchors.margins: 2 * 12 + row.height
        model: fileSystemModel
        selection: sel

        onCurrentIndexChanged: console.log("current index", currentIndex)
        TableViewColumn {
            title: "名称"
            role: "name2"
            resizable: true
        }

        TableViewColumn {
            title: "修改时间"
            role: "modify"
            resizable: true
        }
        TableViewColumn {
            title: "文件大小"
            role: "size"
            resizable: true
        }
        TableViewColumn {
            title: "文件属性"
            role: "type"
            resizable: true
        }
        onClicked: console.log("clicked the index is ?", index)
        onDoubleClicked: isExpanded(index) ? collapse(index) : expand(index)
    }
}
