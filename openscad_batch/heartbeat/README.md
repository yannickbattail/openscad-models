# heartbeat scripts

Collection of scripts to monitor a command and play a heartbeat like an electrocardiogram when command success or fail

- `heartbeat.sh` check command success or fail
- `heartbeat_file.sh` check file exists or not
- `heartbeat_ping.sh` check host respond to the ping
- `heartbeat_httping.sh` check an URI respond to http request
- `heartbeat_process.sh` check a process PID exists or not
- `beep.sh` play sound

## heartbeat.sh

Script that play a heartbeat like an electrocardiogram when command success or fail

Usage: `heartbeat.sh [OPTIONS] COMMAND`

- `-l`, `--log-file` `log_file`             log file for the output of the command.
- `-f`, `--frequency_note` `frequency`      frequency of the bip in Hz
- `-v`, `--volume` `bip_volume`             volume of the bip between 0 and 1
- `--ok` `bip`|`beeeep`|`noop`              action to do when the command is successful: bip (plays a short bip, beeeep (plays a long beep), noop or
  else (do nothing)
- `--fail` `bip`|`beeeep`|`noop`            action to do when the command fails: bip (plays a short bip, beeeep (plays a long beep), noop or else (do
  nothing)
- `COMMAND`                                 command to be executed, if the command return 0 (success) short bip is played else long beeeep is played

Requirements: command `play` from package `sox`.

ex:

```sh
heartbeat.sh ping -w 1 -c 1 192.168.1.1
heartbeat.sh ping -w 1 -c 1 perdu.com
heartbeat.sh httping -t 1 -c 1 http://perdu.com
heartbeat.sh head -c 0 somefile
heartbeat.sh ps -p \$PID
```

stop it with ctrl+c

## heartbeat_file.sh

Script that play a heartbeat like an electrocardiogram when a file exists or not.
It uses the command `head`.

Usage: `heartbeat_file.sh [HEARTBEAT_OPTIONS] [HEAD_OPTIONS] FILE`

- `HEARTBEAT_OPTIONS`                    option for the heartbeat command
- `HEAD_OPTIONS`                         options for the command `head`
- `FILE`                                 file to be watched

ex:

```sh
heartbeat_file.sh service.pid
heartbeat_file.sh process.lock
```

stop it with ctrl+c

## heartbeat_ping.sh

Script that play a heartbeat like an electrocardiogram when a host respond to the ping
It uses the command `ping`.

Usage: `heartbeat_ping.sh [HEARTBEAT_OPTIONS] [PING_OPTIONS] IP_or_HOSTNAME_to_ping`

- `HEARTBEAT_OPTIONS`                    option for the heartbeat command
- `PING_OPTIONS`                         options for the command `ping`
- `IP_or_HOSTNAME_to_ping`                 host IP or DNS

ex:

```sh
heartbeat_ping.sh perdu.com
heartbeat_ping.sh 192.168.1.1
```

stop it with ctrl+c

## heartbeat_httping.sh

Script that play a heartbeat like an electrocardiogram when an URI respond to http request
It uses the command `httping`.

Usage: `heartbeat_httping.sh [HEARTBEAT_OPTIONS] [HTTPING_OPTIONS] URI`

- `HEARTBEAT_OPTIONS`                    option for the heartbeat command
- `HTTPING_OPTIONS`                      options for the command `httping`
- `URI`                                  uri to ping

ex:

```sh
heartbeat_httping.sh http://perdu.com
heartbeat_httping.sh https://192.168.1.1:8080
```

stop it with ctrl+c

## heartbeat_process.sh

Script that play a heartbeat like an electrocardiogram when a process PID exists or not
It uses the command `ps`.

Usage: `heartbeat_process.sh [HEARTBEAT_OPTIONS] [PS_OPTIONS] PID`

- `HEARTBEAT_OPTIONS`                    option for the heartbeat command
- `PS_OPTIONS`                           options for the command `ps`
- `PID`                                  PID of the process to be watched

ex:

```sh
heartbeat_process.sh 42666

sleep 10 & ### or other cmd with a & at the end
pid=$!
heartbeat_process.sh $pid
```

stop it with ctrl+c

## beep.sh

play sound

Usage: `beep.sh [DURATION_IN_SECONDS] [FREQUENCY] [VOLUME]`

- `DURATION_IN_SECONDS`                     duration of the sound
- `FREQUENCY`                               frequency of the bip in Hz
- `VOLUME`                                  volume of the bip between 0 and 1

Requirements: command 'play' from package 'sox'

ex:

```sh
beep.sh 2
beep.sh 0.3 440 0.5

# beep 200 to 20000 Hz increment 100
for i in $(seq 200 100 20000)
do
  ./beep.sh 0.5 $i 0.5
  echo -ne $i
done
```
