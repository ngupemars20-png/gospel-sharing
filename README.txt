CATHOLIC GOSPEL SHARING — UPDATED PWA PACKAGE

Creator credit
Created and developed by NGUBE MARCELLUS NGUPE.
The creator credit appears on the home screen and in the About the App section.

Included
- Existing Seven Steps of Gospel Sharing guide
- Existing eight-part Self-Evaluation Scheme
- Existing 157 Sunday reading records
- Existing approved home-screen artwork
- Web app manifest with 192x192 and 512x512 PNG icons
- Service-worker registration for HTTPS and localhost
- Offline cache for the app shell, readings, guide data and artwork

Important
This is a Progressive Web App (PWA) website package, not an Android APK.
To install it as an app on Android, upload the contents of this folder to a secure
HTTPS web host. Then open the hosted address in Chrome on the phone and choose
Install app or Add to Home screen. Open the app once while online so its files
can be cached; after that, the app shell and bundled content are available offline.

Testing on Windows
The existing START_APP.bat and start-server.ps1 files are retained. Double-click
START_APP.bat and keep its PowerShell window open while testing. This uses localhost,
which permits service-worker registration in supported browsers.

Local file note
Opening index.html directly from File Explorer continues to display the app content,
but browsers do not permit service-worker registration from file:// URLs.


PERPETUAL LITURGICAL CYCLE
The app repeats the approved Sunday lectionary cycle Year A, Year B, Year C, then Year A again. It calculates the liturgical year from the First Sunday of Advent and maps each future Sunday to the corresponding Sunday position in the matching approved year. The app remains offline. The three-year cycle does not remove the need to verify future local diocesan calendar adjustments or official lectionary corrections; a new app release can incorporate such corrections.


SUNDAY REFLECTIONS UPDATE
- Adds a Sunday Reflections page without changing the approved home-screen artwork.
- Downloads published reflections from the GOSPEL SHARING Google Apps Script endpoint.
- Stores downloaded published reflections in the browser's local storage for offline reading.
- Attempts an update when the app opens online and whenever the device reconnects.
- Includes a manual Refresh button.
- The Apps Script endpoint must support JSONP callback requests. Update the doGet function as instructed separately before testing live downloads.
