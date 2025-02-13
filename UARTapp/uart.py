import sys
import serial
import serial.tools.list_ports


class SerialComm:
    def __init__(self, parent=None):
        try:
            
            self.parent = parent
            self.serial_port = None 

            # Console logging
            self.history_console = self.parent.history_console
            self.response_log = self.parent.response_log

        except Exception as e:
            print(f"Serial Communication class initialization failed. {e}")


    def send_port_list(self):
        """Scan and list available COM ports."""
        ports = serial.tools.list_ports.comports()
        return ports

    def disconnect(self):
        """Connect or disconnect the serial port."""
        if self.serial_port and self.serial_port.is_open:
            self.serial_port.close()


    def connect(self, port, baud_rate):
            selected_port = port
            try:
                self.serial_port = serial.Serial(selected_port, baudrate=baud_rate,timeout=2)
                # self.parent.log_history({"info":f"Connection to {port} at baud rate {baud_rate} has been established!"})
                # self.parent.log_response({"info":f"Connection to {port} at baud rate {baud_rate} has been established!"})
            except Exception as e:
                self.parent.log_history({"error":f"Connection to {port} failed! \n {e}"})
                self.parent.log_response({"error":f"Connection to {port} failed! \n {e}"})



    def send_data(self, LineEdit):
        """Send data via UART."""
        if self.serial_port and self.serial_port.is_open:
            try:
                data = LineEdit.toPlainText()
                self.serial_port.write(data.encode('utf-8'))
                LineEdit.clear()
                self.parent.log_history({"info":f"Message `{data}` is sent"})
            except Exception as e:
                self.parent.log_history({"error":"Data could not be sent"})

    def closeEvent(self):
        """Ensure the serial port is closed on exit."""
        if self.serial_port and self.serial_port.is_open:
            self.serial_port.close()
        




