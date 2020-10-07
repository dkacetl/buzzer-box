#!/usr/bin/env python3

from random import randrange
from pygame import mixer  # Load the popular external library
import glob
import RPi.GPIO as GPIO # Import Raspberry Pi GPIO library
import time

print("-- Miluji praci --")
ButtonPin=16
LedPin=37

files = glob.glob("/home/pi/lakatos/*.ogg")
print(files)

def button_callback(channel):
    print("Button was pushed!")
    print(channel)
    mixer.music.stop()
    mixer.music.load(files[randrange(len(files))])
    mixer.music.play()

mixer.init()
GPIO.setwarnings(False) # Ignore warning for now
GPIO.setmode(GPIO.BOARD) # Use physical pin numbering
GPIO.setup(ButtonPin, GPIO.IN, pull_up_down = GPIO.PUD_DOWN) # Set pin 10 to be an input pin and set initial value to be pulled low (off)
GPIO.setup(LedPin, GPIO.OUT)
GPIO.output(LedPin, GPIO.HIGH)
GPIO.add_event_detect(ButtonPin, GPIO.RISING, callback=button_callback)

message = input("Press enter to quit.")
GPIO.cleanup()
