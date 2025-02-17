# Fast-Shop

**Dein schneller Weg zum Shopping**

Fast-Shop ist die ideale Lösung für alle, die schnell und unkompliziert Kleidung einkaufen möchten. Die App richtet sich an modebewusste Menschen, die keine Zeit oder Lust haben, stundenlang nach passenden Outfits zu suchen. Fast-Shop vereinfacht den gesamten Einkaufsprozess durch eine benutzerfreundliche Oberfläche, intelligente Filter und personalisierte Empfehlungen, die genau auf den individuellen Stil zugeschnitten sind.

Im Gegensatz zu anderen Plattformen setzt Fast-Shop auf maximale Einfachheit und Geschwindigkeit: Keine unnötigen Schritte, sondern ein Einkaufserlebnis, das sich auf das Wesentliche konzentriert. Egal ob für den Alltag, besondere Anlässe oder spontane Shopping-Launen – Fast-Shop macht Mode zugänglich, schnell und stressfrei.


## Design
Füge hier am Ende die Screenshots deiner App ein (achte hierbei auf die Guidelines).

<p>
  <img src="./img/Warenkorb.png" width="200">
  <img src="./img/Home.png" width="200">
  <img src="./img/Search.png" width="200">
</p>


## Features
<!-- Hier kommen alle Features rein, welche deine App bietet. -->

 **Tipp: Du kannst diese Punkte auch am Anfang ausfüllen und mit der Zeit abhaken, sodass am Ende eine vollständige Liste entsteht.** 

- [x] Schnellfilter
- [x] Anonym Einkaufen
- [x] Intelligente Suchfunktion
- [x] Warenkorb-Erinnerungen


## Technischer Aufbau

Das Projekt verwendet Swift und basiert auf der MVVM-Architektur (Model-View-ViewModel).

Ordnerstruktur
	•	Model's
Enthält die Datenstrukturen und Klassen, die direkt mit der API (Platzi Fake Store API) und der Datenbank (Firebase Firestore) interagieren.
	•	View's
Beinhaltet alle SwiftUI-Views, die die Benutzeroberfläche darstellen. Jede View ist schlank und bezieht ihre Daten direkt aus dem entsprechenden ViewModel.
	•	ViewModel's
Verarbeitet Daten aus dem Model und bereitet sie für die Views auf. Enthält die Geschäftslogik und steuert die Kommunikation zwischen View und Model.
	•	Repository's
Dient als Abstraktionsschicht für Datenzugriffe. Koordiniert die Kommunikation zwischen der Platzi Fake Store API und Firebase Firestore.
	•	Client
Beinhaltet die API-Schnittstellen und Netzwerkanfragen sowie die Firebase-Datenbankkonfiguration.


Für die Datenspeicherung wird Firebase Firestore verwendet, eine flexible, cloudbasierte NoSQL-Datenbank.

Warum Firebase Firestore?
	•	Offline-First: Daten werden lokal zwischengespeichert und bei Verbindung synchronisiert.
	•	Echtzeit-Updates: Änderungen an Daten werden in Echtzeit auf alle Geräte übertragen.
	•	Einfach zu integrieren: Dank der Firebase SDK-Unterstützung für Swift.

Gespeicherte Daten
	1.	Benutzerdaten:
	•	Profilinformationen wie Name und E-Mail-Adresse.
	•	Favorisierte Produkte (Wunschliste).
	2.	Produktinformationen:
	•	Caching von abgerufenen Produktdetails (z. B. Preis, Beschreibung).
	3.	Einstellungen:
	•	Benutzerpräferenzen (z. B. Sortierung, Anzeigeoptionen).

Die App verwendet die Platzi Fake Store [Api](https://fakeapi.platzi.com/en/rest/products/), um Produktdaten abzurufen.


Verwendete Endpunkte:
	•	GET /products: Ruft alle Produkte ab.
	•	GET /products/{id}: Ruft detaillierte Informationen zu einem Produkt ab.
	•	GET /categories: Ruft die verfügbaren Kategorien ab.
	•	GET /products/category/{category}: Ruft Produkte einer bestimmten Kategorie ab.

Die API-Daten werden im Repository abgefragt und im ViewModel aufbereitet, bevor sie an die View weitergegeben werden.

Warum die Platzi Fake Store API?
	•	Einfachheit: Eine leicht verständliche und gut dokumentierte API.
	•	Schnelligkeit: Ideal für Prototypen und Testentwicklungen.

#### 3rd-Party Frameworks
	
  •	FirebaseFirestore: Für die Speicherung und Synchronisierung von Daten.
	•	FirebaseAuth: Für die Benutzer-Authentifizierung (z. B. Anmeldung mit E-Mail).
	•	FirebaseAnalytics: Für die Analyse des Nutzerverhaltens.


## Ausblick

- [ ] Mehrere Markenklammotten mit einbringen
- [ ] Mehrere Zahlungsmöglichkeiten einbinden
- [ ] ...
