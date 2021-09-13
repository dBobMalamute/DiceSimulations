#include "dieconverter.h"

DieConverter::DieConverter(InputDiceModel *inputDice, OutputDiceModel *outputDice, QObject *parent) :
    QObject(parent),
    m_inputDice(inputDice),
    m_outputDice(outputDice)
{
    reset();
    m_timer.setInterval(6000);
    connect(&m_timer, &QTimer::timeout, this, &DieConverter::timeout);
    connect(inputDice, &InputDiceModel::newDice, this, &DieConverter::startProcessing);
    connect(inputDice, &InputDiceModel::resetDice, this, &DieConverter::reset);
}

void DieConverter::startProcessing(int totalDice)
{
    m_totalDice = totalDice;

    if(!m_timer.isActive())
    {
        m_timer.start();
        timeout();
    }
}

void DieConverter::reset()
{
    m_timer.stop();
    m_totalDice = 0.0;
    m_processedDice = 0;
    m_intervalTop = 1.0;
    m_intervalBottom = 0.0;
    m_outputDice->clearDice();
    firstDieAdded = false;
    emit resetVisuals();
}

void DieConverter::timeout()
{
    if(m_processedDice < m_totalDice)
    {
        if(!firstDieAdded)
        {
            //First time zoom in.
            int value = m_inputDice->useDie(m_processedDice);
            firstDieAdded = true;
            processDie(value);
            m_processedDice++;
            emit showFirstDieUsed(value);
        }
        else if(tryAddDie())
        {
        }
        else
        {
            int value = m_inputDice->useDie(m_processedDice);
            emit zoomIn(m_processedDice, value, m_intervalTop, m_intervalBottom);
            processDie(value);
            m_processedDice++;
        }
    }
    else if(m_totalDice == 0 || !tryAddDie())
    {
        m_timer.stop();
    }

}

void DieConverter::processDie(int dieValue)
{
    m_intervalTop = 6.0 * m_intervalTop - (6 - dieValue);
    m_intervalBottom = 6.0 * m_intervalBottom - (6 - dieValue);
}

bool DieConverter::tryAddDie()
{
    QList<double> outputDieBoundaries;
    outputDieBoundaries.reserve(9);
    for(int i = 0; i < 9; i++)
        outputDieBoundaries.append((1.0 - i/8.0) * m_intervalTop + (i/8.0) * m_intervalBottom);

    for(int i = 0; i < 8; i++)
    {
        if(outputDieBoundaries.at(i) >= 1.0 && outputDieBoundaries.at(i+1) <= 0.0)
        {
            m_outputDice->addDie(i+1);
            emit dieAdded(i+1);
            m_intervalTop = outputDieBoundaries.at(i);
            m_intervalBottom = outputDieBoundaries.at(i+1);
            emit shrinkOutputInterval(i+1, m_intervalTop, m_intervalBottom);

            return true;
        }
    }
    return false;
}
