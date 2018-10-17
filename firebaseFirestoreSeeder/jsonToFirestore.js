const uuidv4 = require('uuid/v4');
const renameKeys = require('rename-keys');
const admin = require('./node_modules/firebase-admin');
const serviceAccount = require('./service-key.json');
const data = require('./data.json');
const cleanedData = {};
const collectionName = 'drinks';
const databaseInstance = 'barflashcards-4b756';
const settings = {timestampsInSnapshots: true};

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: `https://${databaseInstance}.firebaseio.com`
});

const firestore = admin.firestore();
firestore.settings(settings);

// * rename object KEYS
for (var key in data) {
	if (data.hasOwnProperty(key)) {
		var items = data[key];
		var newItem = renameKeys(items, function(key, val) {
			return uuidv4();
		});
		// console.log(newItem);
		cleanedData[collectionName] = newItem;
	}
}

// console.log(cleanedData);

cleanedData &&
	Object.keys(cleanedData).forEach(key => {
		// console.log(key);
		const nestedContent = cleanedData[key];

		if (typeof nestedContent === 'object') {
			// console.log(nestedContent);

			Object.keys(nestedContent).forEach(docTitle => {
				console.log(docTitle);

				// set dateAdded property
				nestedContent[
					docTitle
				].dateAdded = admin.firestore.FieldValue.serverTimestamp();

				firestore
					.collection(key)
					.doc(docTitle)
					.set(nestedContent[docTitle])
					.then(res => {
						console.log('Document successfully written!');
					})
					.catch(error => {
						console.error('Error writing document: ', error);
					});
			});
		}
	});
