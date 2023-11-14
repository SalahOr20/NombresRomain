import unittest
import parameterized as parameterized

import Convertisseur


class MyTestCase(unittest.TestCase):

    @parameterized.parameterized.expand([[1], [2], [3]])
    def test_unatrois(self, n):
        # n entre 1 et 3
        # n en nombres romains
        result = Convertisseur.convertir(n)
        attendu = 'I'*n
        self.assertEqual(attendu, result)

    def test_quatre(self):
        # n est le chiffre 4
        nombre = 4

        # n en nombres romains
        result = Convertisseur.convertir(nombre)
        self.assertEqual('IV', result)

    def test_cinq(self):
        # n est le chiffre 5
        nombre = 5

        #n en nombres romains
        result = Convertisseur.convertir(nombre)
        self.assertEqual('V', result)

    def test_sis(self):
        # n est le chiffre 6
        nombre = 6

        # n en nombres romains
        result = Convertisseur.convertir(nombre)
        self.assertEqual('VI', result)

    def test_sept(self):
        # n est le chiffre 7
        nombre = 7

        # n en nombres romains
        result = Convertisseur.convertir(nombre)
        self.assertEqual('VII', result)

    def test_huit(self):
        # n est le chiffre 8
        nombre = 8
        # n en nombres romains
        result = Convertisseur.convertir(nombre)
        self.assertEqual('VIII', result)


if __name__ == '__main__':
    unittest.main()
