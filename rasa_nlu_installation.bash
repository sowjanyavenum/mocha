#!/bin/bash

#Main dir the script is installed in
maindir=/rasa
mkdir ${maindir}
cd ${maindir}
appdir=eaiadmin
mkdir ${appdir}
cd ${appdir}
optdir=app
mkdir ${optdir}


echo "Removing previously copied files in the path"
sudo rm -rf /opt/Python-2.7.5.tgz
sudo rm -rf /opt/Python-2.7.5
sudo rm -rf /home/app/MITIE-models-v0.2.tar.bz2
sudo rm -rf /home/app/MITIE-models
sudo rm -rf /home/app/rasa-1.0.0.zip
sudo rm -rf /home/app/rasa_nlu


echo "Step:1 Install git.............."
sudo apt-get update -y
sudo apt-get install git -y



echo "Step :2 Install pip .........."
cd ${optdir}
sudo apt install python-pip

echo "Step 3:This script is to install RASA NLU"
cd ${optdir}
virtualenv rasa_nlu_v
source rasa_nlu_v/bin/activate

wget https://pypi.python.org/packages/3c/0b/606a85ec21646f90a6e80ab66f7d26544a653a9dca782149aa82c9528c84/rasa_nlu_latest-0.8.0a10.tar.gz
tar xfz rasa_nlu_latest-0.8.0a10.tar.gz
mv rasa_nlu_latest-0.8.0a10 rasa_nlu
python setup.py install

echo "Step :4 Install MITIE....... "
cd ${maindir}
pip install git+https://github.com/mit-nlp/MITIE.git
wget https://github.com/mit-nlp/MITIE/releases/download/v0.4/MITIE-models-v0.2.tar.bz2
tar xvjf MITIE-models-v0.2.tar.bz2

cd app
mkdir models

cd rasa_nlu
mkdir data


:'
Once this is done create

config.json withfollowing content

{
 "backend": "mitie",
 "mitie_file": "/root/bot/MITIE-models/english/total_word_feature_extract",
 "path" : "/root/bot/models/",
 "write": "/root/bot/models",
 "server_model_dir" : "/root/bot/models/",
 "port":8050,
 "pipeline":["nlp_mitie", "tokenizer_mitie", "ner_mitie", "ner_synonyms",nt_classifier_mitie"]
}

and

config_mitie.json with

{
 "backend": "mitie",
 "mitie_file": "/root/bot/MITIE-models/english/total_word_feature_extractor.dat",
 "path" : "/root/bot/models",
 "data" : "/root/bot/rasa_nlu-master/data/examples/rasa/testData.json",
 "server_model_dir" : "/root/bot/models/",
 "pipeline":["nlp_mitie","tokenizer_mitie", "ner_mitie","ner_synonyms", "intent_classifier_mitie"]
}
'
