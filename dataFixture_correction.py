#!/usr/bin/env python
# -*- coding: utf-8 -*-

import mysql.connector, random

conn = mysql.connector.connect(host="localhost",user="root",password="", database="chevre")
cursor = conn.cursor()
cursor.execute("""
CREATE TABLE IF NOT EXISTS utilisateur
(
   id INT PRIMARY KEY NOT NULL,
   nom VARCHAR(100),
   prenom VARCHAR(100),
   email VARCHAR(255),
   date_naissance DATE,
   pays VARCHAR(255),
   ville VARCHAR(255),
   code_postal VARCHAR(5)
);
""")

names = ["Adam", "Alex", "Alexandre", "Alexis", "Anthony", "Antoine", "Benjamin", "Cédric"]
firstnames = ["Laurence", "Laurie", "Léa", "Léanne", "Maélie", "Maéva", "Maika"]
emails = ["laurence@email.fr", "laurie@email.fr", "lea@email.fr", "leanne@email.fr", "maelie@email.fr", "maeva@email.fr", "maika@email.fr"]
pays = ["France", "USA", "Canada"]
citys = ["Paris", "Tokyo", "New York", "Berlin"]
postalCodes = [75001, 75002, 75003, 65464, 65465, 88888]
i = 0
while i != 5000:
    i = i + 1
    user = (i, random.choice(names), random.choice(firstnames), random.choice(emails), "2010-01-01" , random.choice(pays), random.choice(citys), random.choice(postalCodes))
    cursor.execute("""INSERT INTO utilisateur (id, nom, prenom, email, date_naissance, pays, ville, code_postal) VALUES (%s, %s, %s, %s, %s, %s, %s)""", user)

conn.commit()
conn.close()

