#
#
# teleLib.sh
#  https://github.com/M0V3/bash-telegram-library
#
#
# MIT License
#
# Copyright (c) 2019 M0V3
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
#



# Check for dependencies

if [ ! `command -v curl` ] ; then
        echo "Package curl is missing"
        _ERROR=1
fi
if [ ! `command -v jq` ] ; then
        echo "Package jq is missing"
        _ERROR=1
fi
if [ "$_ERROR" == "1" ]; then
	exit 1
fi



#### teleLib.sh FUNCTIONS ####

# API access point
#  ex. usage: res=`eval $API/sendMessage -d chat_id='1' -d text='text'`
teleLib_API="curl -s -X POST https://api.telegram.org/bot"

# Initialize library
# telelib_init(botToken); botToken = telegram bot api token
teleLib_init() {
	if [ -z "$1" ]; then
		echo "Please define a bot api token like this: teleLib_init YourTokenHere"
		exit 1
	fi

	teleLib_API=$teleLib_API$1
}


# teleLib_sucessful(arg1); arg1 = full json response from api
# teleLib_sucessful_result = [0|1];
teleLib_successful_result=""
teleLib_successful() {
	if [ `echo $1 | jq -r '.ok'` == "true" ]; then
		teleLib_successful_result="1"
	else
		teleLib_successful_result="0"
	fi
}

# teleLib_handleResponse(arg1); arg1 = full json response from api
# teleLib_handleResponse_result = formatted string;
teleLib_handleResponse_result=""
teleLib_handleResponse() {
	teleLib_successful "$1"
	if [ "$teleLib_successful_result" = "1" ]; then
 		teleLib_handleResponse_result="success"
	else
		teleLib_handleResponse_result="failure:" `echo $1 | jq -r '.error_code'` "-" `echo $1 | jq -r '.description'`
	fi
}



#### API FUNCTIONS ####

# teleLib_getMe()
# teleLib_getMe_result = json response from api
teleLib_getMe_result=""
teleLib_getMe() {
	teleLib_getMe_result=`eval "$teleLib_API/getMe"`
	teleLib_handleResponse "$teleLib_getMe_result"
}

# teleLib_sendMessage(arg1 arg2); arg1 = chat id, arg2 = text
# teleLib_sendMessage_result = json response from api
teleLib_sendMessage_result=""
teleLib_sendMessage() {
	teleLib_sendMessage_result=`eval "$teleLib_API/sendMessage -d chat_id=$1 -d text='$2'"`
	teleLib_handleResponse "$teleLib_sendMessage_result"
}


## NOT IMPLEMENTED YET ##

teleLib_forwardMessage(){}
teleLib_sendPhoto(){}
teleLib_sendAudio(){}
teleLib_sendDocument(){}
teleLib_sendVideo(){}
teleLib_sendAnimation(){}
teleLib_sendVoice(){}
teleLib_sendVideoNote(){}
teleLib_sendMediaGroup(){}
teleLib_sendLocation(){}
teleLib_editMessageLiveLocation(){}
teleLib_stopMessageLiveLocation(){}
teleLib_sendVenue(){}
teleLib_sendContact(){}
teleLib_sendPoll(){}
teleLib_sendChatAction(){}
teleLib_getUserProfilePhotos(){}
teleLib_getFile(){}
teleLib_kickChatMember(){}
teleLib_unbanChatMember(){}
teleLib_restrictChatMember(){}
teleLib_promoteChatMember(){}
teleLib_setChatPermissions(){}
teleLib_exportChatInviteLink(){}
teleLib_setChatPhoto(){}
teleLib_deleteChatPhoto(){}
teleLib_setChatTitle(){}
teleLib_setChatDescription(){}
teleLib_pinChatMessage(){}
teleLib_unpinChatMessage(){}
teleLib_leaveChat(){}
teleLib_getChat(){}
teleLib_getChatAdministrators(){}
teleLib_getChatMembersCount(){}
teleLib_getChatMember(){}
teleLib_setChatStickerSet(){}
teleLib_deleteChatStickerSet(){}
teleLib_answerCallbackQuery(){}

teleLib_editMessageText(){}
teleLib_editMessageCaption(){}
teleLib_editMessageMedia(){}
teleLib_editMessageReplyMarkup(){}
teleLib_stopPoll(){}
teleLib_deleteMessage(){}

teleLib_sendSticker(){}
teleLib_getStickerSet(){}
teleLib_uploadStickerFile(){}
teleLib_createNewStickerSet(){}
teleLib_addStickerToSet(){}
teleLib_setStickerPositionInSet(){}
teleLib_deleteStickerFromSet(){}
