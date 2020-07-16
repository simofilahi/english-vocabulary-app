# -*- coding: utf-8 -*-
"""
Created on Mon Jul 13 14:57:38 2020

@author: drpbengrir
"""
import urllib.request
import requests
import json

def getAr(index):
    line_num = 0;
    with open("arabic.txt", "r", encoding='utf-8') as a_file:
        for line in a_file:
            word = line.strip()
            line_num = line_num + 1;
            if line_num == index:
                return word;
            
    
def getFr(index):
    line_num = 0;
    with open("french.txt", "r", encoding='utf-8') as a_file:
        for line in a_file:
            word = line.strip()
            line_num = line_num + 1;
            if line_num == index:
                return word;

def getSp(index):
    line_num = 0;
    with open("spanich.txt", "r", encoding='utf-8') as a_file:
        for line in a_file:
            word = line.strip()
            line_num = line_num + 1;
            if line_num == index:
                return word;
    
def getCh(index):
    line_num = 0;
    with open("chinese.txt", "r", encoding='utf-8') as a_file:
        for line in a_file:
            word = line.strip()
            line_num = line_num + 1;
            if line_num == index:
                return word;

def getType(index):
    line_num = 0;
    with open("type.txt", "r", encoding='utf-8') as a_file:
        for line in a_file:
            word = line.strip()
            line_num = line_num + 1;
            if line_num == index:
                return word;
            
f = open("alldata.txt", "a", encoding="utf-8")

with open("word.txt", "r") as a_file:
  line_num = 0;
  for line in a_file:
    line_num = line_num + 1;  
    en_word = line.strip()
    ar_word = getAr(line_num)
    fr_word = getFr(line_num)
    es_word = getSp(line_num)
    zh_word = getCh(line_num)
    typeName = getType(line_num)
    print(en_word);
    print(ar_word);
    print(fr_word);
    print(zh_word);
    print(es_word);
    print(typeName);
    f.write('{\n')
    f.write('"en": "{}",\n'.format(en_word));
    f.write('"ar": "{}",\n'.format(ar_word));
    f.write('"fr": "{}",\n'.format(fr_word));
    f.write('"es": "{}",\n'.format(es_word));
    f.write('"zh": "{}",\n'.format(zh_word));
    f.write('"type": "{}",\n'.format(typeName));
    audio = en_word + '.mp3';
    f.write('"audioPath": "{}",\n'.format(audio));
    try:
        myToken = '5e5468597df3524bec53523b91f8604f952e4eed'
        myUrl = 'https://owlbot.info/api/v4/dictionary/{}'.format(en_word)
        head = {'Authorization': 'token {}'.format(myToken)}
        response = requests.get(myUrl, headers=head)
        data = response.json();
        for (key, value) in data.items():
            if key == 'pronunciation':
                if data[key] != None:
                    print(data[key])
                    f.write('"pronunciation": "{}",\n'.format(data[key])),
            if key == "definitions":
                if data[key] != None:
                    for d in data[key]:
                        if d['example'] != None:
                            print(d['example']);
                            string = d['example'] + '|';
                    f.write('"examples": "{}",\n'.format(string)),
    except:
        f.write('"pronunciation": "None",\n'),
        f.write('"examples": "None",\n'),
       # f.write('"word": "{}"')
    f.write('},\n')
    
f.close();