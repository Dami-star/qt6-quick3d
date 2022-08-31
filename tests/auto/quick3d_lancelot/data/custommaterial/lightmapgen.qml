/****************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the tests of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
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

import QtQuick3D
import QtQuick3D.Effects
import QtQuick

Rectangle {
    id: root
    property int api: GraphicsInfo.api
    width: 800
    height: 800
    color: Qt.rgba(0, 0, 0, 1)

    Flip {
        id: vFlipEffect
        flipHorizontally: false
        flipVertically: true
    }

    View3D {
        id: lightmapSource
        renderMode: View3D.Offscreen
        width: parent.width / 2
        height: parent.height / 2

        environment: SceneEnvironment {
            clearColor: "transparent"
            backgroundMode: SceneEnvironment.Color

            // To get identical results on-screen with all graphics APIs. This (and the
            // corresponding V flip in the other view) would _not_ be needed at all if we
            // didn't want to visualize the lightmap on screen.
            effects: root.api === GraphicsInfo.OpenGL ? [ vFlipEffect ] : []
        }

        DirectionalLight {
        }

        PerspectiveCamera {
            id: camera1
            z: 200
        }

        Model {
            source: "../shared/models/animal_with_lightmapuv1.mesh"
            scale: Qt.vector3d(20, 20, 20)
            materials: CustomMaterial {
                shadingMode: CustomMaterial.Shaded
                vertexShader: "lightmapgen.vert"
                fragmentShader: "lightmapgen.frag"
                cullMode: Material.NoCulling
            }
        }
    }

    View3D {
        width: parent.width / 2
        height: parent.height / 2
        x: parent.width / 2
        y: parent.height / 2

        environment: SceneEnvironment {
            clearColor: "white"
            backgroundMode: SceneEnvironment.Color
        }

        camera: camera1

        Model {
            source: "../shared/models/animal_with_lightmapuv1.mesh"
            scale: Qt.vector3d(20, 20, 20)
            materials: CustomMaterial {
                shadingMode: CustomMaterial.Unshaded
                vertexShader: "lightmapgen_use.vert"
                fragmentShader: "lightmapgen_use.frag"
                property TextureInput tex: TextureInput {
                    texture: Texture {
                        sourceItem: lightmapSource
                        minFilter: Texture.Nearest
                        magFilter: Texture.Nearest
                    }
                }
            }
        }
    }
}
