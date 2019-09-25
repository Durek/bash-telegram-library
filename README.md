# Bash Telegram Library
Telegram bot library written in bash
  
  
## Introduction
teleLib.sh is intended to be used as a library by other bash scripts.  

It's meant to be easy to understand and fast to use.  

If you want to write an actual bot with many features you should probably look into nodejs or other languages.
  
  
## Using teleLib.sh
Following these steps you should be up and running within about 2 minutes.

### Prerequisites
teleLib.sh depends on:  
* curl
* jq  


Depending on your OS you can install these using the default package manager.  

If you are running a current Debian (based) OS, simply run

```apt install curl jq```

### Installation
teleLib.sh is installed by downloading the script and placing it either next to your main script or in any accessible directory.

Choose where you want teleLib.sh to be located and download it

```wget https://raw.githubusercontent.com/M0V3/bash-telegram-library/master/teleLib.sh```

*or*

```curl -O https://raw.githubusercontent.com/M0V3/bash-telegram-library/master/teleLib.sh```

### Usage
First things first: include teleLib.sh in your script

```source teleLib.sh```

Initialize teleLib.sh with your Bot API Token

```teleLib_init YourTokenHere```

Now you are already able to use any function you can find in the next section.

The following example sends "Its working!" to user id 1337

```
source lib/teleLib.sh
teleLib_init YourTokenHere
teleLib_sendMessage 1337 "Its working!"
```


## Functions
Functions are named after [Telegram API methods](https://core.telegram.org/bots/api#available-methods), go there for in-depth descriptions.

After executing a function you can find the results in the following variables

```functionName_result```: json response of the API

```teleLib_successful_result```: 0/1; 0 = success, 1 = failure

```teleLib_handleResponse_result```: formatted string (success or errorcode + error message)

### getMe
```teleLib_getMe```

### sendMessage chatId message
```teleLib_sendMessage 1337 "Its working!"```
