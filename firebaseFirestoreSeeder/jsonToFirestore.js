const admin = require('./node_modules/firebase-admin');
const moment = require('./node_modules/moment');
const serviceAccount = require('./service-key.json');

const data = require('./data.json');

const databaseInstance = 'barflashcards-4b756';

const settings = {timestampsInSnapshots: true};

admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: `https://${databaseInstance}.firebaseio.com`
});

const firestore = admin.firestore();
firestore.settings({timestampsInSnapshots: true});

data &&
	Object.keys(data).forEach(key => {
		// console.log(key);
		const nestedContent = data[key];

		if (typeof nestedContent === 'object') {
			// console.log(nestedContent);

			Object.keys(nestedContent).forEach(docTitle => {
				// console.log(docTitle);

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
