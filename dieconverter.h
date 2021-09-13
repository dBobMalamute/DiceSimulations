#ifndef DIECONVERTER_H
#define DIECONVERTER_H

#include <QObject>
#include <QTimer>
#include "inputdicemodel.h"
#include "outputdicemodel.h"

class DieConverter : public QObject
{
    Q_OBJECT
public:
    explicit DieConverter(InputDiceModel* inputDice, OutputDiceModel *outputDice, QObject *parent = nullptr);

signals:
    void dieAdded(int value);
    void showFirstDieUsed(int value);
    void zoomIn(int processedDice, int dieValue, double intervalTop, double intervalBottom);
    void shrinkOutputInterval(int newDieValue, double intervalTop, double intervalBottom);

    void resetVisuals();

public slots:
    void startProcessing(int totalDice);
    void reset();
    void timeout();

private:
    void processDie(int dieValue);
    bool tryAddDie();

    bool firstDieAdded;

    QTimer m_timer;
    InputDiceModel* m_inputDice;
    OutputDiceModel* m_outputDice;
    int m_totalDice;
    int m_processedDice;

    double m_intervalTop;
    double m_intervalBottom;

};

#endif // DIECONVERTER_H
