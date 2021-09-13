#include "inputdicemodel.h"

InputDiceModel::InputDiceModel(QObject *parent) : QAbstractListModel(parent),
    m_totalDice(0)
{

}


int InputDiceModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_dice.size();
}

QVariant InputDiceModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= m_dice.size())
        return QVariant();

    Die* die = m_dice.at(index.row());
    if(role == ValueRole)
        return QVariant(die->value());
    if(role == UsedRole)
        return QVariant(die->used());
    return QVariant();
}

bool InputDiceModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Die * die = m_dice.at(index.row());

    bool changed = false;
    switch (role)
    {
    case ValueRole:
    {
        if(die->value() != value.toInt())
        {
            die->setValue(value.toInt());
            changed = true;
        }
    }
    case UsedRole:
    {
        if(die->used() != value.toBool())
        {
            die->setUsed(value.toBool());
            changed = true;
        }
    }
    }
    if(changed)
    {
        emit dataChanged(index,index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags InputDiceModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> InputDiceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ValueRole] = "value";
    roles[UsedRole] = "used";

    return roles;
}

int InputDiceModel::useDie(int i)
{
    m_dice.at(i)->setUsed(true);
    QModelIndex index = createIndex(i, 0);
    emit dataChanged(index, index, QVector<int>() << UsedRole);
    return m_dice.at(i)->value();
}

int InputDiceModel::totalDice() const
{
    return m_totalDice;
}

void InputDiceModel::rollDice(int numRolled)
{
    m_totalDice += numRolled;
    emit totalDiceChanged(m_totalDice);

    const int index = m_dice.size();
    beginInsertRows(QModelIndex(), index, index + numRolled - 1);

    for(int i = 0; i < numRolled; i++)
    {
        int value = QRandomGenerator::global()->bounded(6) + 1;
        Die* die = new Die(value, false, this);
        m_dice.append(die);
    }

    emit newDice(m_totalDice);
    endInsertRows();
}

void InputDiceModel::addDie(int value)
{
    m_totalDice += 1;
    emit totalDiceChanged(m_totalDice);

    const int index = m_dice.size();
    beginInsertRows(QModelIndex(), index, index);

    Die* die = new Die(value, false, this);
    m_dice.append(die);

    emit newDice(m_totalDice);
    endInsertRows();
}

void InputDiceModel::clearDice()
{
    m_totalDice = 0;
    emit resetDice();
    emit totalDiceChanged(m_totalDice);

    beginRemoveRows(QModelIndex(), 0, m_dice.size());
    m_dice.clear();
    endRemoveRows();
}
