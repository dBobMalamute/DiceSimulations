#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "inputdicemodel.h"
#include "dieconverter.h"
#include "outputdicemodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    InputDiceModel m_inputModel(&app);
    OutputDiceModel m_outputModel(&app);
    DieConverter m_dieConverter(&m_inputModel, &m_outputModel, &app);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("inputModel", &m_inputModel);
    engine.rootContext()->setContextProperty("outputModel", &m_outputModel);
    engine.rootContext()->setContextProperty("DieConverter", &m_dieConverter);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
