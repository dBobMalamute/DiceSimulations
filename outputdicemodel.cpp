#include "outputdicemodel.h"

OutputDiceModel::OutputDiceModel(QObject *parent) : QAbstractListModel(parent),
    m_totalDice(0)
{

}


int OutputDiceModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_dice.size();
}

QVariant OutputDiceModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= m_dice.size())
        return QVariant();

    Die* die = m_dice.at(index.row());
    if(role == ValueRole)
        return QVariant(die->value());
    return QVariant();
}

bool OutputDiceModel::setData(const QModelIndex &index, const QVariant &value, int role)
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
    }
    if(changed)
    {
        emit dataChanged(index,index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags OutputDiceModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> OutputDiceModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ValueRole] = "value";

    return roles;
}

int OutputDiceModel::totalDice() const
{
    return m_totalDice;
}

void OutputDiceModel::addDie(int value)
{
    m_totalDice++;
    emit totalDiceChanged(m_totalDice);

    const int index = m_dice.size();
    beginInsertRows(QModelIndex(), index, index);

    Die* die = new Die(value, true, this);
    m_dice.append(die);

    endInsertRows();
}

void OutputDiceModel::clearDice()
{
    setTotalDice(0);
    beginRemoveRows(QModelIndex(), 0, m_dice.size());
    m_dice.clear();
    endRemoveRows();
}

void OutputDiceModel::setTotalDice(int totalDice)
{
    if (m_totalDice == totalDice)
        return;

    m_totalDice = totalDice;
    emit totalDiceChanged(m_totalDice);
}
