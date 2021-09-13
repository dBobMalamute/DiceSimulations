#include "die.h"

Die::Die(QObject *parent) : QObject(parent)
{

}

Die::Die(const int value, const bool used, QObject *parent) : QObject(parent),
    m_value(value),
    m_used(used)
{

}

int Die::value() const
{
    return m_value;
}

bool Die::used() const
{
    return m_used;
}

void Die::setValue(int value)
{
    if (m_value == value)
        return;

    m_value = value;
    emit valueChanged(m_value);
}

void Die::setUsed(bool used)
{
    if (m_used == used)
        return;

    m_used = used;
    emit usedChanged(m_used);
}
