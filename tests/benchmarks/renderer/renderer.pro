QT += testlib quick3d-private quick3druntimerender-private
QT -= gui

CONFIG += qt console warn_on depend_includepath testcase
CONFIG -= app_bundle

TEMPLATE = app

SOURCES +=  tst_renderer.cpp
