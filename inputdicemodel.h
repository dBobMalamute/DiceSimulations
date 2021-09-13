#ifndef INPUTDICEMODEL_H
#define INPUTDICEMODEL_H

#include <QObject>
#include "die.h"

#include <QAbstractListModel>
#include <QRandomGenerator>

class InputDiceModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int totalDice READ totalDice NOTIFY totalDiceChanged)

    enum DieRoles
    {
        ValueRole = Qt::UserRole + 1,
        UsedRole
    };

public:
    explicit InputDiceModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;

    int useDie(int i);

    int totalDice() const;

signals:
    void newDice(int numDice);
    void resetDice();
    void totalDiceChanged(int totalDice);

public slots:
    void rollDice(int numRolled);
    void addDie(int value);
    void clearDice();

private:
    QList<Die*> m_dice;

    int m_totalDice;
};

#endif // INPUTDICEMODEL_H
