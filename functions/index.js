const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

exports.sendConfirmationEmail = functions.https.onCall(async (data, context) => {
    const userEmail = data.userEmail;
    const eventName = data.eventName;

    // Retrieve user information from Firestore or other database
    const userSnapshot = await admin.firestore().collection('users').doc(userEmail).get();
    if (!userSnapshot.exists) {
        throw new functions.https.HttpsError('not-found', 'User not found');
    }

    const userName = userSnapshot.data().displayName; // Replace with your user's display name field

    // Email content
    const mailOptions = {
        from: '', // Sender email address
        to: userEmail,
        subject: 'Confirmation Email',
        text: `Dear ${userName},\n\nYou have successfully registered for the event '${eventName}'.\n\nThank you!`
    };

    // Send email using nodemailer
    try {
        await sendEmail(mailOptions);
        return { success: true };
    } catch (error) {
        console.error('Error sending email:', error);
        throw new functions.https.HttpsError('internal', 'Email sending failed');
    }
});

async function sendEmail(mailOptions) {
    // Create a SMTP transporter
    let transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: '', // Sender email address
            pass: '' // Sender email password
        }
    });

    // Send mail with defined transport object
    await transporter.sendMail(mailOptions);
}
