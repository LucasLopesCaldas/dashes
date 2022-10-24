import cv2
import numpy as np

import pytesseract

tessdata_path = '/home/lucaslopes/Projects/image2text/'

def show_image(text, image):
    cv2.imshow(text, image)

    cv2.waitKey(0)

    cv2.destroyAllWindows()


def load_trashold_image(path):
    image = cv2.imread(path)


    data = np.reshape(image, (-1,3))
    data = np.float32(data)

    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 10, 1.0)
    flags = cv2.KMEANS_RANDOM_CENTERS
    compactness,labels,centers = cv2.kmeans(data,1,None,criteria,10,flags)

    dom = centers[0].astype(np.int32)

    avg = sum(dom) / 3
    if avg < 127.5:
        image = cv2.bitwise_not(image)

    #show_image('noramal image', image)
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    #show_image('gray image', gray_image)
    res = cv2.resize(gray_image, None, fx=1.2, fy=1.2, interpolation=cv2.INTER_CUBIC)
    return res


def show_boxies(data, image):
    total_boxes = len(data['text'])

    for sequence_number in range(total_boxes):

        if int(data['conf'][sequence_number]) > 10:

            (x, y, w, h) = (
                data['left'][sequence_number], data['top'][sequence_number],
                data['width'][sequence_number],  data['height'][sequence_number]
            )

            image = cv2.rectangle(
                image, (x, y), (x + w, y + h), (0, 0, 0), 2
            )

    show_image('boxies', image)


def load_image_data(image, lang):
    data = pytesseract.image_to_data(
        image, output_type='dict', lang=lang, config='--tessdata-dir ' + tessdata_path)
    return data


def get_text_from_data(data):
    text = []

    parse_text = []

    words = []

    last_word = ''

    for word in data['text']:

        if word != '':

            words.append(word)

            last_word = word

        if (last_word != '' and word == '') or (word == data['text'][-1]):

            parse_text.append(words)

            words = []

    for i in range(len(parse_text)):
        line = []
        if (parse_text[i] != []):
            line = parse_text[i]
        text += [line[i] + ' ' if len(line) != i else line[i]
                 for i in range(len(line))]
        if (parse_text[i] != []):
            text.append('\n')
    return ''.join(text)


def extract_text(image_path: str, lang) -> str:
    image = load_trashold_image(image_path)

    # por == portuguese  &&  eng == english
    data = load_image_data(image, lang)

    #show_boxies(data, image)

    return get_text_from_data(data)
