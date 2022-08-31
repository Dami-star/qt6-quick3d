/****************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of Qt Quick 3D.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick
import QtQuick.Window
import QtQuick3D
import QtQuick.Controls

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Camera lookAt")

    View3D {
        anchors.fill: parent

        PerspectiveCamera {
            id: sceneCamera
            z: 300
            x: -200
            y: 100
            eulerRotation: Qt.vector3d(-15, -30, 0)
        }

        Model {
            id: cube
            x: 200
            y: 100
            source: "#Cube"
            materials: DefaultMaterial {
                diffuseColor: "pink"
            }
        }

        Model {
            id: cone
            source: "#Cone"
            materials: DefaultMaterial {
                diffuseColor: "orange"
            }
        }

        Model {
            id: sphere
            x: -200
            y: -100
            source: "#Sphere"
            materials: DefaultMaterial {
                diffuseColor: "blue"
            }
        }

        DirectionalLight {

        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        Button {
            text: "Cube"
            onClicked: {
                sceneCamera.rotation = Quaternion.lookAt(sceneCamera.scenePosition, cube.scenePosition)
            }
        }
        Button {
            text: "Cone"
            onClicked: {
                sceneCamera.lookAt(cone);
            }
        }
        Button {
            text: "Sphere"
            onClicked: {
                sceneCamera.lookAt(sphere.scenePosition);
            }
        }

    }

}
