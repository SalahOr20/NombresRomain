def convertir(nombre):
    if nombre <= 3:
        return 'I'*nombre

    if nombre == 4:
        return 'IV'

    if nombre <= 8:
        return 'V' + 'I'*(nombre-5)
    if nombre == 9:
        return 'IX'

    raise Exception('Erreur')
