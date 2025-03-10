# import libraries
import collections
import json
import threading
import socket

# for plotting graph
import sys
import pyqtgraph as pg
import numpy as np

from PyQt5.QtWidgets import QMainWindow,QApplication, QLabel,QLineEdit,QWidget,QFrame,QPushButton,QVBoxLayout,QMenuBar,QStatusBar,QFileDialog
from PyQt5 import uic
import sys

# for socket communication
import socket
import struct



class cli_handling(QMainWindow):
    def __init__(self, main):
        super(cli_handling,self).__init__()
        uic.loadUi("cli_window2.ui",self)

        # define the widgets
        self.plot_widget = self.findChild(pg.PlotWidget, "plotWidget")  
        self.browseFileButton = self.findChild(QPushButton, "browseFileButton")
        self.splitButton = self.findChild(QPushButton, "splitButton")
        self.fileNameLabel = self.findChild(QLabel, "fileNameLabel")
        self.fileInfoLabel = self.findChild(QLabel, "fileInfoLabel")

        # defining the socket communication buttons
        self.startButton = self.findChild(QPushButton,"startButton")
        self.pauseButton = self.findChild(QPushButton,"pauseButton")
        self.stopButton = self.findChild(QPushButton,"stopButton")

        self.startButton.clicked.connect(self.start_comms)
        self.pauseButton.clicked.connect(self.pause_comms)
        self.stopButton.clicked.connect(self.stop_comms)


        # disable the socket communication buttons until payload is prepared
        self.startButton.setEnabled(False)
        self.pauseButton.setEnabled(False)
        self.stopButton.setEnabled(False)

        # defining the buttons for the shape select
        self.squareButton=self.findChild(QPushButton,"squareButton")
        self.triangleButton = self.findChild(QPushButton,"triangleButton")
        self.circleButton = self.findChild(QPushButton,"circleButton")
        self.hatchedRectangleButton = self.findChild(QPushButton,"hatchedRectangleButton")


        self.squareButton.clicked.connect(self.square_plotter)
        self.triangleButton.clicked.connect(self.triangle_plotter)
        self.circleButton.clicked.connect(self.circle_plotter)
        self.hatchedRectangleButton.clicked.connect(self.hatched_rectangle_plotter)


        # enabling text wrap for the labels
        self.fileNameLabel.setWordWrap(True)
        self.fileInfoLabel.setWordWrap(True)

        # defining the buttons in select file frame
        self.browseFileButton.clicked.connect(self.browse_file)
        self.splitButton.clicked.connect(self.split_file)

        # For the graph
        self.plot_widget.setTitle("My Graph")
        self.plot_widget.setLabel('bottom', 'X axis')
        self.plot_widget.setLabel('left', 'Y axis')

     

        self.show()

        try:
            # define variables
            self.main = main
            self.total_layers = 0
            self.unit = 0 # in mm
            self.dimension = []
            self.min_dimension=[]
            self.max_dimension=[]
            self._markData = collections.OrderedDict()
            self.current_layer = None
            self.prev_layer = None
            self.layer_height = None
            self.coord_list = []
            self.temp_coord = []
            self.new_coord_list = []

        except Exception as e:
            print(f"Error C1: Error in cli_handling init function\n{str(e)}")
            self.error_logger.logger.error(f"Error C1: Error in cli_handling init function\n{str(e)}")
    

    # what happens when 'browse file' button is clicked

    def browse_file(self):
        self.fileNameLabel.setText("Browsing...")
        self.fName=QFileDialog.getOpenFileName(self,"Open file","","All Files (*)")

        # if a file is successfully selected
        if self.fName:
            self.fileNameLabel.setText(self.fName[0])
            self.get_file(self.fName[0])

            self.fileInfoLabel.setText(f"{self.fName[0]} \n\nThis is a single layer")
                # extract coordinate data and plot a sample graph
            self.extract_data()
            self.convert_to_list()
            self.convert_to_payload()
            self.update_plot()

            # enable the socket communications buttons
            self.startButton.setEnabled(True)
            self.pauseButton.setEnabled(True)
            self.stopButton.setEnabled(True)


            # do not process other files
            # else:
            #     self.fileInfoLabel.setText("Cannot process file. Please select file with proper format.")

    def split_file(self):
        self.split_layers()


    # to open file and create file object; input: path to cli file
    def get_file(self,file): 
        try:
            self.file = file
        except Exception as e:
            print(f"Error C2: Error in cli_handling: opening file\n{str(e)}")
            self.error_logger.logger.error(f"Error C2: {str(e)}")


    # to split cli file into separate file for each layer
    def split_layers(self): 
        try:
            with open(self.file,"r") as file:
                layer_number=0
                output_file=f"{self.file}-header.txt"

                for line in file.readlines():
                    stripped_line = line.strip()
                    if not stripped_line.startswith("$$LAYER/"):
                       # code for normal lines
                       with open(output_file,'a') as out_f:
                           out_f.writelines(stripped_line)
                           out_f.write("\n")

                    # code for $$LAYER/ line
                    elif stripped_line.startswith("$$LAYER/"):
                       
                        layer_number +=1
                        output_file=f"{self.file}-Layer{str(layer_number)}.txt"
                        with open(output_file,'a') as out_f:
                           out_f.writelines(stripped_line)
                           out_f.write("\n")
                print("Split successful")
                self.fileNameLabel.setText("Split successful")

        except Exception as e:
            print(f"Error C3: Error in cli_handling: during splitting the file\n{str(e)}")
            self.error_logger.logger.error(f"Error C3: {str(e)}")


    # to extract file information from header
    def get_header_variables(self):
        try:
            with open(self.file,"r") as header:
                for line in header.readlines():
                    if line.startswith("$$DIMENSION/"):
                        temp_data = line.split("/")[1]
                        temp_data = temp_data.split(",")
                        self.min_dimension = temp_data[:3]
                        self.max_dimension = temp_data[3:]
                        self.dimension = [self.min_dimension, self.max_dimension]
                    elif line.startswith("$$LAYERS/"):
                        self.total_layers = int(line.split("/")[1])

                    elif line.startswith("$$UNITS/"):
                        self.unit = float(line.split("/")[1])  # units are in mm
                
                print(f"Dimensions: {self.dimension}")
                print(f"Total layers: {str(self.total_layers)}")
                print(f"Unit: {str(self.unit)} mm")

        except Exception as e:
            print(f"Error C4: Error in cli_handling: extracting header variables \n{str(e)}")
            self.error_logger.logger.error(f"Error C4: {str(e)}")


    # to extract data from cli file and save it in the form of a dictionary
    def extract_data(self):
        try:
            self._markData = collections.OrderedDict()
            self.polyline_number = 1
            self.hatch_number = 1

            with open(self.file,"r") as file:
                for line in file.readlines():

                    # For layer height
                    if line.startswith("$$LAYER/"):
                        self.current_layer = float(line.split("/")[1])

                    # For HATCHES
                    elif line.startswith("$$HATCHES"):
                        line = line.split(",")

                        id = int(line[0].split("/")[1])
                        n = int(line[1])
                        total_coordinates_hatch = n*4
                        self._markData[f"$$HATCHES {str(self.hatch_number)}"] = {
                            
                            "id":id,
                            "n":n,
                            "total_coordinates": total_coordinates_hatch,
                            "coordinates": line[2:]

                        }

                        self.hatch_number += 1


                    # For POLYLINE
                    elif line.startswith("$$POLYLINE"):
                        line=line.split(",")

                        # get parameter data
                        id = int(line[0].split("/")[1])
                        dir = int(line[1])
                        n = int(line[2]) # no. of coordinates
                        
                        self._markData[f"$$POLYLINE {str(self.polyline_number)}"]={
                            "id": id,
                            "total_coordinates":n,
                            "dir": dir,
                            "coordinates": line[3:]
                        }

                        self.polyline_number += 1

            file.close()

            # printing the dictionary contents
            # pprint(self._markData)

            # save ordered dictionary into a file using json.
            json_data = json.dumps(self._markData)

            with open("output.json","w") as outfile:
                outfile.write(json_data)


        except Exception as e:
            print(f"Error C5: Error in cli_handling: while extracting data into dict \n{str(e)}")
            self.error_logger.logger.error(f"Error C5:{str(e)}")


    # convert dictionary to a list of coordinates
    def convert_to_list(self):
        try:
            self.coord_list = []
            self.coordinates = []
            for h_p in self._markData.keys():

                if h_p.startswith("$$HATCHES"):
                    self.coordinates = self._markData[h_p]["coordinates"]
                    
                    # separating the x and y coordinates
                    x_list = self.coordinates[::2]
                    y_list = self.coordinates[1::2]

                    # forming the x,y coordinate tuples and appending laser on/off data to each coordinate
                    for i in range(len(x_list)):
                        if i & 1:
                            self.coord_list.append([x_list[i],y_list[i],1])
                        else:
                            self.coord_list.append([x_list[i],y_list[i],0])



                if h_p.startswith("$$POLYLINE"):

                    self.coordinates = self._markData[h_p]["coordinates"]
                    # separating the x and y coordinates
                    x_list = self.coordinates[::2]
                    y_list = self.coordinates[1::2]

                    # forming the x,y coordinate tuples and appending laser on/off data to each coordinate
                    for i in range(len(x_list)):
                        if i == 0:
                            self.coord_list.append([x_list[i],y_list[i],0])  # while going to the first point, the laser needs to be off
                        else:
                            self.coord_list.append([x_list[i],y_list[i],1])

            # print(self.coord_list)
       
        
        except Exception as e:
            print(f"Error C6: Error in cli_handling: while converting to list \n{str(e)}")


    # 1. Convert coordinate list into a list of float elements
    # 2. Flatten the matrix into a 1D list for easier processing
    # 3. Convert the 1D float list to bytearray
    def convert_to_payload(self):
        try:
            # convert coordinate list into a list of float elements
            try:
                self.new_coord_list = []
                for row in self.coord_list:
                    new_row = []
                    for element in row:
                        new_row.append(float(element))
                    self.new_coord_list.append(new_row)

                # print(self.new_coord_list)

            except Exception as e:
                print(f"Error C7: Error in cli_handling: while converting coordinates into float \n{str(e)}")


            # flatten the matrix into a list for easier processing
            try:
                self.float_data = []
                self.float_data = [val for row in self.new_coord_list for val in row]

                # print(self.float_data)
            except Exception as e:
                print(f"Error C8: Error in cli_handling: while converting into 1D float list \n{str(e)}")

            # converting 1D float list to bytes
            self.hex_data = [self.float_to_bytes(f) for f in self.float_data]

        except Exception as e:
            print(f"Error C9: Error in cli_handling: while converting into payload\n{str(e)}")



    # function to convert list of floats to byte array
    def float_to_bytes(self,f):
        float_as_bytes = struct.pack('>d', f)  # Pack float to double-precision bytes
        return bytearray(float_as_bytes)  # Convert bytes to bytearray



    # functions for plotting a graphical preview of the layer
    def update_plot(self):
        self.plot_widget.clear()

        for item in self.plot_widget.items():
            self.plot_widget.removeItem(item)
    
        self.plot_example()  


    def plot_example(self):
        self.plot_widget.setTitle(self.fName[0])

        coordinates = np.array(self.new_coord_list)
        x_points = coordinates[:, 0]
        y_points = coordinates[:, 1]
        fill_flags = coordinates[:, 2]

        # Arrays to store batch plot data
        lines_x = []
        lines_y = []
        points_x = []
        points_y = []

        for i in range(len(x_points) - 1):
            if fill_flags[i] == 0:
                lines_x.extend([x_points[i], x_points[i+1]])
                lines_y.extend([y_points[i], y_points[i+1]])
                lines_x.append(None)  # Adding None to break the line
                lines_y.append(None)
            else:
                points_x.extend([x_points[i], x_points[i+1]])
                points_y.extend([y_points[i], y_points[i+1]])

        # Ensure the last point is plotted if it's not connected to the next
        if fill_flags[-1] == 0:
            points_x.append(x_points[-1])
            points_y.append(y_points[-1])

         # Convert lists to NumPy arrays, excluding None values
        lines_x = np.array(lines_x, dtype=float)
        lines_y = np.array(lines_y, dtype=float)
        points_x = np.array(points_x, dtype=float)
        points_y = np.array(points_y, dtype=float)

  
        self.plot_widget.plot(lines_x, lines_y, pen=pg.mkPen('b', width=2))
        self.plot_widget.plot(points_x, points_y, pen=None)
        
        self.plot_widget.showGrid(x=True, y=True)



    # communicating with the FPGA board through socket
    def socket_communication(self):
        # HOST = '10.114.56.217' 
        # PORT = 7 

        HOST = '127.0.0.1' 
        PORT = 65432  
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # to add header and tail marker to payload
        header_marker = 'AAA'
        end_marker = 'Z' 
        payload_header = header_marker.encode('utf-8')
        payload_tail= end_marker.encode('utf-8')

        #loop continues until there is data remaining in self.hex_data -  # send it over the socket - 1500 bytes at a time
        while self.hex_data:
            self.payload = bytearray()

            # adding header
            self.payload.extend(payload_header)

            for byte_array in self.hex_data[:177]:  # vary the element index acc. to payload size
                self.payload.extend(byte_array) 

            # debugging code
            print(self.payload)
            print(type(self.payload))
            print(len(self.payload))

            # adding tail marker to the payload
            self.payload.extend(payload_tail)

            sock.connect((HOST, PORT))
            # self.payload = self.hex_data[:187]
            sock.sendall(self.payload)
            self.hex_data = self.hex_data[187:]
        
        sock.close()
        print("Coordinate information successfully sent to FPGA.")
        self.fileInfoLabel.setText("Coordinate information successfully sent to FPGA")

       
    def start_comms(self):
        self.fileInfoLabel.setText("Communicating with  FPGA ...")
        self.error_logger.flush_logs()
        self.socket_communication()

    def pause_comms(self):
        self.fileInfoLabel.setText("Communication with FPGA PAUSED")

    def stop_comms(self):
        self.fileInfoLabel.setText("Communication with FPGA abruptly TERMINATED")


    # functions for plotting the 4 shapes directly

    def square_plotter(self):
        self.fileInfoLabel.setText("You have selected SQUARE!")

        # enable the socket communication buttons
        self.startButton.setEnabled(True)
        self.pauseButton.setEnabled(True)
        self.stopButton.setEnabled(True)


    def triangle_plotter(self):
        self.fileInfoLabel.setText("You have selected TRIANGLE!")

        # enabled the socket communication buttons
        self.startButton.setEnabled(True)
        self.pauseButton.setEnabled(True)
        self.stopButton.setEnabled(True)

    def circle_plotter(self):
        self.fileInfoLabel.setText("You have selected CIRCLE!")

        # enable the socket communication buttons
        self.startButton.setEnabled(True)
        self.pauseButton.setEnabled(True)
        self.stopButton.setEnabled(True)

    def hatched_rectangle_plotter(self):
        self.fileInfoLabel.setText("You have selected RECTANGLE WITH HATCHING!")

        # enable the socket communication buttons
        self.startButton.setEnabled(True)
        self.pauseButton.setEnabled(True)
        self.stopButton.setEnabled(True)


########### main function ###########
app=QApplication(sys.argv)
CLI = cli_handling("main")
app.exec_()


