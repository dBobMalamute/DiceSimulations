#ifndef OUTPUTDICEMODEL_H
#define OUTPUTDICEMODEL_H

#include <QObject>
#include <QAbstractListModel>

#include "die.h"

class OutputDiceModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(int totalDice READ totalDice WRITE setTotalDice NOTIFY totalDiceChanged)

    enum DieRoles
    {
        ValueRole = Qt::UserRole + 1
    };

public:
    explicit OutputDiceModel(QObject* parent = nullptr);

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;

    int totalDice() const;

public slots:
    void addDie(int value);
    void clearDice();
    void setTotalDice(int totalDice);

signals:
    void totalDiceChanged(int totalDice);

private:
    QList<Die*> m_dice;

    int m_totalDice;
};

#endif // OUTPUTDICEMODEL_H
