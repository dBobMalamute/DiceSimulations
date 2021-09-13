#ifndef INPUTDIE_H
#define INPUTDIE_H

#include <QObject>

class Die : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(bool used READ used WRITE setUsed NOTIFY usedChanged)

public:
    explicit Die(QObject *parent = nullptr);
    Die(const int value, const bool used, QObject* parent = nullptr);

    int value() const;
    bool used() const;

public slots:
    void setValue(int value);
    void setUsed(bool used);

signals:
    void valueChanged(int value);
    void usedChanged(bool used);

private:
    int m_value;
    bool m_used;
};

#endif // INPUTDIE_H
