import requests
import sys
import os

def read_env(key):
    if key in os.environ:
        return os.environ[key]
    else:
        print(f"failed to read env {key}")
        return ""

FILE_PATH = "snx"
API_PREFIX = "http://127.0.0.1:38118/bot" + "6534430379:AAERZRN-Ipn5jtF-un_1saZcNGmqeY_ap-E" + "/"

BOT_TARGET = "1278600516"
ADMIN_USERID = BOT_TARGET.replace("-100","")

COMMIT_MESSAGE = "1278600516"
UPDATE_CHANNEL_ID = "1278600516"

def addEntity(entities, origin_str, en_type, content, url = None) -> str:
    origin_len = len(origin_str)
    entity = {
        "type": en_type,
        "offset": origin_len,
        "length": len(content)
    }
    if url:
        entity["url"] = url
    entities.append(entity)
    return content


def waitReply(mid):
    last_update = 0
    while True:
        print(f"Waiting reply for {mid} offset {last_update}...")
        resp = requests.post(API_PREFIX + "getUpdates", json={"allowed_updates":["message"], "timeout": 20, "offset": last_update + 1})
        resp = resp.json()
        if not resp["ok"]:
            continue
        resp = resp["result"]
        for update in resp:
            if 'message' in update:
                msg = update["message"]
                if 'from' in msg and str(msg['from']["id"]) == ADMIN_USERID:
                    if 'reply_to_message' in msg and str(msg["reply_to_message"]["message_id"]) == str(mid):
                        return msg
        for update in resp:
            last_update = max(last_update, update["update_id"])


def sendMessage(message, user_id = BOT_TARGET, entities = None) -> int:
    data = {
        "chat_id" : user_id,
        "text": message,
        "entities": entities
    }
    print(message)
    print(entities)
    resp = requests.post(API_PREFIX + "sendMessage", json=data).json()
    print(resp)
    return int(resp["result"]["message_id"])

def sendDocument(user_id, path, message = "", entities = None):
    files = {'document': open(path, 'rb')}
    data = {'chat_id': user_id,
            'caption': message,
            'parse_mode': 'Markdown',
            'caption_entities': entities}
    response = requests.post(API_PREFIX + "sendDocument", files=files, data=data)
    print(response.json())

def sendCIRelease():
    zip = os.listdir(FILE_PATH)
    zip.sort()
    file = os.path.join(FILE_PATH, zip[0])
    entities = []
    message = f""
    sendDocument(user_id=UPDATE_CHANNEL_ID, path = file, message=message, )

if __name__ == '__main__':
    print(sys.argv)
    if len(sys.argv) != 2:
        print("Run Type: release, ci, debug")
        sys.stdout.flush()
        sys.stderr.flush()
        exit(1)
    mode = sys.argv[1]
    if mode == "release":
        sendCIRelease()
    elif mode == "ci":
        if COMMIT_MESSAGE.startswith("ci"):
            UPDATE_CHANNEL_ID = BOT_TARGET
        sendCIRelease()
    else:
        print("unknown mode")
