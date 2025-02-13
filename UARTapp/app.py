
# pyqt libraries
from PyQt5.QtWidgets import QApplication, QMainWindow
from PyQt5 import uic
from PyQt5.QtCore import pyqtSignal
import sys


# The main GUI class, which defines our application window with all of it's functionalities
class gui(QMainWindow):
    # signal to update console
    update_console_signal = pyqtSignal(dict)
    

    def __init__(self, main):
    
        super().__init__()
        uic.loadUi("app.ui", self)
        self.setWindowTitle("UART Laser Testing")
    
     



        self.show()


if __name__ == "__main__":
    app=QApplication(sys.argv)
    UI = gui("main")
    app.exec_()