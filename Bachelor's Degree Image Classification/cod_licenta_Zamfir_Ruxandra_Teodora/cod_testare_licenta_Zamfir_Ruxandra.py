import numpy as np
import matplotlib.pyplot as plt
from keras import models
from keras.applications.vgg16 import VGG16
from keras.preprocessing.image import ImageDataGenerator
from keras.optimizers import Adam
from keras import layers
from matplotlib import pyplot
from keras.layers  import Conv2D, MaxPooling2D
from keras.models import Sequential
from keras.layers import Dense, Activation, Flatten, Dropout
from keras.models import load_model
from keras.callbacks import EarlyStopping
from sklearn.metrics import classification_report, confusion_matrix ,ConfusionMatrixDisplay

####################################Testare set extins###################################

director_model = r"C:\Users\Ruxi\Desktop\modele\model_clasificare_cnn_imbunatatit_95.tf"
# director_model = r"C:\Users\Ruxi\Desktop\modele\model_clasificare_vgg16_97.tf"

model = load_model(director_model)
model.summary()
# director_testare = r"C:\Users\Ruxi\Desktop\Boli_Frunze\testare" #PlantVillage
director_testare = r"C:\Users\Ruxi\Desktop\testare_set_extins"

date_testare = ImageDataGenerator(rescale=1. / 255)
dimensiune_batch = 1
generator_testare = date_testare.flow_from_directory(director_testare,
                                                    batch_size = dimensiune_batch, class_mode='categorical')
####################################Testare###################################
dict_etichete = { 0 :"BlackMeasles", 1 :"BlackRot",  2 :"HealthyLeaf", 3 :"LeafBlight"}
pozitie_subplot=0
figura_noua=0
plt.figure(figsize=(15, 9), layout='constrained')
etichete_adevarate = []
for i in range(len(generator_testare)):

    imagine, eticheta = generator_testare.next()
    etichete_adevarate.append(np.argmax(eticheta, axis=1))
    predictii = model.predict(imagine)
    clase_prezise = np.argmax(predictii, axis=1)
    if pozitie_subplot < 10:
        pozitie_subplot += 1
        ax = plt.subplot(2, 5, pozitie_subplot)
        plt.imshow(imagine[0])
        titlu = r'Adevăr: ' + fr'$\bf{dict_etichete[np.argmax(eticheta[0])]}$'
        titlu += '\n'
        titlu += rf'Predicție: $\bf{dict_etichete[clase_prezise[0]]}$'
        plt.title(titlu, loc='left', fontsize=16)
        plt.axis('off')
    if pozitie_subplot == 10:
        figura_noua += 1
        plt.figure(figsize=(15, 9), layout='constrained')
        pozitie_subplot = 0


clase_concatenate = np.concatenate(etichete_adevarate)
clase_adevarate = np.array(clase_concatenate)

####################################Evaluare perfomanțe utilizând diferite metrici###################################
predictii = model.predict(generator_testare)
clase_prezise = np.argmax(predictii, axis=1)

matrice_confuzie = confusion_matrix(clase_adevarate, clase_prezise)

print("Matricea de confuzie:")
print(matrice_confuzie)

afișare_matrice = ConfusionMatrixDisplay(
                            confusion_matrix=matrice_confuzie,
                            display_labels=["BlackMeasles", "BlackRot", "HealthyLeaf", "LeafBlight"])
afișare_matrice.plot(cmap=plt.cm.Blues)

plt.gcf().set_size_inches(7, 4.8)
plt.xlabel('Etichete prezise')
plt.ylabel('Etichete adevărate')

raport_clasificare = classification_report(clase_adevarate, clase_prezise)

print("Raport de clasificare:")
print(raport_clasificare)

loss, acuratete = model.evaluate(generator_testare, verbose=1)
print("Acuratetea:", "{:.2f}".format(acuratete * 100))
plt.show()