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
            self.response_log = self.parent.rsponse_log

        except Exception as e:
            print(f"Serial Communication class initialization failed. {e}")


    def send_port_list(self):
        """Scan and list available COM ports."""
        ports = serial.tools.list_ports.comports()
        return ports

    def connect(self):
        """Connect or disconnect the serial port."""
        if self.serial_port and self.serial_port.is_open:
            self.serial_port.close()
        else: 
            self.parent.log_history({"Error":"Port already occupied in a communication"})


    def disconnect(self, port, baud_rate):
            selected_port = port
            self.serial_port = serial.Serial(selected_port, baudrate=baud_rate,timeout=2)


    def send_data(self, LineEdit):
        """Send data via UART."""
        if self.serial_port and self.serial_port.is_open:
            data = LineEdit.toPlainText()
            self.serial_port.write(data.encode('utf-8'))
            LineEdit.clear()

    def closeEvent(self, event):
        """Ensure the serial port is closed on exit."""
        if self.serial_port and self.serial_port.is_open:
            self.serial_port.close()
        




