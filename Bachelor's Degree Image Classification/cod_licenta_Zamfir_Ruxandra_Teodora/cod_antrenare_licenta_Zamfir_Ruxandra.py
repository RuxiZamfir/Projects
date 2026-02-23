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

####################################Încărcare date###################################

director_antrenare = r"C:\Users\Ruxi\Desktop\Boli_Frunze\antrenare"
director_validare = r"C:\Users\Ruxi\Desktop\Boli_Frunze\validare"
director_testare = r"C:\Users\Ruxi\Desktop\Boli_Frunze\testare"

date_antrenare = ImageDataGenerator(rescale=1. / 255)
date_validare = ImageDataGenerator(rescale=1. / 255)
date_testare = ImageDataGenerator(rescale=1. / 255)

dimensiune_batch = 8
generator_antrenare = date_antrenare.flow_from_directory(director_antrenare,
                                                    batch_size = dimensiune_batch, class_mode='categorical')
generator_validare = date_validare.flow_from_directory(director_validare,
                                                    batch_size = dimensiune_batch, class_mode='categorical')
generator_testare = date_testare.flow_from_directory(director_testare,
                                                    batch_size = dimensiune_batch, class_mode='categorical')

for batch_date, batch_etichete in generator_antrenare:
    print('Dimensiunea lotului de date pentru antrenare, validare și testare: ', batch_date.shape)
    print('Dimensiunea lotului de etichete pentru antrenare, validare și testare: ', batch_etichete.shape)
    break
for batch_date, batch_etichete in generator_validare:
    print('Dimensiunea batch-ului de date în validare: ', batch_date.shape)
    print('Dimensiunea batch-ului de etichete în validare: ', batch_etichete.shape)
    break
for batch_date, batch_etichete in generator_testare:
    print('Dimensiunea batch-ului de date în testare: ', batch_date.shape)
    print('Dimensiunea batch-ului de etichete în testare: ', batch_etichete.shape)
    break

####################################Definire modele###################################

def definireModelCNN():

    modelCNN = models.Sequential()

    modelCNN.add(layers.Conv2D(32, input_shape=(256, 256, 3), kernel_size=(3, 3),activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(32, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(64, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(64, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Flatten())
    modelCNN.add(layers.Dense(128, activation="relu"))
    modelCNN.add(layers.Dense(4, activation='softmax'))

    modelCNN.compile(loss='categorical_crossentropy', optimizer=Adam(learning_rate=1e-4), metrics=['accuracy'])
    modelCNN.summary()
    return modelCNN

def definireModelCNNImbunatatit():

    modelCNN = models.Sequential()

    modelCNN.add(layers.Conv2D(32, input_shape=(256, 256, 3), kernel_size=(3, 3),activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(32, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(64, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(64, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Conv2D(128, kernel_size=(3, 3), activation='relu'))
    modelCNN.add(layers.MaxPooling2D(pool_size=(2, 2)))

    modelCNN.add(layers.Flatten())
    modelCNN.add(Dropout(0.2))
    modelCNN.add(layers.Dense(128, activation="relu"))
    modelCNN.add(Dropout(0.2))
    modelCNN.add(layers.Dense(4, activation='softmax'))

    modelCNN.compile(loss='categorical_crossentropy', optimizer=Adam(learning_rate=1e-4), metrics=['accuracy'])
    modelCNN.summary()
    return modelCNN

def definireModelVGGPreantrenat():

    modelPreantrenat = VGG16(weights='imagenet', include_top=False, input_shape=(256, 256, 3))
    modelPreantrenat.summary()

    for layer in modelPreantrenat.layers:
        layer.trainable = False

    modelVGG = models.Sequential()
    modelVGG.add(modelPreantrenat)

    modelVGG.add(Flatten())
    modelVGG.add(Dense(512, activation="relu"))
    modelVGG.add(Dropout(0.5))
    modelVGG.add(Dense(4, activation="softmax"))

    modelVGG.compile(loss='categorical_crossentropy', optimizer=Adam(learning_rate=1e-4), metrics=['accuracy'])
    modelVGG.summary()
    return modelVGG

###################################Antrenare###################################
model = definireModelCNN()
model = definireModelCNNImbunatatit()
model = definireModelVGGPreantrenat()

epoci = 50
early_stop = EarlyStopping(monitor='val_accuracy', patience=3, verbose=1, restore_best_weights=True)
istoric = model.fit(generator_antrenare, validation_data=generator_validare, epochs=epoci, callbacks=[early_stop])

###################################Vizualizare performanțe în antrenare###################################
def vizualizarePerformanteAntrenare(istoric):

    acc = istoric.history['accuracy']
    val_acc = istoric.history['val_accuracy']

    loss = istoric.history['loss']
    val_loss = istoric.history['val_loss']

    epochs = range(1, len(acc) + 1)
    plt.figure(figsize=(15,5))
    plt.subplot(121)
    plt.title('Acuratețea pe antrenare și validare')
    plt.plot(epochs, acc, 'g', label = 'Acuratețea pe antrenare')
    plt.plot(epochs, val_acc, 'r', label = 'Acuratețea pe validare')
    plt.legend()

    plt.subplot(122)
    plt.title('Loss pe antrenare și validare')
    plt.plot(epochs, loss, 'g', label = 'Loss pe antrenare')
    plt.plot(epochs, val_loss, 'r', label = 'Loss pe validare')
    plt.legend()

    return
vizualizarePerformanteAntrenare(istoric)

####################################Testare###################################
etichete_adevarate = []
for i in range(len(generator_testare)):

    imagine, eticheta = generator_testare.next()
    etichete_adevarate.append(np.argmax(eticheta, axis=1))

clase_concatenate = np.concatenate(etichete_adevarate)
clase_adevarate = np.array(clase_concatenate)

####################################Evaluare performanțe utilizând diferite metrici###################################
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