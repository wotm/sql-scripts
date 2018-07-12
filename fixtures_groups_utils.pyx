#!usr/bin/python3

import mysql.connector
from mysql.connector.errors import Error
from faker import Faker

# FUNCTIONS #

# Init the database
def init_db(cursor):
        # Verify if there is a user table
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS utilisateur
        (
           id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
           nom VARCHAR(100),
           prenom VARCHAR(100),
           email VARCHAR(255),
           date_naissance DATE,
           pays VARCHAR(255),
           ville VARCHAR(255),
           code_postal VARCHAR(5),
           telephone VARCHAR(20)
        );
        """)

        # Verify if there is a group table
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS groupe
        (
           id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
           nom VARCHAR(100)
        );
        """)

        # Verify if there is a group_utilisateur table
        cursor.execute("""
        CREATE TABLE IF NOT EXISTS groupe_utilisateur
        (
           id_utilisateur INT PRIMARY KEY,
           id_groupe INT PRIMARY KEY,
           CONSTRAINT FK_groupe_utilisateur FOREIGN KEY (id_utilisateur)
           REFERENCES utilisateur(id),
           CONSTRAINT FK_groupe_utilisateur FOREIGN KEY (id_groupe)
           REFERENCES groupe(id)
        );
        """)

        # Delete entire datas from the tables
        cursor.execute("""SET FOREIGN_KEY_CHECKS=0""")
        cursor.execute("""TRUNCATE TABLE groupe""")
        cursor.execute("""TRUNCATE TABLE utilisateur""")
        cursor.execute("""TRUNCATE TABLE groupe_utilisateur""")
        cursor.execute("""SET FOREIGN_KEY_CHECKS=1""")

        return cursor


# Adding groups values
def add_groups(cursor):
    groups = ["Administrateur Réseaux","Développeur Web", "Ressources Humaines", "Graphiste", "Chef de Projet", "Architecte Base de Données", "UX Designer"];
    query = """INSERT INTO groupe (nom) VALUES (%s)"""
    for i in range(0, len(groups)):
        cursor.execute(query, groups[i])

# Adding users values
def add_users(cursor):
    query = """INSERT INTO utilisateur (nom, prenom, email, date_naissance, pays, ville, code_postal, telephone) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
    fake = Faker('fr_FR')
    for i in range(0, 100):
        cursor.execute(query, fake.last_name(), fake.first_name(), fake.email(), fake.date_time_between(start_date="-30y", end_date="now", tzinfo=None) , fake.country(), fake.city(), fake.postcode(), fake.phone_number())





# MAIN
try:
    # Establish a MySQL connection
    conn = mysql.connector.connect(host = 'localhost', database = 'cours_sql', user = 'root', password = '')
    cursor = conn.cursor()
    init_db(cursor)
    add_groups(cursor)
    add_users(cursor)

    conn.commit()

except Error as error:
    print(error)

finally:
    cursor.close()
    conn.close()