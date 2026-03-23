# 📸 MATLAB Image Dataset Augmentation Tool

This repository contains a **MATLAB-based image augmentation script** that automatically processes images from multiple subfolders and generates **10 augmented versions per image**.

It is designed for **machine learning, deep learning, and computer vision** datasets preparation.

---

## 🚀 Features

- Automatically detects **multiple subfolders**
- Generates **10 augmented images per input image**
- Applies:
  - Image rotation
  - Horizontal and vertical flipping
  - Center cropping
  - Aggressive cropping for variation
- Maintains original image filenames
- Automatically creates structured output folders

---

## 📁 Input Folder Structure

    ├── Main_Folder/
    │   ├── Eiffel_Tower/
    │   │   ├── image1.jpg
    │   │   └── image2.jpg
    │   └── GrandCanal/
    │       ├── image1.jpg
    │       └── image2.jpg

---

## 📁 Output Folder Structure

    ├── Main_Folder_augmented/
    │   ├── Eiffel_Tower/
    │   │   ├── 1/
    │   │   ├── 2/
    │   │   ├── 3/
    │   │   ├── ...
    │   │   └── 10/
    │   └── GrandCanal/
    │       ├── 1/
    │       ├── 2/
    │       ├── 3/
    │       ├── ...
    │       └── 10/

Each numbered folder contains one specific augmentation per image.

---

## 🔧 Augmentation Details

| Augmentation | Description |
|-------------|-------------|
| 1–8 | Rotation (±10°, ±20°) with optional horizontal/vertical flip and center crop |
| 9 | Vertical flip + rotation (-10°) + center crop |
| 10 | Horizontal flip + rotation (30°) + aggressive crop |

---

## ▶️ How to Run

1. Open **MATLAB**
2. Place the script in your working directory
3. Run the script
4. Select the **main folder** containing image subfolders when prompted
5. Augmented images will be saved automatically

---

## 🧠 Use Cases

- Image classification datasets
- Deep learning model training
- Computer vision experiments
- Academic & research projects

---

## 📌 Requirements

- MATLAB R2018 or later
- Image Processing Toolbox

---

## 📄 License

This project is open-source and free to use for educational and research purposes.

---

## 🤝 Contributions

Contributions, improvements, and suggestions are welcome.
Feel free to fork this repository and submit a pull request.
