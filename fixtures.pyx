#!usr/bin/python3

import mysql.connector
from mysql.connector.errors import Error
from faker import Faker


try:
    # Establish a MySQL connection
    conn = mysql.connector.connect(host = 'localhost', database = 'cours_sql', user = 'root', password = '')
    cursor = conn.cursor()

    query = "INSERT INTO utilisateur (nom, prenom, email, date_naissance, pays, ville, code_postal, telephone) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    fake = Faker('fr_FR')

    for i in range(0, 4999):
        cursor.execute(query, (fake.last_name(), fake.first_name(), fake.email(), fake.date_time_between(start_date="-30y", end_date="now", tzinfo=None) , fake.country(), fake.city(), fake.postcode(), fake.phone_number()))

    conn.commit()

except Error as error:
    print(error)

finally:
    cursor.close()
    conn.close()
