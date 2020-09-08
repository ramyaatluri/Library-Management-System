from flask import Flask
from flask import jsonify

import sqlite3
import click
from flask import current_app, g
from flask.cli import with_appcontext


app = Flask(__name__)
from bs4 import BeautifulSoup
import requests
import urllib
from pandas.io.html import read_html
import re
import speech_recognition as sr
r = sr.Recognizer()
import pyaudio
# Function to convert text to
# speech
def SpeakText(command):
    # Initialize the engine
    engine = pyttsx3.init()
    engine.say(command)
    engine.runAndWait()
import pyttsx3
import html5lib
import lxml
#source = requests.get('https://www.google.com/search?q=frankenstein+genre').text

#soup = BeautifulSoup(source,'lxml')
#print(soup.find('span',class_="BNeawe"))
#data = ['fiction','Action','Adventure','Art','Alternate history','Autobiography','Anthology','Biography','Chick lit','Book review','Children\'s','Cookbook','Comic book','Diary','Coming-of-age','Dictionary','Crime','Encyclopedia','Drama','Guide']
#dataset = set(data)
@app.route('/genre/<name>')
def index(name):
    #create_app()
    source = requests.get('https://www.google.com/search?q={}+genre'.format(name)).text
    items = list(source.split())
    s = 'not found'
    query = name+"'book wiki'"
    query = urllib.parse.quote_plus(query)  # Format into URL encoding
    number_result = 20
    google_url = "https://www.google.com/search?q=" + query + "&num=" + str(number_result)
    response = requests.get(google_url, {"User-Agent": 'sainath'})
    soup = BeautifulSoup(response.text, "html.parser")
    result_div = soup.find_all('div', attrs={'class': 'ZINbbc'})
    links = []
    titles = []
    descriptions = []
    for r in result_div:
        # Checks if each element is present, else, raise exception
        try:
            link = r.find('a', href=True)
            title = r.find('div', attrs={'class': 'vvjwJb'}).get_text()
            description = r.find('div', attrs={'class': 's3v9rd'}).get_text()

            # Check to make sure everything is present before appending
            if link != '' and title != '' and description != '':
                links.append(link['href'])
                titles.append(title)
                descriptions.append(description)
        # Next loop if one element is not present
        except:
            continue

    to_remove = []
    clean_links = []
    for i, l in enumerate(links):
        clean = re.search('\/url\?q\=(.*)\&sa', l)

        # Anything that doesn't fit the above pattern will be removed
        if clean is None:
            to_remove.append(i)
            continue
        clean_links.append(clean.group(1))
    page = clean_links[0]
    infoboxes = read_html(page, index_col=0, attrs={"class": "infobox"})
    # wikitables = read_html(page, index_col=0, attrs={"class":"wikitable"})

    print("Extracted {num} infoboxes".format(num=len(infoboxes)))
    # print("Extracted {num} wikitables".format(num=len(wikitables)))

    s = infoboxes[0].xs(u'Genre').values[0]
    return jsonify(genre=s)

@app.route('/audio/<name1>')
def audio(name1):
    s = 'recording started'
    try:
        # use the microphone as source for input.
        SpeakText('Listening')
        with sr.Microphone() as source2:

            # wait for a second to let the recognizer
            # adjust the energy threshold based on
            # the surrounding noise level
            r.adjust_for_ambient_noise(source2, duration=0.2)

            # listens for the user's input
            audio2 = r.listen(source2)

            # Using ggogle to recognize audio
            MyText = r.recognize_google(audio2)
            MyText = MyText.lower()

            s = MyText
            SpeakText('recording completed')
    except sr.RequestError as e:
        s = "Could not request results; {0}".format(e)

    except sr.UnknownValueError:
        SpeakText('Unknown error occured try again')
        s = "unknown error occured"
    return jsonify(speech=s)
@app.route('/database/insert/<details>')
def database(details):
    detail = details.split('_-_-_')
    if detail[0] == 'bookDetails':
        statement = 'Select * from book '+detail[1].replace('%20',' ')
        print(statement)
        dataArray = []
        with sqlite3.connect('database.db') as db:
            cursor = db.cursor()
            cursor.execute(statement)
            data = cursor.fetchall()
            for i in range(9):
                tempString = ''
                seperator = '_-_-_'
                x = min(10, len(data))
                for j in range(x - 1):
                    tempString += '{}'.format(data[j][i]) + seperator
                tempString += '{}'.format(data[x-1][i])
                dataArray.append(tempString)
        print(dataArray)

        return jsonify(
                bookIsbn=dataArray[0],
                bookName=dataArray[1],
                bookGenre=dataArray[2],
                bookLanguage=dataArray[3],
                bookPrice=dataArray[4],
                bookPublisher=dataArray[5],
                bookImageUrl=dataArray[6],
                bookQuantity=dataArray[7],
                bookAuthor=dataArray[8]
                )
    x = list(details.split('_-_-_'))
    x[0] = int(x[0])
    x[4] = int(x[4])
    x[7] = int(x[7])
    print(x)
    with sqlite3.connect('database.db') as db:
        try:
            cursor = db.cursor()
            str = 'insert into book values(\'{}\',\'{}\',\'{}\',\'{}\',{},\'{}\',\'{}\',{},\'{}\')'.format(x[0],x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8])
            cursor.execute(str)
        except :
            return '0'
    return '1'

@app.route('/login/<username>')
def validate(username):
    statement = 'Select password from librarian where email = \'{}\''.format(username)
    print(statement)
    with sqlite3.connect('database.db') as db:
        cursor = db.cursor()
        cursor.execute(statement)
        data = cursor.fetchall()
        s = ''
        for i in data:
            for j in i:
                s += j
        print(s)
    return jsonify(password=s)

@app.route('/signup/<validate>')
def signup(validate):
    validate.replace('%20',' ')
    ar = list(validate.split('_-_-_'))
    statement = 'insert into librarian values(\'{}\',\'{}\',\'{}\',\'{}\',\'{}\')'.format(ar[0],ar[1],ar[2],ar[3],ar[4])
    print(statement)
    with sqlite3.connect('database.db') as db:
        cursor = db.cursor()
        cursor.execute(statement)
    return '0'

@app.route('/getuser/<mail>')
def getuser(mail):
    statement = 'Select * from librarian where email = \'{}\''.format(mail)
    print(statement)
    with sqlite3.connect('database.db') as db:
        cursor = db.cursor()
        cursor.execute(statement)
        a = cursor.fetchall()
    return jsonify(
        name = a[0][0],
        email=a[0][1],
        phone=a[0][2],
        dob=a[0][3]
    )