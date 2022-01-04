var admin = require("firebase-admin");
var express = require("express");
var serviceAccount = require("C:/Users/Aymira Media/Desktop/save Projects/collowing_news - Copie/serviceAccountKey.json");
const  app = express();
app.use(express.json());

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

var db = admin.firestore();

app.post('/sendNotif', async(req, res, next)=>{
    const title = req.body.title;
    const text = req.body.maintext;
  
    var topics = [];
    const col = await db.collection('NotificationsT').get();
    col.forEach((doc) => {
        topics.push(doc.id);
    })

    console.log(topics)
    var message = {
        notification: {
            title: title,
            body: text
        },
        // token: registrationToken
    };

    admin.messaging().sendToDevice(topics, message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error sending message:', error);
        });
    res.json({status:"OK"});
    next();
  });

async function start( title, text) {
    var topics = [];
    const col = await db.collection('NotificationsT').get();
    col.forEach((doc) => {
        topics.push(doc.id);
    })

    console.log(topics)
    var message = {
        notification: {
            title: title.text,
            body: text.text
        },
        // token: registrationToken
    };

    admin.messaging().sendToDevice(topics, message)
        .then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error sending message:', error);
        });
        
}

async function main(){
    
  
    app.listen(8000);
  }


main()