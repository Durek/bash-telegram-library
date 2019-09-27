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

if [ ! "$(command -v curl)" ] ; then
        echo "Package curl is missing"
        teleLib_Error=1
fi
if [ ! "$(command -v jq)" ] ; then
        echo "Package jq is missing"
        teleLib_Error=1
fi
if [ "$teleLib_Error" == "1" ]; then
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
	if [ "$(echo $1 | jq -r '.ok')" == "true" ]; then
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
		teleLib_handleResponse_result="failure: $(echo $1 | jq -r '.error_code') - $(echo $1 | jq -r '.description')"
	fi
}

teleLib_notImplemented(){
	echo "$1 has not been implemented, yet."
}


#### API FUNCTIONS ####

# teleLib_getMe
# teleLib_getMe_result = json response from api
teleLib_getMe_result=""
teleLib_getMe() {
	teleLib_getMe_result=$(eval "$teleLib_API/getMe")
	teleLib_handleResponse "$teleLib_getMe_result"
}

# teleLib_sendMessage [chat_id] [text] {parse_mode} {disable_web_page_preview} {disable_notification} {reply_to_message_id} {reply_markup}
# teleLib_sendMessage_result = json response from api
teleLib_sendMessage_result=""
teleLib_sendMessage() {
	teleLib_additionalParams=""
	if [ ! -z "$3"  ]; then
		teleLib_additionalParams="$teleLib_additionalParams -d parse_mode='$3'"
	fi
        if [ ! -z "$4"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d disable_web_page_preview='$4'"
        fi
        if [ ! -z "$5"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d disable_notification='$5'"
        fi
        if [ ! -z "$6"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d reply_to_message_id='$6'"
        fi
        if [ ! -z "$7"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d reply_markup='$7'"
        fi

	teleLib_sendMessage_result=$(eval "$teleLib_API/sendMessage -d chat_id=$1 -d text='$2' $teleLib_additionalParams")
	teleLib_handleResponse "$teleLib_sendMessage_result"
}

# teleLib_forwardMessage [chat_id] [from_chat_id] [message_id] {disable_notification}
# teleLib_forwardMessage_result = json response from api
teleLib_forwardMessage_result=""
teleLib_forwardMessage(){
	teleLib_additionalParams=""
	if [ ! -z "$4"  ]; then
		teleLib_additionalParams="$teleLib_additionalParams -d disable_notification='$4'"
	fi

	teleLib_forwardMessage_result=$(eval $teleLib_API/forwardMessage -d chat_id=$1 -d from_chat_id=$2 -d message_id=$3 $teleLib_additionalParams)
	teleLib_handleResponse "$teleLib_forwardMessage_result"
}

# teleLib_sendPhoto [chat_id] [photo] {caption} {parse_mode} {disable_notification} {reply_to_message_id} {reply_markup}
# teleLib_sendPhoto_result = json response from api
teleLib_sendPhoto_result=""
teleLib_sendPhoto() {
	teleLib_additionalParams=""
        if [ ! -z "$3"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d caption='$3'"
        fi
        if [ ! -z "$4"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d parse_mode='$4'"
        fi
        if [ ! -z "$5"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d disable_notification='$5'"
        fi
        if [ ! -z "$6"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d reply_to_message_id='$6'"
        fi
        if [ ! -z "$7"  ]; then
                teleLib_additionalParams="$teleLib_additionalParams -d reply_markup='$7'"
        fi

	teleLib_sendPhoto_result=$(eval "$teleLib_API/sendPhoto -d chat_id=$1 -d photo='$2' $teleLib_additionalParams")
}

teleLib_sendAudio(){
	teleLib_notImplemented "sendAudio"
}
teleLib_sendDocument(){
	teleLib_notImplemented "sendDocument"
}
teleLib_sendVideo(){
	teleLib_notImplemented "sendVideo"
}
teleLib_sendAnimation(){
	teleLib_notImplemented "sendAnimation"
}
teleLib_sendVoice(){
	teleLib_notImplemented "sendVoice"
}
teleLib_sendVideoNote(){
	teleLib_notImplemented "sendVideoNote"
}
teleLib_sendMediaGroup() {
	teleLib_notImplemented "sendMediaGroup"
}
teleLib_sendLocation(){
	teleLib_notImplemented "sendLocation"
}
teleLib_editMessageLiveLocation(){
	teleLib_notImplemented "editMessageLiveLocation"
}
teleLib_stopMessageLiveLocation(){
	teleLib_notImplemented "stopMessageLiveLocation"
}
teleLib_sendVenue(){
	teleLib_notImplemented "sendVenue"
}
teleLib_sendContact(){
	teleLib_notImplemented "sendContact"
}
teleLib_sendPoll(){
	teleLib_notImplemented "sendPoll"
}
teleLib_sendChatAction(){
	teleLib_notImplemented "sendChatAction"
}
teleLib_getUserProfilePhotos(){
	teleLib_notImplemented "getUserProfilePhotos"
}
teleLib_getFile(){
	teleLib_notImplemented "getFile"
}
teleLib_kickChatMember(){
	teleLib_notImplemented "kickChatMember"
}
teleLib_unbanChatMember(){
	teleLib_notImplemented "unbanChatMember"
}
teleLib_restrictChatMember(){
	teleLib_notImplemented "restrictChatMember"
}
teleLib_promoteChatMember(){
	teleLib_notImplemented "promoteChatMember"
}
teleLib_setChatPermissions(){
	teleLib_notImplemented "setChatPermissions"
}
teleLib_exportChatInviteLink(){
	teleLib_notImplemented "exportChatInviteLink"
}
teleLib_setChatPhoto(){
	teleLib_notImplemented "setChatPhoto"
}
teleLib_deleteChatPhoto(){
	teleLib_notImplemented "deleteChatPhoto"
}
teleLib_setChatTitle(){
	teleLib_notImplemented "setChatTitle"
}
teleLib_setChatDescription(){
	teleLib_notImplemented "setChatDescription"
}
teleLib_pinChatMessage(){
	teleLib_notImplemented "pinChatMessage"
}
teleLib_unpinChatMessage(){
	teleLib_notImplemented "unpinChatMessage"
}
teleLib_leaveChat(){
	teleLib_notImplemented "leaveChat"
}
teleLib_getChat(){
	teleLib_notImplemented "getChat"
}
teleLib_getChatAdministrators(){
	teleLib_notImplemented "getChatAdministrators"
}
teleLib_getChatMembersCount(){
	teleLib_notImplemented "getChatMembersCount"
}
teleLib_getChatMember(){
	teleLib_notImplemented "getChatMember"
}
teleLib_setChatStickerSet(){
	teleLib_notImplemented "setChatStickerSet"
}
teleLib_deleteChatStickerSet(){
	teleLib_notImplemented "deleteChatStickerSet"
}
teleLib_answerCallbackQuery(){
	teleLib_notImplemented "answerCallbackQuery"
}

teleLib_editMessageText(){
	teleLib_notImplemented "editMessageText"
}
teleLib_editMessageCaption(){
	teleLib_notImplemented "editMessageCaption"
}
teleLib_editMessageMedia(){
	teleLib_notImplemented "editMessageMedia"
}
teleLib_editMessageReplyMarkup(){
	teleLib_notImplemented "editMessageReplyMarkup"
}
teleLib_stopPoll(){
	teleLib_notImplemented "stopPoll"
}
teleLib_deleteMessage(){
	teleLib_notImplemented "deleteMessage"
}

teleLib_sendSticker(){
	teleLib_notImplemented "sendSticker"
}
teleLib_getStickerSet(){
	teleLib_notImplemented "getStickerSet"
}
teleLib_uploadStickerFile(){
	teleLib_notImplemented "uploadStickerFile"
}
teleLib_createNewStickerSet(){
	teleLib_notImplemented "createNewStickerSet"
}
teleLib_addStickerToSet(){
	teleLib_notImplemented "addStickerToSet"
}
teleLib_setStickerPositionInSet(){
	teleLib_notImplemented "setStickerPositionInSet"
}

