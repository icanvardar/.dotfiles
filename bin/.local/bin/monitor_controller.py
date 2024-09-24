#!/usr/bin/env python3

import json
import os
import re
import subprocess
import sys

BACKUP_FILE_PATH = "/var/tmp/sc_data.bin"
# found these from here https://www.thinkwiki.org/wiki/Xorg_RandR_1.2#Output_port_names
XRANDR_DISPLAY_TYPES = [
    "VGA", 
    "LVDS",
    "DP1",
    "TV",
    "TMDS-1",
    "TMDS-2",
    "LVDS1",
    "VGA1",
    "DVI1",
    "VGA-0",
    "LVDS",
    "S-video",
    "DVI-0",
    "HDMI",
    "DVI",
    "DP",
]

class Arg:
    def __init__(self, monitor_num, locate_to = None, side_monitor_num = None):
        self.monitor_num = monitor_num
        self.locate_to = locate_to
        self.side_monitor_num = side_monitor_num

    @staticmethod
    def get_arg(index):
        try:
            return sys.argv[index] 
        except IndexError:
            return None

    @classmethod
    def build(cls):
        try:
            mn = cls.get_arg(1)
            l_to = cls.get_arg(2)
            smn = cls.get_arg(3) 

            if mn is not None:
                mn = int(mn) - 1
                if mn < 0:
                    raise Exception("Wrong 'monitor_num' value.")

            if l_to is not None:
                if str(l_to) != "left" and str(l_to) != "right":
                    raise Exception("'location_to' value must be 'left' or 'right'.")

            if smn is not None:
                smn = int(smn) - 1
                if smn < 0:
                    raise Exception("Wrong 'location_of' value.")

            return cls(mn, l_to, smn)
        except:
            raise Exception

def get_backup_data(options):
    with open(BACKUP_FILE_PATH, "r") as backup_file:
        backup_data = backup_file.read()

        if len(backup_data) == 0:
            data = {}
            for option in options:
                data[str(option)] = True
            with open(BACKUP_FILE_PATH, "w") as backup_file:
                tmp = json.dumps(data)
                backup_file.write(' '.join(format(ord(letter), 'b') for letter in tmp))
                backup_file.close()
            return data
        else:
            data_raw = ''.join(chr(int(x, 2)) for x in backup_data.split())
            return json.loads(data_raw)

def save_backup_data(new_backup_data):
    with open(BACKUP_FILE_PATH, "w") as backup_file:
        tmp = json.dumps(new_backup_data)
        backup_file.write(' '.join(format(ord(letter), 'b') for letter in tmp))
        backup_file.close()

def turn_off_monitor(monitor_name, backup_data):
    subprocess.run(f'xrandr --output {monitor_name} --off', shell = True)

    backup_data[monitor_name] = False
    save_backup_data(backup_data)

def turn_on_monitor(monitor_name, to, side_monitor_name, backup_data):
    subprocess.run(f'xrandr --output {monitor_name} --auto --{to}-of {side_monitor_name}', shell = True)

    backup_data[monitor_name] = True
    save_backup_data(backup_data)

def control_monitor():
    if os.path.exists(BACKUP_FILE_PATH) is False:
        with open(BACKUP_FILE_PATH, "w") as backup_file:
            backup_file.close()
            pass

    monitors_raw = subprocess.run(
        "xrandr", 
        shell = True, 
        stdout = subprocess.PIPE,
        stderr = subprocess.STDOUT)
    
    # wow i can do regex search UwU
    pattern = r'([A-Za-z]+-\d+) connected'
    displays = re.findall(pattern, monitors_raw.stdout.decode()) 
    options = [display for display in displays 
        if any(display.startswith(dt) for dt in XRANDR_DISPLAY_TYPES)]

    try: 
        args = Arg.build()
        
        monitor_name = options[args.monitor_num]
        side_monitor_name = None
        if args.side_monitor_num is not None:
            side_monitor_name = options[args.side_monitor_num]

        backup_data = get_backup_data(options)

        is_turned_on = backup_data[monitor_name]

        if is_turned_on is True:
            turn_off_monitor(monitor_name, backup_data)
        else:  
            if args.locate_to is None or side_monitor_name is None:
                raise Exception("'locate_to' or 'location_of' arguments cannot be None.")
                
            turn_on_monitor(monitor_name, args.locate_to, side_monitor_name, backup_data)
    except IndexError:
        raise Exception("Invalid monitor number.")
    except:
        raise Exception

def main():
    control_monitor()

if __name__ == "__main__":
    main()
