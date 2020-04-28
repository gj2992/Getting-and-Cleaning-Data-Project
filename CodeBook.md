CodeBook
================
Gregory Julock
4/26/2020

## Getting and Cleaning Data Course Project

### Introduction

The purpose of this project is to demonstrate the ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. This project provides the following: 1)
a tidy data set as described below, 2) a link to a Github repository
with a script for performing the analysis, and 3) a code book that
describes the variables, the data, and any transformations or work that
you performed to clean up the data called CodeBook.md. There is a
README.md in the repo with the scripts. This repo explains how all of
the scripts work and how they are connected.

Project Description: One of the most exciting areas in all of data
science right now is wearable computing - see for example this article .
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the
most advanced algorithms to attract new users. The data linked to from
the course website represent data collected from the accelerometers from
the Samsung Galaxy S smartphone.

### Data preparation

A full description is available at the site where the data was obtained
from at:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Data retrieved for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Used the following libraries:

``` r
library(data.table)
library(dplyr)
library(tidyverse)
```

### Dataset Features

According to the dataset’s features\_info file: The features selected
for this database come from the accelerometer and gyroscope 3-axial raw
signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to
denote time) were captured at a constant rate of 50 Hz. Then they were
filtered using a median filter and a 3rd order low pass Butterworth
filter with a corner frequency of 20 Hz to remove noise. Similarly, the
acceleration signal was then separated into body and gravity
acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another
low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for
each pattern:  
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ tGravityAcc-XYZ tBodyAccJerk-XYZ tBodyGyro-XYZ
tBodyGyroJerk-XYZ tBodyAccMag tGravityAccMag tBodyAccJerkMag
tBodyGyroMag tBodyGyroJerkMag fBodyAcc-XYZ fBodyAccJerk-XYZ
fBodyGyro-XYZ fBodyAccMag fBodyAccJerkMag fBodyGyroMag fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

mean(): Mean value std(): Standard deviation mad(): Median absolute
deviation max(): Largest value in array min(): Smallest value in array
sma(): Signal magnitude area energy(): Energy measure. Sum of the
squares divided by the number of values. iqr(): Interquartile range
entropy(): Signal entropy arCoeff(): Autorregresion coefficients with
Burg order equal to 4 correlation(): correlation coefficient between two
signals maxInds(): index of the frequency component with largest
magnitude meanFreq(): Weighted average of the frequency components to
obtain a mean frequency skewness(): skewness of the frequency domain
signal kurtosis(): kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the
FFT of each window. angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window
sample. These are used on the angle() variable:

gravityMean tBodyAccMean tBodyAccJerkMean tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in
‘features.txt’

The list of features for the research are:

``` r
listoffeatures <- fread("./UCI HAR Dataset/features.txt")
select(listoffeatures,2) %>% print(1:nrow(listoffeatures))
```

    ##                                        V2
    ##   1:                    tBodyAcc-mean()-X
    ##   2:                    tBodyAcc-mean()-Y
    ##   3:                    tBodyAcc-mean()-Z
    ##   4:                     tBodyAcc-std()-X
    ##   5:                     tBodyAcc-std()-Y
    ##   6:                     tBodyAcc-std()-Z
    ##   7:                     tBodyAcc-mad()-X
    ##   8:                     tBodyAcc-mad()-Y
    ##   9:                     tBodyAcc-mad()-Z
    ##  10:                     tBodyAcc-max()-X
    ##  11:                     tBodyAcc-max()-Y
    ##  12:                     tBodyAcc-max()-Z
    ##  13:                     tBodyAcc-min()-X
    ##  14:                     tBodyAcc-min()-Y
    ##  15:                     tBodyAcc-min()-Z
    ##  16:                       tBodyAcc-sma()
    ##  17:                  tBodyAcc-energy()-X
    ##  18:                  tBodyAcc-energy()-Y
    ##  19:                  tBodyAcc-energy()-Z
    ##  20:                     tBodyAcc-iqr()-X
    ##  21:                     tBodyAcc-iqr()-Y
    ##  22:                     tBodyAcc-iqr()-Z
    ##  23:                 tBodyAcc-entropy()-X
    ##  24:                 tBodyAcc-entropy()-Y
    ##  25:                 tBodyAcc-entropy()-Z
    ##  26:               tBodyAcc-arCoeff()-X,1
    ##  27:               tBodyAcc-arCoeff()-X,2
    ##  28:               tBodyAcc-arCoeff()-X,3
    ##  29:               tBodyAcc-arCoeff()-X,4
    ##  30:               tBodyAcc-arCoeff()-Y,1
    ##  31:               tBodyAcc-arCoeff()-Y,2
    ##  32:               tBodyAcc-arCoeff()-Y,3
    ##  33:               tBodyAcc-arCoeff()-Y,4
    ##  34:               tBodyAcc-arCoeff()-Z,1
    ##  35:               tBodyAcc-arCoeff()-Z,2
    ##  36:               tBodyAcc-arCoeff()-Z,3
    ##  37:               tBodyAcc-arCoeff()-Z,4
    ##  38:           tBodyAcc-correlation()-X,Y
    ##  39:           tBodyAcc-correlation()-X,Z
    ##  40:           tBodyAcc-correlation()-Y,Z
    ##  41:                 tGravityAcc-mean()-X
    ##  42:                 tGravityAcc-mean()-Y
    ##  43:                 tGravityAcc-mean()-Z
    ##  44:                  tGravityAcc-std()-X
    ##  45:                  tGravityAcc-std()-Y
    ##  46:                  tGravityAcc-std()-Z
    ##  47:                  tGravityAcc-mad()-X
    ##  48:                  tGravityAcc-mad()-Y
    ##  49:                  tGravityAcc-mad()-Z
    ##  50:                  tGravityAcc-max()-X
    ##  51:                  tGravityAcc-max()-Y
    ##  52:                  tGravityAcc-max()-Z
    ##  53:                  tGravityAcc-min()-X
    ##  54:                  tGravityAcc-min()-Y
    ##  55:                  tGravityAcc-min()-Z
    ##  56:                    tGravityAcc-sma()
    ##  57:               tGravityAcc-energy()-X
    ##  58:               tGravityAcc-energy()-Y
    ##  59:               tGravityAcc-energy()-Z
    ##  60:                  tGravityAcc-iqr()-X
    ##  61:                  tGravityAcc-iqr()-Y
    ##  62:                  tGravityAcc-iqr()-Z
    ##  63:              tGravityAcc-entropy()-X
    ##  64:              tGravityAcc-entropy()-Y
    ##  65:              tGravityAcc-entropy()-Z
    ##  66:            tGravityAcc-arCoeff()-X,1
    ##  67:            tGravityAcc-arCoeff()-X,2
    ##  68:            tGravityAcc-arCoeff()-X,3
    ##  69:            tGravityAcc-arCoeff()-X,4
    ##  70:            tGravityAcc-arCoeff()-Y,1
    ##  71:            tGravityAcc-arCoeff()-Y,2
    ##  72:            tGravityAcc-arCoeff()-Y,3
    ##  73:            tGravityAcc-arCoeff()-Y,4
    ##  74:            tGravityAcc-arCoeff()-Z,1
    ##  75:            tGravityAcc-arCoeff()-Z,2
    ##  76:            tGravityAcc-arCoeff()-Z,3
    ##  77:            tGravityAcc-arCoeff()-Z,4
    ##  78:        tGravityAcc-correlation()-X,Y
    ##  79:        tGravityAcc-correlation()-X,Z
    ##  80:        tGravityAcc-correlation()-Y,Z
    ##  81:                tBodyAccJerk-mean()-X
    ##  82:                tBodyAccJerk-mean()-Y
    ##  83:                tBodyAccJerk-mean()-Z
    ##  84:                 tBodyAccJerk-std()-X
    ##  85:                 tBodyAccJerk-std()-Y
    ##  86:                 tBodyAccJerk-std()-Z
    ##  87:                 tBodyAccJerk-mad()-X
    ##  88:                 tBodyAccJerk-mad()-Y
    ##  89:                 tBodyAccJerk-mad()-Z
    ##  90:                 tBodyAccJerk-max()-X
    ##  91:                 tBodyAccJerk-max()-Y
    ##  92:                 tBodyAccJerk-max()-Z
    ##  93:                 tBodyAccJerk-min()-X
    ##  94:                 tBodyAccJerk-min()-Y
    ##  95:                 tBodyAccJerk-min()-Z
    ##  96:                   tBodyAccJerk-sma()
    ##  97:              tBodyAccJerk-energy()-X
    ##  98:              tBodyAccJerk-energy()-Y
    ##  99:              tBodyAccJerk-energy()-Z
    ## 100:                 tBodyAccJerk-iqr()-X
    ## 101:                 tBodyAccJerk-iqr()-Y
    ## 102:                 tBodyAccJerk-iqr()-Z
    ## 103:             tBodyAccJerk-entropy()-X
    ## 104:             tBodyAccJerk-entropy()-Y
    ## 105:             tBodyAccJerk-entropy()-Z
    ## 106:           tBodyAccJerk-arCoeff()-X,1
    ## 107:           tBodyAccJerk-arCoeff()-X,2
    ## 108:           tBodyAccJerk-arCoeff()-X,3
    ## 109:           tBodyAccJerk-arCoeff()-X,4
    ## 110:           tBodyAccJerk-arCoeff()-Y,1
    ## 111:           tBodyAccJerk-arCoeff()-Y,2
    ## 112:           tBodyAccJerk-arCoeff()-Y,3
    ## 113:           tBodyAccJerk-arCoeff()-Y,4
    ## 114:           tBodyAccJerk-arCoeff()-Z,1
    ## 115:           tBodyAccJerk-arCoeff()-Z,2
    ## 116:           tBodyAccJerk-arCoeff()-Z,3
    ## 117:           tBodyAccJerk-arCoeff()-Z,4
    ## 118:       tBodyAccJerk-correlation()-X,Y
    ## 119:       tBodyAccJerk-correlation()-X,Z
    ## 120:       tBodyAccJerk-correlation()-Y,Z
    ## 121:                   tBodyGyro-mean()-X
    ## 122:                   tBodyGyro-mean()-Y
    ## 123:                   tBodyGyro-mean()-Z
    ## 124:                    tBodyGyro-std()-X
    ## 125:                    tBodyGyro-std()-Y
    ## 126:                    tBodyGyro-std()-Z
    ## 127:                    tBodyGyro-mad()-X
    ## 128:                    tBodyGyro-mad()-Y
    ## 129:                    tBodyGyro-mad()-Z
    ## 130:                    tBodyGyro-max()-X
    ## 131:                    tBodyGyro-max()-Y
    ## 132:                    tBodyGyro-max()-Z
    ## 133:                    tBodyGyro-min()-X
    ## 134:                    tBodyGyro-min()-Y
    ## 135:                    tBodyGyro-min()-Z
    ## 136:                      tBodyGyro-sma()
    ## 137:                 tBodyGyro-energy()-X
    ## 138:                 tBodyGyro-energy()-Y
    ## 139:                 tBodyGyro-energy()-Z
    ## 140:                    tBodyGyro-iqr()-X
    ## 141:                    tBodyGyro-iqr()-Y
    ## 142:                    tBodyGyro-iqr()-Z
    ## 143:                tBodyGyro-entropy()-X
    ## 144:                tBodyGyro-entropy()-Y
    ## 145:                tBodyGyro-entropy()-Z
    ## 146:              tBodyGyro-arCoeff()-X,1
    ## 147:              tBodyGyro-arCoeff()-X,2
    ## 148:              tBodyGyro-arCoeff()-X,3
    ## 149:              tBodyGyro-arCoeff()-X,4
    ## 150:              tBodyGyro-arCoeff()-Y,1
    ## 151:              tBodyGyro-arCoeff()-Y,2
    ## 152:              tBodyGyro-arCoeff()-Y,3
    ## 153:              tBodyGyro-arCoeff()-Y,4
    ## 154:              tBodyGyro-arCoeff()-Z,1
    ## 155:              tBodyGyro-arCoeff()-Z,2
    ## 156:              tBodyGyro-arCoeff()-Z,3
    ## 157:              tBodyGyro-arCoeff()-Z,4
    ## 158:          tBodyGyro-correlation()-X,Y
    ## 159:          tBodyGyro-correlation()-X,Z
    ## 160:          tBodyGyro-correlation()-Y,Z
    ## 161:               tBodyGyroJerk-mean()-X
    ## 162:               tBodyGyroJerk-mean()-Y
    ## 163:               tBodyGyroJerk-mean()-Z
    ## 164:                tBodyGyroJerk-std()-X
    ## 165:                tBodyGyroJerk-std()-Y
    ## 166:                tBodyGyroJerk-std()-Z
    ## 167:                tBodyGyroJerk-mad()-X
    ## 168:                tBodyGyroJerk-mad()-Y
    ## 169:                tBodyGyroJerk-mad()-Z
    ## 170:                tBodyGyroJerk-max()-X
    ## 171:                tBodyGyroJerk-max()-Y
    ## 172:                tBodyGyroJerk-max()-Z
    ## 173:                tBodyGyroJerk-min()-X
    ## 174:                tBodyGyroJerk-min()-Y
    ## 175:                tBodyGyroJerk-min()-Z
    ## 176:                  tBodyGyroJerk-sma()
    ## 177:             tBodyGyroJerk-energy()-X
    ## 178:             tBodyGyroJerk-energy()-Y
    ## 179:             tBodyGyroJerk-energy()-Z
    ## 180:                tBodyGyroJerk-iqr()-X
    ## 181:                tBodyGyroJerk-iqr()-Y
    ## 182:                tBodyGyroJerk-iqr()-Z
    ## 183:            tBodyGyroJerk-entropy()-X
    ## 184:            tBodyGyroJerk-entropy()-Y
    ## 185:            tBodyGyroJerk-entropy()-Z
    ## 186:          tBodyGyroJerk-arCoeff()-X,1
    ## 187:          tBodyGyroJerk-arCoeff()-X,2
    ## 188:          tBodyGyroJerk-arCoeff()-X,3
    ## 189:          tBodyGyroJerk-arCoeff()-X,4
    ## 190:          tBodyGyroJerk-arCoeff()-Y,1
    ## 191:          tBodyGyroJerk-arCoeff()-Y,2
    ## 192:          tBodyGyroJerk-arCoeff()-Y,3
    ## 193:          tBodyGyroJerk-arCoeff()-Y,4
    ## 194:          tBodyGyroJerk-arCoeff()-Z,1
    ## 195:          tBodyGyroJerk-arCoeff()-Z,2
    ## 196:          tBodyGyroJerk-arCoeff()-Z,3
    ## 197:          tBodyGyroJerk-arCoeff()-Z,4
    ## 198:      tBodyGyroJerk-correlation()-X,Y
    ## 199:      tBodyGyroJerk-correlation()-X,Z
    ## 200:      tBodyGyroJerk-correlation()-Y,Z
    ## 201:                   tBodyAccMag-mean()
    ## 202:                    tBodyAccMag-std()
    ## 203:                    tBodyAccMag-mad()
    ## 204:                    tBodyAccMag-max()
    ## 205:                    tBodyAccMag-min()
    ## 206:                    tBodyAccMag-sma()
    ## 207:                 tBodyAccMag-energy()
    ## 208:                    tBodyAccMag-iqr()
    ## 209:                tBodyAccMag-entropy()
    ## 210:               tBodyAccMag-arCoeff()1
    ## 211:               tBodyAccMag-arCoeff()2
    ## 212:               tBodyAccMag-arCoeff()3
    ## 213:               tBodyAccMag-arCoeff()4
    ## 214:                tGravityAccMag-mean()
    ## 215:                 tGravityAccMag-std()
    ## 216:                 tGravityAccMag-mad()
    ## 217:                 tGravityAccMag-max()
    ## 218:                 tGravityAccMag-min()
    ## 219:                 tGravityAccMag-sma()
    ## 220:              tGravityAccMag-energy()
    ## 221:                 tGravityAccMag-iqr()
    ## 222:             tGravityAccMag-entropy()
    ## 223:            tGravityAccMag-arCoeff()1
    ## 224:            tGravityAccMag-arCoeff()2
    ## 225:            tGravityAccMag-arCoeff()3
    ## 226:            tGravityAccMag-arCoeff()4
    ## 227:               tBodyAccJerkMag-mean()
    ## 228:                tBodyAccJerkMag-std()
    ## 229:                tBodyAccJerkMag-mad()
    ## 230:                tBodyAccJerkMag-max()
    ## 231:                tBodyAccJerkMag-min()
    ## 232:                tBodyAccJerkMag-sma()
    ## 233:             tBodyAccJerkMag-energy()
    ## 234:                tBodyAccJerkMag-iqr()
    ## 235:            tBodyAccJerkMag-entropy()
    ## 236:           tBodyAccJerkMag-arCoeff()1
    ## 237:           tBodyAccJerkMag-arCoeff()2
    ## 238:           tBodyAccJerkMag-arCoeff()3
    ## 239:           tBodyAccJerkMag-arCoeff()4
    ## 240:                  tBodyGyroMag-mean()
    ## 241:                   tBodyGyroMag-std()
    ## 242:                   tBodyGyroMag-mad()
    ## 243:                   tBodyGyroMag-max()
    ## 244:                   tBodyGyroMag-min()
    ## 245:                   tBodyGyroMag-sma()
    ## 246:                tBodyGyroMag-energy()
    ## 247:                   tBodyGyroMag-iqr()
    ## 248:               tBodyGyroMag-entropy()
    ## 249:              tBodyGyroMag-arCoeff()1
    ## 250:              tBodyGyroMag-arCoeff()2
    ## 251:              tBodyGyroMag-arCoeff()3
    ## 252:              tBodyGyroMag-arCoeff()4
    ## 253:              tBodyGyroJerkMag-mean()
    ## 254:               tBodyGyroJerkMag-std()
    ## 255:               tBodyGyroJerkMag-mad()
    ## 256:               tBodyGyroJerkMag-max()
    ## 257:               tBodyGyroJerkMag-min()
    ## 258:               tBodyGyroJerkMag-sma()
    ## 259:            tBodyGyroJerkMag-energy()
    ## 260:               tBodyGyroJerkMag-iqr()
    ## 261:           tBodyGyroJerkMag-entropy()
    ## 262:          tBodyGyroJerkMag-arCoeff()1
    ## 263:          tBodyGyroJerkMag-arCoeff()2
    ## 264:          tBodyGyroJerkMag-arCoeff()3
    ## 265:          tBodyGyroJerkMag-arCoeff()4
    ## 266:                    fBodyAcc-mean()-X
    ## 267:                    fBodyAcc-mean()-Y
    ## 268:                    fBodyAcc-mean()-Z
    ## 269:                     fBodyAcc-std()-X
    ## 270:                     fBodyAcc-std()-Y
    ## 271:                     fBodyAcc-std()-Z
    ## 272:                     fBodyAcc-mad()-X
    ## 273:                     fBodyAcc-mad()-Y
    ## 274:                     fBodyAcc-mad()-Z
    ## 275:                     fBodyAcc-max()-X
    ## 276:                     fBodyAcc-max()-Y
    ## 277:                     fBodyAcc-max()-Z
    ## 278:                     fBodyAcc-min()-X
    ## 279:                     fBodyAcc-min()-Y
    ## 280:                     fBodyAcc-min()-Z
    ## 281:                       fBodyAcc-sma()
    ## 282:                  fBodyAcc-energy()-X
    ## 283:                  fBodyAcc-energy()-Y
    ## 284:                  fBodyAcc-energy()-Z
    ## 285:                     fBodyAcc-iqr()-X
    ## 286:                     fBodyAcc-iqr()-Y
    ## 287:                     fBodyAcc-iqr()-Z
    ## 288:                 fBodyAcc-entropy()-X
    ## 289:                 fBodyAcc-entropy()-Y
    ## 290:                 fBodyAcc-entropy()-Z
    ## 291:                   fBodyAcc-maxInds-X
    ## 292:                   fBodyAcc-maxInds-Y
    ## 293:                   fBodyAcc-maxInds-Z
    ## 294:                fBodyAcc-meanFreq()-X
    ## 295:                fBodyAcc-meanFreq()-Y
    ## 296:                fBodyAcc-meanFreq()-Z
    ## 297:                fBodyAcc-skewness()-X
    ## 298:                fBodyAcc-kurtosis()-X
    ## 299:                fBodyAcc-skewness()-Y
    ## 300:                fBodyAcc-kurtosis()-Y
    ## 301:                fBodyAcc-skewness()-Z
    ## 302:                fBodyAcc-kurtosis()-Z
    ## 303:           fBodyAcc-bandsEnergy()-1,8
    ## 304:          fBodyAcc-bandsEnergy()-9,16
    ## 305:         fBodyAcc-bandsEnergy()-17,24
    ## 306:         fBodyAcc-bandsEnergy()-25,32
    ## 307:         fBodyAcc-bandsEnergy()-33,40
    ## 308:         fBodyAcc-bandsEnergy()-41,48
    ## 309:         fBodyAcc-bandsEnergy()-49,56
    ## 310:         fBodyAcc-bandsEnergy()-57,64
    ## 311:          fBodyAcc-bandsEnergy()-1,16
    ## 312:         fBodyAcc-bandsEnergy()-17,32
    ## 313:         fBodyAcc-bandsEnergy()-33,48
    ## 314:         fBodyAcc-bandsEnergy()-49,64
    ## 315:          fBodyAcc-bandsEnergy()-1,24
    ## 316:         fBodyAcc-bandsEnergy()-25,48
    ## 317:           fBodyAcc-bandsEnergy()-1,8
    ## 318:          fBodyAcc-bandsEnergy()-9,16
    ## 319:         fBodyAcc-bandsEnergy()-17,24
    ## 320:         fBodyAcc-bandsEnergy()-25,32
    ## 321:         fBodyAcc-bandsEnergy()-33,40
    ## 322:         fBodyAcc-bandsEnergy()-41,48
    ## 323:         fBodyAcc-bandsEnergy()-49,56
    ## 324:         fBodyAcc-bandsEnergy()-57,64
    ## 325:          fBodyAcc-bandsEnergy()-1,16
    ## 326:         fBodyAcc-bandsEnergy()-17,32
    ## 327:         fBodyAcc-bandsEnergy()-33,48
    ## 328:         fBodyAcc-bandsEnergy()-49,64
    ## 329:          fBodyAcc-bandsEnergy()-1,24
    ## 330:         fBodyAcc-bandsEnergy()-25,48
    ## 331:           fBodyAcc-bandsEnergy()-1,8
    ## 332:          fBodyAcc-bandsEnergy()-9,16
    ## 333:         fBodyAcc-bandsEnergy()-17,24
    ## 334:         fBodyAcc-bandsEnergy()-25,32
    ## 335:         fBodyAcc-bandsEnergy()-33,40
    ## 336:         fBodyAcc-bandsEnergy()-41,48
    ## 337:         fBodyAcc-bandsEnergy()-49,56
    ## 338:         fBodyAcc-bandsEnergy()-57,64
    ## 339:          fBodyAcc-bandsEnergy()-1,16
    ## 340:         fBodyAcc-bandsEnergy()-17,32
    ## 341:         fBodyAcc-bandsEnergy()-33,48
    ## 342:         fBodyAcc-bandsEnergy()-49,64
    ## 343:          fBodyAcc-bandsEnergy()-1,24
    ## 344:         fBodyAcc-bandsEnergy()-25,48
    ## 345:                fBodyAccJerk-mean()-X
    ## 346:                fBodyAccJerk-mean()-Y
    ## 347:                fBodyAccJerk-mean()-Z
    ## 348:                 fBodyAccJerk-std()-X
    ## 349:                 fBodyAccJerk-std()-Y
    ## 350:                 fBodyAccJerk-std()-Z
    ## 351:                 fBodyAccJerk-mad()-X
    ## 352:                 fBodyAccJerk-mad()-Y
    ## 353:                 fBodyAccJerk-mad()-Z
    ## 354:                 fBodyAccJerk-max()-X
    ## 355:                 fBodyAccJerk-max()-Y
    ## 356:                 fBodyAccJerk-max()-Z
    ## 357:                 fBodyAccJerk-min()-X
    ## 358:                 fBodyAccJerk-min()-Y
    ## 359:                 fBodyAccJerk-min()-Z
    ## 360:                   fBodyAccJerk-sma()
    ## 361:              fBodyAccJerk-energy()-X
    ## 362:              fBodyAccJerk-energy()-Y
    ## 363:              fBodyAccJerk-energy()-Z
    ## 364:                 fBodyAccJerk-iqr()-X
    ## 365:                 fBodyAccJerk-iqr()-Y
    ## 366:                 fBodyAccJerk-iqr()-Z
    ## 367:             fBodyAccJerk-entropy()-X
    ## 368:             fBodyAccJerk-entropy()-Y
    ## 369:             fBodyAccJerk-entropy()-Z
    ## 370:               fBodyAccJerk-maxInds-X
    ## 371:               fBodyAccJerk-maxInds-Y
    ## 372:               fBodyAccJerk-maxInds-Z
    ## 373:            fBodyAccJerk-meanFreq()-X
    ## 374:            fBodyAccJerk-meanFreq()-Y
    ## 375:            fBodyAccJerk-meanFreq()-Z
    ## 376:            fBodyAccJerk-skewness()-X
    ## 377:            fBodyAccJerk-kurtosis()-X
    ## 378:            fBodyAccJerk-skewness()-Y
    ## 379:            fBodyAccJerk-kurtosis()-Y
    ## 380:            fBodyAccJerk-skewness()-Z
    ## 381:            fBodyAccJerk-kurtosis()-Z
    ## 382:       fBodyAccJerk-bandsEnergy()-1,8
    ## 383:      fBodyAccJerk-bandsEnergy()-9,16
    ## 384:     fBodyAccJerk-bandsEnergy()-17,24
    ## 385:     fBodyAccJerk-bandsEnergy()-25,32
    ## 386:     fBodyAccJerk-bandsEnergy()-33,40
    ## 387:     fBodyAccJerk-bandsEnergy()-41,48
    ## 388:     fBodyAccJerk-bandsEnergy()-49,56
    ## 389:     fBodyAccJerk-bandsEnergy()-57,64
    ## 390:      fBodyAccJerk-bandsEnergy()-1,16
    ## 391:     fBodyAccJerk-bandsEnergy()-17,32
    ## 392:     fBodyAccJerk-bandsEnergy()-33,48
    ## 393:     fBodyAccJerk-bandsEnergy()-49,64
    ## 394:      fBodyAccJerk-bandsEnergy()-1,24
    ## 395:     fBodyAccJerk-bandsEnergy()-25,48
    ## 396:       fBodyAccJerk-bandsEnergy()-1,8
    ## 397:      fBodyAccJerk-bandsEnergy()-9,16
    ## 398:     fBodyAccJerk-bandsEnergy()-17,24
    ## 399:     fBodyAccJerk-bandsEnergy()-25,32
    ## 400:     fBodyAccJerk-bandsEnergy()-33,40
    ## 401:     fBodyAccJerk-bandsEnergy()-41,48
    ## 402:     fBodyAccJerk-bandsEnergy()-49,56
    ## 403:     fBodyAccJerk-bandsEnergy()-57,64
    ## 404:      fBodyAccJerk-bandsEnergy()-1,16
    ## 405:     fBodyAccJerk-bandsEnergy()-17,32
    ## 406:     fBodyAccJerk-bandsEnergy()-33,48
    ## 407:     fBodyAccJerk-bandsEnergy()-49,64
    ## 408:      fBodyAccJerk-bandsEnergy()-1,24
    ## 409:     fBodyAccJerk-bandsEnergy()-25,48
    ## 410:       fBodyAccJerk-bandsEnergy()-1,8
    ## 411:      fBodyAccJerk-bandsEnergy()-9,16
    ## 412:     fBodyAccJerk-bandsEnergy()-17,24
    ## 413:     fBodyAccJerk-bandsEnergy()-25,32
    ## 414:     fBodyAccJerk-bandsEnergy()-33,40
    ## 415:     fBodyAccJerk-bandsEnergy()-41,48
    ## 416:     fBodyAccJerk-bandsEnergy()-49,56
    ## 417:     fBodyAccJerk-bandsEnergy()-57,64
    ## 418:      fBodyAccJerk-bandsEnergy()-1,16
    ## 419:     fBodyAccJerk-bandsEnergy()-17,32
    ## 420:     fBodyAccJerk-bandsEnergy()-33,48
    ## 421:     fBodyAccJerk-bandsEnergy()-49,64
    ## 422:      fBodyAccJerk-bandsEnergy()-1,24
    ## 423:     fBodyAccJerk-bandsEnergy()-25,48
    ## 424:                   fBodyGyro-mean()-X
    ## 425:                   fBodyGyro-mean()-Y
    ## 426:                   fBodyGyro-mean()-Z
    ## 427:                    fBodyGyro-std()-X
    ## 428:                    fBodyGyro-std()-Y
    ## 429:                    fBodyGyro-std()-Z
    ## 430:                    fBodyGyro-mad()-X
    ## 431:                    fBodyGyro-mad()-Y
    ## 432:                    fBodyGyro-mad()-Z
    ## 433:                    fBodyGyro-max()-X
    ## 434:                    fBodyGyro-max()-Y
    ## 435:                    fBodyGyro-max()-Z
    ## 436:                    fBodyGyro-min()-X
    ## 437:                    fBodyGyro-min()-Y
    ## 438:                    fBodyGyro-min()-Z
    ## 439:                      fBodyGyro-sma()
    ## 440:                 fBodyGyro-energy()-X
    ## 441:                 fBodyGyro-energy()-Y
    ## 442:                 fBodyGyro-energy()-Z
    ## 443:                    fBodyGyro-iqr()-X
    ## 444:                    fBodyGyro-iqr()-Y
    ## 445:                    fBodyGyro-iqr()-Z
    ## 446:                fBodyGyro-entropy()-X
    ## 447:                fBodyGyro-entropy()-Y
    ## 448:                fBodyGyro-entropy()-Z
    ## 449:                  fBodyGyro-maxInds-X
    ## 450:                  fBodyGyro-maxInds-Y
    ## 451:                  fBodyGyro-maxInds-Z
    ## 452:               fBodyGyro-meanFreq()-X
    ## 453:               fBodyGyro-meanFreq()-Y
    ## 454:               fBodyGyro-meanFreq()-Z
    ## 455:               fBodyGyro-skewness()-X
    ## 456:               fBodyGyro-kurtosis()-X
    ## 457:               fBodyGyro-skewness()-Y
    ## 458:               fBodyGyro-kurtosis()-Y
    ## 459:               fBodyGyro-skewness()-Z
    ## 460:               fBodyGyro-kurtosis()-Z
    ## 461:          fBodyGyro-bandsEnergy()-1,8
    ## 462:         fBodyGyro-bandsEnergy()-9,16
    ## 463:        fBodyGyro-bandsEnergy()-17,24
    ## 464:        fBodyGyro-bandsEnergy()-25,32
    ## 465:        fBodyGyro-bandsEnergy()-33,40
    ## 466:        fBodyGyro-bandsEnergy()-41,48
    ## 467:        fBodyGyro-bandsEnergy()-49,56
    ## 468:        fBodyGyro-bandsEnergy()-57,64
    ## 469:         fBodyGyro-bandsEnergy()-1,16
    ## 470:        fBodyGyro-bandsEnergy()-17,32
    ## 471:        fBodyGyro-bandsEnergy()-33,48
    ## 472:        fBodyGyro-bandsEnergy()-49,64
    ## 473:         fBodyGyro-bandsEnergy()-1,24
    ## 474:        fBodyGyro-bandsEnergy()-25,48
    ## 475:          fBodyGyro-bandsEnergy()-1,8
    ## 476:         fBodyGyro-bandsEnergy()-9,16
    ## 477:        fBodyGyro-bandsEnergy()-17,24
    ## 478:        fBodyGyro-bandsEnergy()-25,32
    ## 479:        fBodyGyro-bandsEnergy()-33,40
    ## 480:        fBodyGyro-bandsEnergy()-41,48
    ## 481:        fBodyGyro-bandsEnergy()-49,56
    ## 482:        fBodyGyro-bandsEnergy()-57,64
    ## 483:         fBodyGyro-bandsEnergy()-1,16
    ## 484:        fBodyGyro-bandsEnergy()-17,32
    ## 485:        fBodyGyro-bandsEnergy()-33,48
    ## 486:        fBodyGyro-bandsEnergy()-49,64
    ## 487:         fBodyGyro-bandsEnergy()-1,24
    ## 488:        fBodyGyro-bandsEnergy()-25,48
    ## 489:          fBodyGyro-bandsEnergy()-1,8
    ## 490:         fBodyGyro-bandsEnergy()-9,16
    ## 491:        fBodyGyro-bandsEnergy()-17,24
    ## 492:        fBodyGyro-bandsEnergy()-25,32
    ## 493:        fBodyGyro-bandsEnergy()-33,40
    ## 494:        fBodyGyro-bandsEnergy()-41,48
    ## 495:        fBodyGyro-bandsEnergy()-49,56
    ## 496:        fBodyGyro-bandsEnergy()-57,64
    ## 497:         fBodyGyro-bandsEnergy()-1,16
    ## 498:        fBodyGyro-bandsEnergy()-17,32
    ## 499:        fBodyGyro-bandsEnergy()-33,48
    ## 500:        fBodyGyro-bandsEnergy()-49,64
    ## 501:         fBodyGyro-bandsEnergy()-1,24
    ## 502:        fBodyGyro-bandsEnergy()-25,48
    ## 503:                   fBodyAccMag-mean()
    ## 504:                    fBodyAccMag-std()
    ## 505:                    fBodyAccMag-mad()
    ## 506:                    fBodyAccMag-max()
    ## 507:                    fBodyAccMag-min()
    ## 508:                    fBodyAccMag-sma()
    ## 509:                 fBodyAccMag-energy()
    ## 510:                    fBodyAccMag-iqr()
    ## 511:                fBodyAccMag-entropy()
    ## 512:                  fBodyAccMag-maxInds
    ## 513:               fBodyAccMag-meanFreq()
    ## 514:               fBodyAccMag-skewness()
    ## 515:               fBodyAccMag-kurtosis()
    ## 516:           fBodyBodyAccJerkMag-mean()
    ## 517:            fBodyBodyAccJerkMag-std()
    ## 518:            fBodyBodyAccJerkMag-mad()
    ## 519:            fBodyBodyAccJerkMag-max()
    ## 520:            fBodyBodyAccJerkMag-min()
    ## 521:            fBodyBodyAccJerkMag-sma()
    ## 522:         fBodyBodyAccJerkMag-energy()
    ## 523:            fBodyBodyAccJerkMag-iqr()
    ## 524:        fBodyBodyAccJerkMag-entropy()
    ## 525:          fBodyBodyAccJerkMag-maxInds
    ## 526:       fBodyBodyAccJerkMag-meanFreq()
    ## 527:       fBodyBodyAccJerkMag-skewness()
    ## 528:       fBodyBodyAccJerkMag-kurtosis()
    ## 529:              fBodyBodyGyroMag-mean()
    ## 530:               fBodyBodyGyroMag-std()
    ## 531:               fBodyBodyGyroMag-mad()
    ## 532:               fBodyBodyGyroMag-max()
    ## 533:               fBodyBodyGyroMag-min()
    ## 534:               fBodyBodyGyroMag-sma()
    ## 535:            fBodyBodyGyroMag-energy()
    ## 536:               fBodyBodyGyroMag-iqr()
    ## 537:           fBodyBodyGyroMag-entropy()
    ## 538:             fBodyBodyGyroMag-maxInds
    ## 539:          fBodyBodyGyroMag-meanFreq()
    ## 540:          fBodyBodyGyroMag-skewness()
    ## 541:          fBodyBodyGyroMag-kurtosis()
    ## 542:          fBodyBodyGyroJerkMag-mean()
    ## 543:           fBodyBodyGyroJerkMag-std()
    ## 544:           fBodyBodyGyroJerkMag-mad()
    ## 545:           fBodyBodyGyroJerkMag-max()
    ## 546:           fBodyBodyGyroJerkMag-min()
    ## 547:           fBodyBodyGyroJerkMag-sma()
    ## 548:        fBodyBodyGyroJerkMag-energy()
    ## 549:           fBodyBodyGyroJerkMag-iqr()
    ## 550:       fBodyBodyGyroJerkMag-entropy()
    ## 551:         fBodyBodyGyroJerkMag-maxInds
    ## 552:      fBodyBodyGyroJerkMag-meanFreq()
    ## 553:      fBodyBodyGyroJerkMag-skewness()
    ## 554:      fBodyBodyGyroJerkMag-kurtosis()
    ## 555:          angle(tBodyAccMean,gravity)
    ## 556: angle(tBodyAccJerkMean),gravityMean)
    ## 557:     angle(tBodyGyroMean,gravityMean)
    ## 558: angle(tBodyGyroJerkMean,gravityMean)
    ## 559:                 angle(X,gravityMean)
    ## 560:                 angle(Y,gravityMean)
    ## 561:                 angle(Z,gravityMean)
    ##                                        V2

The list of Activities for each subject are:

``` r
activitylables <- fread("./UCI HAR Dataset/activity_labels.txt")
#print(activitylables,1:n(activitylables$V2))
select(activitylables,2) %>% print(1:nrow(activitylables))
```

    ##                    V2
    ## 1:            WALKING
    ## 2:   WALKING_UPSTAIRS
    ## 3: WALKING_DOWNSTAIRS
    ## 4:            SITTING
    ## 5:           STANDING
    ## 6:             LAYING

### Dataset Files

The dataset files consisted of the following: - ‘features.txt’: List of
all features.

  - ‘activity\_labels.txt’: Links the class labels with their activity
    name.

  - ‘train/X\_train.txt’: Training set.

  - ‘train/y\_train.txt’: Training labels.

  - ‘test/X\_test.txt’: Test set.

  - ‘test/y\_test.txt’: Test labels.

  - ‘train/subject\_train.txt’: Each row identifies the subject who
    performed the activity for each window sample. Its range is from 1
    to 30.

The research data consisted of training and testing data set which were
imported into dataframes:

``` r
trainsetx <- fread("./UCI HAR Dataset/train/X_train.txt")
trainlabelsety <- fread("./UCI HAR Dataset/train/y_train.txt")
trainsubject <- fread("UCI HAR Dataset/train/subject_train.txt")
testingsetx <- fread("UCI HAR Dataset/test/X_test.txt")
testlabelsety <-fread("UCI HAR Dataset/test/y_test.txt")
testsubject <- fread("UCI HAR Dataset/test/subject_test.txt")
```

### 1\. Merges the training and the test sets to create one data set.

``` r
#combine sub datasets
activity <- rbind(trainlabelsety,testlabelsety)
features <- rbind(trainsetx,testingsetx)
subject <- rbind(trainsubject,testsubject)
#set column names 
colnames(activity) <- "V2"
# transpose the column of feature names and set the feature column names
colnames(features) <- t(listoffeatures[,2])
#combine (Merge) into one dataset
combineddataset <- cbind(subject, activity, features)
print(str(combineddataset))
```

    ## Classes 'data.table' and 'data.frame':   10299 obs. of  563 variables:
    ##  $ V1                                  : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ V2                                  : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc-mean()-X                   : num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc-mean()-Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc-mean()-Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc-std()-X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
    ##  $ tBodyAcc-std()-Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
    ##  $ tBodyAcc-std()-Z                    : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
    ##  $ tBodyAcc-mad()-X                    : num  -0.995 -0.999 -0.997 -0.997 -0.998 ...
    ##  $ tBodyAcc-mad()-Y                    : num  -0.983 -0.975 -0.964 -0.983 -0.98 ...
    ##  $ tBodyAcc-mad()-Z                    : num  -0.924 -0.958 -0.977 -0.989 -0.99 ...
    ##  $ tBodyAcc-max()-X                    : num  -0.935 -0.943 -0.939 -0.939 -0.942 ...
    ##  $ tBodyAcc-max()-Y                    : num  -0.567 -0.558 -0.558 -0.576 -0.569 ...
    ##  $ tBodyAcc-max()-Z                    : num  -0.744 -0.818 -0.818 -0.83 -0.825 ...
    ##  $ tBodyAcc-min()-X                    : num  0.853 0.849 0.844 0.844 0.849 ...
    ##  $ tBodyAcc-min()-Y                    : num  0.686 0.686 0.682 0.682 0.683 ...
    ##  $ tBodyAcc-min()-Z                    : num  0.814 0.823 0.839 0.838 0.838 ...
    ##  $ tBodyAcc-sma()                      : num  -0.966 -0.982 -0.983 -0.986 -0.993 ...
    ##  $ tBodyAcc-energy()-X                 : num  -1 -1 -1 -1 -1 ...
    ##  $ tBodyAcc-energy()-Y                 : num  -1 -1 -1 -1 -1 ...
    ##  $ tBodyAcc-energy()-Z                 : num  -0.995 -0.998 -0.999 -1 -1 ...
    ##  $ tBodyAcc-iqr()-X                    : num  -0.994 -0.999 -0.997 -0.997 -0.998 ...
    ##  $ tBodyAcc-iqr()-Y                    : num  -0.988 -0.978 -0.965 -0.984 -0.981 ...
    ##  $ tBodyAcc-iqr()-Z                    : num  -0.943 -0.948 -0.975 -0.986 -0.991 ...
    ##  $ tBodyAcc-entropy()-X                : num  -0.408 -0.715 -0.592 -0.627 -0.787 ...
    ##  $ tBodyAcc-entropy()-Y                : num  -0.679 -0.501 -0.486 -0.851 -0.559 ...
    ##  $ tBodyAcc-entropy()-Z                : num  -0.602 -0.571 -0.571 -0.912 -0.761 ...
    ##  $ tBodyAcc-arCoeff()-X,1              : num  0.9293 0.6116 0.273 0.0614 0.3133 ...
    ##  $ tBodyAcc-arCoeff()-X,2              : num  -0.853 -0.3295 -0.0863 0.0748 -0.1312 ...
    ##  $ tBodyAcc-arCoeff()-X,3              : num  0.36 0.284 0.337 0.198 0.191 ...
    ##  $ tBodyAcc-arCoeff()-X,4              : num  -0.0585 0.2846 -0.1647 -0.2643 0.0869 ...
    ##  $ tBodyAcc-arCoeff()-Y,1              : num  0.2569 0.1157 0.0172 0.0725 0.2576 ...
    ##  $ tBodyAcc-arCoeff()-Y,2              : num  -0.2248 -0.091 -0.0745 -0.1553 -0.2725 ...
    ##  $ tBodyAcc-arCoeff()-Y,3              : num  0.264 0.294 0.342 0.323 0.435 ...
    ##  $ tBodyAcc-arCoeff()-Y,4              : num  -0.0952 -0.2812 -0.3326 -0.1708 -0.3154 ...
    ##  $ tBodyAcc-arCoeff()-Z,1              : num  0.279 0.086 0.239 0.295 0.44 ...
    ##  $ tBodyAcc-arCoeff()-Z,2              : num  -0.4651 -0.0222 -0.1362 -0.3061 -0.2691 ...
    ##  $ tBodyAcc-arCoeff()-Z,3              : num  0.4919 -0.0167 0.1739 0.4821 0.1794 ...
    ##  $ tBodyAcc-arCoeff()-Z,4              : num  -0.191 -0.221 -0.299 -0.47 -0.089 ...
    ##  $ tBodyAcc-correlation()-X,Y          : num  0.3763 -0.0134 -0.1247 -0.3057 -0.1558 ...
    ##  $ tBodyAcc-correlation()-X,Z          : num  0.4351 -0.0727 -0.1811 -0.3627 -0.1898 ...
    ##  $ tBodyAcc-correlation()-Y,Z          : num  0.661 0.579 0.609 0.507 0.599 ...
    ##  $ tGravityAcc-mean()-X                : num  0.963 0.967 0.967 0.968 0.968 ...
    ##  $ tGravityAcc-mean()-Y                : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
    ##  $ tGravityAcc-mean()-Z                : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
    ##  $ tGravityAcc-std()-X                 : num  -0.985 -0.997 -1 -0.997 -0.998 ...
    ##  $ tGravityAcc-std()-Y                 : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
    ##  $ tGravityAcc-std()-Z                 : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
    ##  $ tGravityAcc-mad()-X                 : num  -0.985 -0.998 -1 -0.996 -0.998 ...
    ##  $ tGravityAcc-mad()-Y                 : num  -0.984 -0.99 -0.993 -0.981 -0.989 ...
    ##  $ tGravityAcc-mad()-Z                 : num  -0.895 -0.933 -0.993 -0.978 -0.979 ...
    ##  $ tGravityAcc-max()-X                 : num  0.892 0.892 0.892 0.894 0.894 ...
    ##  $ tGravityAcc-max()-Y                 : num  -0.161 -0.161 -0.164 -0.164 -0.167 ...
    ##  $ tGravityAcc-max()-Z                 : num  0.1247 0.1226 0.0946 0.0934 0.0917 ...
    ##  $ tGravityAcc-min()-X                 : num  0.977 0.985 0.987 0.987 0.987 ...
    ##  $ tGravityAcc-min()-Y                 : num  -0.123 -0.115 -0.115 -0.121 -0.122 ...
    ##  $ tGravityAcc-min()-Z                 : num  0.0565 0.1028 0.1028 0.0958 0.0941 ...
    ##  $ tGravityAcc-sma()                   : num  -0.375 -0.383 -0.402 -0.4 -0.4 ...
    ##  $ tGravityAcc-energy()-X              : num  0.899 0.908 0.909 0.911 0.912 ...
    ##  $ tGravityAcc-energy()-Y              : num  -0.971 -0.971 -0.97 -0.969 -0.967 ...
    ##  $ tGravityAcc-energy()-Z              : num  -0.976 -0.979 -0.982 -0.982 -0.984 ...
    ##  $ tGravityAcc-iqr()-X                 : num  -0.984 -0.999 -1 -0.996 -0.998 ...
    ##  $ tGravityAcc-iqr()-Y                 : num  -0.989 -0.99 -0.992 -0.981 -0.991 ...
    ##  $ tGravityAcc-iqr()-Z                 : num  -0.918 -0.942 -0.993 -0.98 -0.98 ...
    ##  $ tGravityAcc-entropy()-X             : num  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
    ##  $ tGravityAcc-entropy()-Y             : num  -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...
    ##  $ tGravityAcc-entropy()-Z             : num  0.114 -0.21 -0.927 -0.596 -0.617 ...
    ##  $ tGravityAcc-arCoeff()-X,1           : num  -0.59042 -0.41006 0.00223 -0.06493 -0.25727 ...
    ##  $ tGravityAcc-arCoeff()-X,2           : num  0.5911 0.4139 0.0275 0.0754 0.2689 ...
    ##  $ tGravityAcc-arCoeff()-X,3           : num  -0.5918 -0.4176 -0.0567 -0.0858 -0.2807 ...
    ##  $ tGravityAcc-arCoeff()-X,4           : num  0.5925 0.4213 0.0855 0.0962 0.2926 ...
    ##  $ tGravityAcc-arCoeff()-Y,1           : num  -0.745 -0.196 -0.329 -0.295 -0.167 ...
    ##  $ tGravityAcc-arCoeff()-Y,2           : num  0.7209 0.1253 0.2705 0.2283 0.0899 ...
    ##  $ tGravityAcc-arCoeff()-Y,3           : num  -0.7124 -0.1056 -0.2545 -0.2063 -0.0663 ...
    ##  $ tGravityAcc-arCoeff()-Y,4           : num  0.7113 0.1091 0.2576 0.2048 0.0671 ...
    ##  $ tGravityAcc-arCoeff()-Z,1           : num  -0.995 -0.834 -0.705 -0.385 -0.237 ...
    ##  $ tGravityAcc-arCoeff()-Z,2           : num  0.996 0.834 0.714 0.386 0.239 ...
    ##  $ tGravityAcc-arCoeff()-Z,3           : num  -0.996 -0.834 -0.723 -0.387 -0.241 ...
    ##  $ tGravityAcc-arCoeff()-Z,4           : num  0.992 0.83 0.729 0.385 0.241 ...
    ##  $ tGravityAcc-correlation()-X,Y       : num  0.57 -0.831 -0.181 -0.991 -0.408 ...
    ##  $ tGravityAcc-correlation()-X,Z       : num  0.439 -0.866 0.338 -0.969 -0.185 ...
    ##  $ tGravityAcc-correlation()-Y,Z       : num  0.987 0.974 0.643 0.984 0.965 ...
    ##  $ tBodyAccJerk-mean()-X               : num  0.078 0.074 0.0736 0.0773 0.0734 ...
    ##  $ tBodyAccJerk-mean()-Y               : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
    ##  $ tBodyAccJerk-mean()-Z               : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
    ##  $ tBodyAccJerk-std()-X                : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
    ##  $ tBodyAccJerk-std()-Y                : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
    ##  $ tBodyAccJerk-std()-Z                : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
    ##  $ tBodyAccJerk-mad()-X                : num  -0.994 -0.996 -0.991 -0.994 -0.997 ...
    ##  $ tBodyAccJerk-mad()-Y                : num  -0.986 -0.979 -0.979 -0.986 -0.987 ...
    ##  $ tBodyAccJerk-mad()-Z                : num  -0.993 -0.991 -0.987 -0.991 -0.991 ...
    ##  $ tBodyAccJerk-max()-X                : num  -0.985 -0.995 -0.987 -0.987 -0.997 ...
    ##  $ tBodyAccJerk-max()-Y                : num  -0.992 -0.979 -0.979 -0.992 -0.992 ...
    ##  $ tBodyAccJerk-max()-Z                : num  -0.993 -0.992 -0.992 -0.99 -0.99 ...
    ##  $ tBodyAccJerk-min()-X                : num  0.99 0.993 0.988 0.988 0.994 ...
    ##  $ tBodyAccJerk-min()-Y                : num  0.992 0.992 0.992 0.993 0.993 ...
    ##  $ tBodyAccJerk-min()-Z                : num  0.991 0.989 0.989 0.993 0.986 ...
    ##  $ tBodyAccJerk-sma()                  : num  -0.994 -0.991 -0.988 -0.993 -0.994 ...
    ##  $ tBodyAccJerk-energy()-X             : num  -1 -1 -1 -1 -1 ...
    ##   [list output truncated]
    ##  - attr(*, ".internal.selfref")=<externalptr> 
    ## NULL

# 2\. Extracts only the measurements on the mean and standard deviation for each measurement.

``` r
#get the columns that have mean and standard deviation in the label
columnsmeanstd <- grep(".*mean.*|.*std.*", names(combineddataset), ignore.case=TRUE)
# format list of columns with activity, subject, and the features that have means and std deviation
columnsneededlist <- c(1,2,columnsmeanstd)
# create the formated data frame
columnsneeddf <- combineddataset[, columnsneededlist, with=FALSE]
print(str(columnsneeddf))
```

    ## Classes 'data.table' and 'data.frame':   10299 obs. of  88 variables:
    ##  $ V1                                  : int  1 1 1 1 1 1 1 1 1 1 ...
    ##  $ V2                                  : int  5 5 5 5 5 5 5 5 5 5 ...
    ##  $ tBodyAcc-mean()-X                   : num  0.289 0.278 0.28 0.279 0.277 ...
    ##  $ tBodyAcc-mean()-Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
    ##  $ tBodyAcc-mean()-Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
    ##  $ tBodyAcc-std()-X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
    ##  $ tBodyAcc-std()-Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
    ##  $ tBodyAcc-std()-Z                    : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
    ##  $ tGravityAcc-mean()-X                : num  0.963 0.967 0.967 0.968 0.968 ...
    ##  $ tGravityAcc-mean()-Y                : num  -0.141 -0.142 -0.142 -0.144 -0.149 ...
    ##  $ tGravityAcc-mean()-Z                : num  0.1154 0.1094 0.1019 0.0999 0.0945 ...
    ##  $ tGravityAcc-std()-X                 : num  -0.985 -0.997 -1 -0.997 -0.998 ...
    ##  $ tGravityAcc-std()-Y                 : num  -0.982 -0.989 -0.993 -0.981 -0.988 ...
    ##  $ tGravityAcc-std()-Z                 : num  -0.878 -0.932 -0.993 -0.978 -0.979 ...
    ##  $ tBodyAccJerk-mean()-X               : num  0.078 0.074 0.0736 0.0773 0.0734 ...
    ##  $ tBodyAccJerk-mean()-Y               : num  0.005 0.00577 0.0031 0.02006 0.01912 ...
    ##  $ tBodyAccJerk-mean()-Z               : num  -0.06783 0.02938 -0.00905 -0.00986 0.01678 ...
    ##  $ tBodyAccJerk-std()-X                : num  -0.994 -0.996 -0.991 -0.993 -0.996 ...
    ##  $ tBodyAccJerk-std()-Y                : num  -0.988 -0.981 -0.981 -0.988 -0.988 ...
    ##  $ tBodyAccJerk-std()-Z                : num  -0.994 -0.992 -0.99 -0.993 -0.992 ...
    ##  $ tBodyGyro-mean()-X                  : num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
    ##  $ tBodyGyro-mean()-Y                  : num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
    ##  $ tBodyGyro-mean()-Z                  : num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
    ##  $ tBodyGyro-std()-X                   : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
    ##  $ tBodyGyro-std()-Y                   : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
    ##  $ tBodyGyro-std()-Z                   : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...
    ##  $ tBodyGyroJerk-mean()-X              : num  -0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...
    ##  $ tBodyGyroJerk-mean()-Y              : num  -0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...
    ##  $ tBodyGyroJerk-mean()-Z              : num  -0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...
    ##  $ tBodyGyroJerk-std()-X               : num  -0.992 -0.99 -0.988 -0.991 -0.991 ...
    ##  $ tBodyGyroJerk-std()-Y               : num  -0.993 -0.997 -0.996 -0.997 -0.996 ...
    ##  $ tBodyGyroJerk-std()-Z               : num  -0.992 -0.994 -0.992 -0.993 -0.995 ...
    ##  $ tBodyAccMag-mean()                  : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
    ##  $ tBodyAccMag-std()                   : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
    ##  $ tGravityAccMag-mean()               : num  -0.959 -0.979 -0.984 -0.987 -0.993 ...
    ##  $ tGravityAccMag-std()                : num  -0.951 -0.976 -0.988 -0.986 -0.991 ...
    ##  $ tBodyAccJerkMag-mean()              : num  -0.993 -0.991 -0.989 -0.993 -0.993 ...
    ##  $ tBodyAccJerkMag-std()               : num  -0.994 -0.992 -0.99 -0.993 -0.996 ...
    ##  $ tBodyGyroMag-mean()                 : num  -0.969 -0.981 -0.976 -0.982 -0.985 ...
    ##  $ tBodyGyroMag-std()                  : num  -0.964 -0.984 -0.986 -0.987 -0.989 ...
    ##  $ tBodyGyroJerkMag-mean()             : num  -0.994 -0.995 -0.993 -0.996 -0.996 ...
    ##  $ tBodyGyroJerkMag-std()              : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
    ##  $ fBodyAcc-mean()-X                   : num  -0.995 -0.997 -0.994 -0.995 -0.997 ...
    ##  $ fBodyAcc-mean()-Y                   : num  -0.983 -0.977 -0.973 -0.984 -0.982 ...
    ##  $ fBodyAcc-mean()-Z                   : num  -0.939 -0.974 -0.983 -0.991 -0.988 ...
    ##  $ fBodyAcc-std()-X                    : num  -0.995 -0.999 -0.996 -0.996 -0.999 ...
    ##  $ fBodyAcc-std()-Y                    : num  -0.983 -0.975 -0.966 -0.983 -0.98 ...
    ##  $ fBodyAcc-std()-Z                    : num  -0.906 -0.955 -0.977 -0.99 -0.992 ...
    ##  $ fBodyAcc-meanFreq()-X               : num  0.252 0.271 0.125 0.029 0.181 ...
    ##  $ fBodyAcc-meanFreq()-Y               : num  0.1318 0.0429 -0.0646 0.0803 0.058 ...
    ##  $ fBodyAcc-meanFreq()-Z               : num  -0.0521 -0.0143 0.0827 0.1857 0.5598 ...
    ##  $ fBodyAccJerk-mean()-X               : num  -0.992 -0.995 -0.991 -0.994 -0.996 ...
    ##  $ fBodyAccJerk-mean()-Y               : num  -0.987 -0.981 -0.982 -0.989 -0.989 ...
    ##  $ fBodyAccJerk-mean()-Z               : num  -0.99 -0.99 -0.988 -0.991 -0.991 ...
    ##  $ fBodyAccJerk-std()-X                : num  -0.996 -0.997 -0.991 -0.991 -0.997 ...
    ##  $ fBodyAccJerk-std()-Y                : num  -0.991 -0.982 -0.981 -0.987 -0.989 ...
    ##  $ fBodyAccJerk-std()-Z                : num  -0.997 -0.993 -0.99 -0.994 -0.993 ...
    ##  $ fBodyAccJerk-meanFreq()-X           : num  0.8704 0.6085 0.1154 0.0358 0.2734 ...
    ##  $ fBodyAccJerk-meanFreq()-Y           : num  0.2107 -0.0537 -0.1934 -0.093 0.0791 ...
    ##  $ fBodyAccJerk-meanFreq()-Z           : num  0.2637 0.0631 0.0383 0.1681 0.2924 ...
    ##  $ fBodyGyro-mean()-X                  : num  -0.987 -0.977 -0.975 -0.987 -0.982 ...
    ##  $ fBodyGyro-mean()-Y                  : num  -0.982 -0.993 -0.994 -0.994 -0.993 ...
    ##  $ fBodyGyro-mean()-Z                  : num  -0.99 -0.99 -0.987 -0.987 -0.989 ...
    ##  $ fBodyGyro-std()-X                   : num  -0.985 -0.985 -0.977 -0.993 -0.986 ...
    ##  $ fBodyGyro-std()-Y                   : num  -0.974 -0.987 -0.993 -0.992 -0.992 ...
    ##  $ fBodyGyro-std()-Z                   : num  -0.994 -0.99 -0.987 -0.989 -0.988 ...
    ##  $ fBodyGyro-meanFreq()-X              : num  -0.2575 -0.0482 -0.2167 0.2169 -0.1533 ...
    ##  $ fBodyGyro-meanFreq()-Y              : num  0.0979 -0.4016 -0.0173 -0.1352 -0.0884 ...
    ##  $ fBodyGyro-meanFreq()-Z              : num  0.5472 -0.0682 -0.1107 -0.0497 -0.1622 ...
    ##  $ fBodyAccMag-mean()                  : num  -0.952 -0.981 -0.988 -0.988 -0.994 ...
    ##  $ fBodyAccMag-std()                   : num  -0.956 -0.976 -0.989 -0.987 -0.99 ...
    ##  $ fBodyAccMag-meanFreq()              : num  -0.0884 -0.0441 0.2579 0.0736 0.3943 ...
    ##  $ fBodyBodyAccJerkMag-mean()          : num  -0.994 -0.99 -0.989 -0.993 -0.996 ...
    ##  $ fBodyBodyAccJerkMag-std()           : num  -0.994 -0.992 -0.991 -0.992 -0.994 ...
    ##  $ fBodyBodyAccJerkMag-meanFreq()      : num  0.347 0.532 0.661 0.679 0.559 ...
    ##  $ fBodyBodyGyroMag-mean()             : num  -0.98 -0.988 -0.989 -0.989 -0.991 ...
    ##  $ fBodyBodyGyroMag-std()              : num  -0.961 -0.983 -0.986 -0.988 -0.989 ...
    ##  $ fBodyBodyGyroMag-meanFreq()         : num  -0.129 -0.272 -0.2127 -0.0357 -0.2736 ...
    ##  $ fBodyBodyGyroJerkMag-mean()         : num  -0.992 -0.996 -0.995 -0.995 -0.995 ...
    ##  $ fBodyBodyGyroJerkMag-std()          : num  -0.991 -0.996 -0.995 -0.995 -0.995 ...
    ##  $ fBodyBodyGyroJerkMag-meanFreq()     : num  -0.0743 0.1581 0.4145 0.4046 0.0878 ...
    ##  $ angle(tBodyAccMean,gravity)         : num  -0.1128 0.0535 -0.1186 -0.0368 0.1233 ...
    ##  $ angle(tBodyAccJerkMean),gravityMean): num  0.0304 -0.00743 0.1779 -0.01289 0.12254 ...
    ##  $ angle(tBodyGyroMean,gravityMean)    : num  -0.465 -0.733 0.101 0.64 0.694 ...
    ##  $ angle(tBodyGyroJerkMean,gravityMean): num  -0.0184 0.7035 0.8085 -0.4854 -0.616 ...
    ##  $ angle(X,gravityMean)                : num  -0.841 -0.845 -0.849 -0.849 -0.848 ...
    ##  $ angle(Y,gravityMean)                : num  0.18 0.18 0.181 0.182 0.185 ...
    ##  $ angle(Z,gravityMean)                : num  -0.0586 -0.0543 -0.0491 -0.0477 -0.0439 ...
    ##  - attr(*, ".internal.selfref")=<externalptr> 
    ## NULL

# 3\. Use descriptive activity names to name the activities in the data set

``` r
#check activity number in column and replace with corresponding activity label
for (i in 1:6){ columnsneeddf$V2[columnsneeddf$V2 == i] <- c(activitylables$V2[i])}
print(str(columnsneeddf$V2))
```

    ##  chr [1:10299] "STANDING" "STANDING" "STANDING" "STANDING" "STANDING" ...
    ## NULL

``` r
print(unique(columnsneeddf$V2))
```

    ## [1] "STANDING"           "SITTING"            "LAYING"            
    ## [4] "WALKING"            "WALKING_DOWNSTAIRS" "WALKING_UPSTAIRS"

# 4\. Appropiately labels the data set with descriptive variable names

``` r
#feature column names were already set previously
#finish setting column names Subject and Activity
colnames(columnsneeddf)[colnames(columnsneeddf) %in% c("V1", "V2")] <- c("Subject", "Activity")
print(names(columnsneeddf))
```

    ##  [1] "Subject"                             
    ##  [2] "Activity"                            
    ##  [3] "tBodyAcc-mean()-X"                   
    ##  [4] "tBodyAcc-mean()-Y"                   
    ##  [5] "tBodyAcc-mean()-Z"                   
    ##  [6] "tBodyAcc-std()-X"                    
    ##  [7] "tBodyAcc-std()-Y"                    
    ##  [8] "tBodyAcc-std()-Z"                    
    ##  [9] "tGravityAcc-mean()-X"                
    ## [10] "tGravityAcc-mean()-Y"                
    ## [11] "tGravityAcc-mean()-Z"                
    ## [12] "tGravityAcc-std()-X"                 
    ## [13] "tGravityAcc-std()-Y"                 
    ## [14] "tGravityAcc-std()-Z"                 
    ## [15] "tBodyAccJerk-mean()-X"               
    ## [16] "tBodyAccJerk-mean()-Y"               
    ## [17] "tBodyAccJerk-mean()-Z"               
    ## [18] "tBodyAccJerk-std()-X"                
    ## [19] "tBodyAccJerk-std()-Y"                
    ## [20] "tBodyAccJerk-std()-Z"                
    ## [21] "tBodyGyro-mean()-X"                  
    ## [22] "tBodyGyro-mean()-Y"                  
    ## [23] "tBodyGyro-mean()-Z"                  
    ## [24] "tBodyGyro-std()-X"                   
    ## [25] "tBodyGyro-std()-Y"                   
    ## [26] "tBodyGyro-std()-Z"                   
    ## [27] "tBodyGyroJerk-mean()-X"              
    ## [28] "tBodyGyroJerk-mean()-Y"              
    ## [29] "tBodyGyroJerk-mean()-Z"              
    ## [30] "tBodyGyroJerk-std()-X"               
    ## [31] "tBodyGyroJerk-std()-Y"               
    ## [32] "tBodyGyroJerk-std()-Z"               
    ## [33] "tBodyAccMag-mean()"                  
    ## [34] "tBodyAccMag-std()"                   
    ## [35] "tGravityAccMag-mean()"               
    ## [36] "tGravityAccMag-std()"                
    ## [37] "tBodyAccJerkMag-mean()"              
    ## [38] "tBodyAccJerkMag-std()"               
    ## [39] "tBodyGyroMag-mean()"                 
    ## [40] "tBodyGyroMag-std()"                  
    ## [41] "tBodyGyroJerkMag-mean()"             
    ## [42] "tBodyGyroJerkMag-std()"              
    ## [43] "fBodyAcc-mean()-X"                   
    ## [44] "fBodyAcc-mean()-Y"                   
    ## [45] "fBodyAcc-mean()-Z"                   
    ## [46] "fBodyAcc-std()-X"                    
    ## [47] "fBodyAcc-std()-Y"                    
    ## [48] "fBodyAcc-std()-Z"                    
    ## [49] "fBodyAcc-meanFreq()-X"               
    ## [50] "fBodyAcc-meanFreq()-Y"               
    ## [51] "fBodyAcc-meanFreq()-Z"               
    ## [52] "fBodyAccJerk-mean()-X"               
    ## [53] "fBodyAccJerk-mean()-Y"               
    ## [54] "fBodyAccJerk-mean()-Z"               
    ## [55] "fBodyAccJerk-std()-X"                
    ## [56] "fBodyAccJerk-std()-Y"                
    ## [57] "fBodyAccJerk-std()-Z"                
    ## [58] "fBodyAccJerk-meanFreq()-X"           
    ## [59] "fBodyAccJerk-meanFreq()-Y"           
    ## [60] "fBodyAccJerk-meanFreq()-Z"           
    ## [61] "fBodyGyro-mean()-X"                  
    ## [62] "fBodyGyro-mean()-Y"                  
    ## [63] "fBodyGyro-mean()-Z"                  
    ## [64] "fBodyGyro-std()-X"                   
    ## [65] "fBodyGyro-std()-Y"                   
    ## [66] "fBodyGyro-std()-Z"                   
    ## [67] "fBodyGyro-meanFreq()-X"              
    ## [68] "fBodyGyro-meanFreq()-Y"              
    ## [69] "fBodyGyro-meanFreq()-Z"              
    ## [70] "fBodyAccMag-mean()"                  
    ## [71] "fBodyAccMag-std()"                   
    ## [72] "fBodyAccMag-meanFreq()"              
    ## [73] "fBodyBodyAccJerkMag-mean()"          
    ## [74] "fBodyBodyAccJerkMag-std()"           
    ## [75] "fBodyBodyAccJerkMag-meanFreq()"      
    ## [76] "fBodyBodyGyroMag-mean()"             
    ## [77] "fBodyBodyGyroMag-std()"              
    ## [78] "fBodyBodyGyroMag-meanFreq()"         
    ## [79] "fBodyBodyGyroJerkMag-mean()"         
    ## [80] "fBodyBodyGyroJerkMag-std()"          
    ## [81] "fBodyBodyGyroJerkMag-meanFreq()"     
    ## [82] "angle(tBodyAccMean,gravity)"         
    ## [83] "angle(tBodyAccJerkMean),gravityMean)"
    ## [84] "angle(tBodyGyroMean,gravityMean)"    
    ## [85] "angle(tBodyGyroJerkMean,gravityMean)"
    ## [86] "angle(X,gravityMean)"                
    ## [87] "angle(Y,gravityMean)"                
    ## [88] "angle(Z,gravityMean)"

# 5\. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

``` r
avgtidydata <- columnsneeddf %>%
                             group_by(Subject, Activity) %>%
                             summarize_each(funs(mean))
```

    ## Warning: funs() is soft deprecated as of dplyr 0.8.0
    ## Please use a list of either functions or lambdas: 
    ## 
    ##   # Simple named list: 
    ##   list(mean = mean, median = median)
    ## 
    ##   # Auto named with `tibble::lst()`: 
    ##   tibble::lst(mean, median)
    ## 
    ##   # Using lambdas
    ##   list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
    ## This warning is displayed once per session.

``` r
print(avgtidydata)
```

    ## # A tibble: 180 x 88
    ## # Groups:   Subject [30]
    ##    Subject Activity `tBodyAcc-mean(… `tBodyAcc-mean(… `tBodyAcc-mean(…
    ##      <int> <chr>               <dbl>            <dbl>            <dbl>
    ##  1       1 LAYING              0.222         -0.0405           -0.113 
    ##  2       1 SITTING             0.261         -0.00131          -0.105 
    ##  3       1 STANDING            0.279         -0.0161           -0.111 
    ##  4       1 WALKING             0.277         -0.0174           -0.111 
    ##  5       1 WALKING…            0.289         -0.00992          -0.108 
    ##  6       1 WALKING…            0.255         -0.0240           -0.0973
    ##  7       2 LAYING              0.281         -0.0182           -0.107 
    ##  8       2 SITTING             0.277         -0.0157           -0.109 
    ##  9       2 STANDING            0.278         -0.0184           -0.106 
    ## 10       2 WALKING             0.276         -0.0186           -0.106 
    ## # … with 170 more rows, and 83 more variables: `tBodyAcc-std()-X` <dbl>,
    ## #   `tBodyAcc-std()-Y` <dbl>, `tBodyAcc-std()-Z` <dbl>,
    ## #   `tGravityAcc-mean()-X` <dbl>, `tGravityAcc-mean()-Y` <dbl>,
    ## #   `tGravityAcc-mean()-Z` <dbl>, `tGravityAcc-std()-X` <dbl>,
    ## #   `tGravityAcc-std()-Y` <dbl>, `tGravityAcc-std()-Z` <dbl>,
    ## #   `tBodyAccJerk-mean()-X` <dbl>, `tBodyAccJerk-mean()-Y` <dbl>,
    ## #   `tBodyAccJerk-mean()-Z` <dbl>, `tBodyAccJerk-std()-X` <dbl>,
    ## #   `tBodyAccJerk-std()-Y` <dbl>, `tBodyAccJerk-std()-Z` <dbl>,
    ## #   `tBodyGyro-mean()-X` <dbl>, `tBodyGyro-mean()-Y` <dbl>,
    ## #   `tBodyGyro-mean()-Z` <dbl>, `tBodyGyro-std()-X` <dbl>,
    ## #   `tBodyGyro-std()-Y` <dbl>, `tBodyGyro-std()-Z` <dbl>,
    ## #   `tBodyGyroJerk-mean()-X` <dbl>, `tBodyGyroJerk-mean()-Y` <dbl>,
    ## #   `tBodyGyroJerk-mean()-Z` <dbl>, `tBodyGyroJerk-std()-X` <dbl>,
    ## #   `tBodyGyroJerk-std()-Y` <dbl>, `tBodyGyroJerk-std()-Z` <dbl>,
    ## #   `tBodyAccMag-mean()` <dbl>, `tBodyAccMag-std()` <dbl>,
    ## #   `tGravityAccMag-mean()` <dbl>, `tGravityAccMag-std()` <dbl>,
    ## #   `tBodyAccJerkMag-mean()` <dbl>, `tBodyAccJerkMag-std()` <dbl>,
    ## #   `tBodyGyroMag-mean()` <dbl>, `tBodyGyroMag-std()` <dbl>,
    ## #   `tBodyGyroJerkMag-mean()` <dbl>, `tBodyGyroJerkMag-std()` <dbl>,
    ## #   `fBodyAcc-mean()-X` <dbl>, `fBodyAcc-mean()-Y` <dbl>,
    ## #   `fBodyAcc-mean()-Z` <dbl>, `fBodyAcc-std()-X` <dbl>,
    ## #   `fBodyAcc-std()-Y` <dbl>, `fBodyAcc-std()-Z` <dbl>,
    ## #   `fBodyAcc-meanFreq()-X` <dbl>, `fBodyAcc-meanFreq()-Y` <dbl>,
    ## #   `fBodyAcc-meanFreq()-Z` <dbl>, `fBodyAccJerk-mean()-X` <dbl>,
    ## #   `fBodyAccJerk-mean()-Y` <dbl>, `fBodyAccJerk-mean()-Z` <dbl>,
    ## #   `fBodyAccJerk-std()-X` <dbl>, `fBodyAccJerk-std()-Y` <dbl>,
    ## #   `fBodyAccJerk-std()-Z` <dbl>, `fBodyAccJerk-meanFreq()-X` <dbl>,
    ## #   `fBodyAccJerk-meanFreq()-Y` <dbl>, `fBodyAccJerk-meanFreq()-Z` <dbl>,
    ## #   `fBodyGyro-mean()-X` <dbl>, `fBodyGyro-mean()-Y` <dbl>,
    ## #   `fBodyGyro-mean()-Z` <dbl>, `fBodyGyro-std()-X` <dbl>,
    ## #   `fBodyGyro-std()-Y` <dbl>, `fBodyGyro-std()-Z` <dbl>,
    ## #   `fBodyGyro-meanFreq()-X` <dbl>, `fBodyGyro-meanFreq()-Y` <dbl>,
    ## #   `fBodyGyro-meanFreq()-Z` <dbl>, `fBodyAccMag-mean()` <dbl>,
    ## #   `fBodyAccMag-std()` <dbl>, `fBodyAccMag-meanFreq()` <dbl>,
    ## #   `fBodyBodyAccJerkMag-mean()` <dbl>, `fBodyBodyAccJerkMag-std()` <dbl>,
    ## #   `fBodyBodyAccJerkMag-meanFreq()` <dbl>, `fBodyBodyGyroMag-mean()` <dbl>,
    ## #   `fBodyBodyGyroMag-std()` <dbl>, `fBodyBodyGyroMag-meanFreq()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-mean()` <dbl>, `fBodyBodyGyroJerkMag-std()` <dbl>,
    ## #   `fBodyBodyGyroJerkMag-meanFreq()` <dbl>,
    ## #   `angle(tBodyAccMean,gravity)` <dbl>,
    ## #   `angle(tBodyAccJerkMean),gravityMean)` <dbl>,
    ## #   `angle(tBodyGyroMean,gravityMean)` <dbl>,
    ## #   `angle(tBodyGyroJerkMean,gravityMean)` <dbl>, `angle(X,gravityMean)` <dbl>,
    ## #   `angle(Y,gravityMean)` <dbl>, `angle(Z,gravityMean)` <dbl>

``` r
# Write the tidy dataset to a file
fwrite(avgtidydata, file="./avgtidydata.txt")
```
