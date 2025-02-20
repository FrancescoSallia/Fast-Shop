# Fast-Shop

**Dein schneller Weg zum Shopping**

Fast-Shop ist die ideale Lösung für alle, die schnell und unkompliziert Kleidung einkaufen möchten. Die App richtet sich an modebewusste Menschen, die keine Zeit oder Lust haben, stundenlang nach passenden Outfits zu suchen. Fast-Shop vereinfacht den gesamten Einkaufsprozess durch eine benutzerfreundliche Oberfläche, intelligente Filter und personalisierte Empfehlungen, die genau auf den individuellen Stil zugeschnitten sind.

Im Gegensatz zu anderen Plattformen setzt Fast-Shop auf maximale Einfachheit und Geschwindigkeit: Keine unnötigen Schritte, sondern ein Einkaufserlebnis, das sich auf das Wesentliche konzentriert. Egal ob für den Alltag, besondere Anlässe oder spontane Shopping-Launen – Fast-Shop macht Mode zugänglich, schnell und stressfrei.
<br><br><br>

<p>

![Image](https://github.com/user-attachments/assets/3e06fcd3-b6ec-4ea0-90b5-ebd0d153da86)  ![Image](https://github.com/user-attachments/assets/f7494ab8-9582-4ed1-8b07-9a77d9a380fc) ![Image](https://github.com/user-attachments/assets/38496f9c-ba6c-4730-aa77-6f4bb42c6e6a) ![Image](https://github.com/user-attachments/assets/1c81eeeb-5477-4716-a9ff-68d4a8fd8b74) 
![Image](https://github.com/user-attachments/assets/1e666fb0-b7b2-4a2d-8b46-48fd3452e233)
![Image](https://github.com/user-attachments/assets/cb67e0dd-904a-4a48-8f0c-524784c74c55) ![Image](https://github.com/user-attachments/assets/14f2b00d-e544-4413-bc70-eb5f102579b2) 
  <!--<img src="./img/SearchView.png" width="200"> -->
 <!-- <img src="./img/Search.png" width="200"> -->
</p>


## Features
<!-- Hier kommen alle Features rein, welche deine App bietet. -->

- [x] Schnellfilter
- [x] Favoresierung
- [x] Intelligente Suchfunktion
- [x] Warenkorb-Erinnerungen


## Technischer Aufbau

Das Projekt verwendet Swift und basiert auf der MVVM-Architektur (Model-View-ViewModel).

• <b>Models:</b><br>
Enthält die Datenstrukturen und Klassen, die direkt mit der lokalen MockAPI (basierend auf der Platzi Fake Store API) und der Firebase Firestore-Datenbank interagieren.


• <b>Views:</b><br>
Beinhaltet alle SwiftUI-Views, die die Benutzeroberfläche darstellen. Jede View ist schlank und bezieht ihre Daten direkt aus dem entsprechenden ViewModel.

• <b>ViewModels:</b><br>
Verarbeitet Daten aus dem Model und bereitet sie für die Views auf.
Enthält die Geschäftslogik und steuert die Kommunikation zwischen View und Model.

• <b>Repositories:</b><br>
Dient als Abstraktionsschicht für Datenzugriffe. Koordiniert die Kommunikation zwischen der MockAPI und Firebase Firestore, um eine stabile und zuverlässige Datenquelle zu gewährleisten.

• <b>Client:</b><br>
Beinhaltet die API-Schnittstellen und Netzwerkanfragen zur lokalen MockAPI sowie die Firebase-Datenbankkonfiguration.
<br>

Für die Datenspeicherung wird <b>Firebase Firestore</b> verwendet, eine flexible, cloudbasierte NoSQL-Datenbank.

Warum Firebase Firestore?
<br><br>
• <b>Offline-First:</b><br>
Daten werden lokal zwischengespeichert und bei Verbindung synchronisiert.

• <b>Echtzeit-Updates:</b><br>
Änderungen an Daten werden in Echtzeit auf alle Geräte übertragen.

•Einfach zu integrieren:
• <b>Einfach zu integrieren:</b><br>
Dank der Firebase SDK-Unterstützung für Swift.

Gespeicherte Daten
<b>Benutzerdaten:</b><br>
•Profilinformationen wie Name und E-Mail-Adresse.
•Favorisierte Produkte (Wunschliste).

<b>Produktinformation:</b><br>
•Caching von abgerufenen Produktdetails (z. B. Preis, Beschreibung).

<b>Einstellungen:</b><br>
•Benutzerpräferenzen (z. B. Sortierung, Anzeigeoptionen).

Die App verwendet eine eigene MockAPI, die auf Basis der [Platzi Fake Store API](https://fakeapi.platzi.com/en/rest/products/) erstellt wurde .
Da die öffentliche API frei zugänglich ist und häufig durch andere Nutzer verändert oder gelöscht wurde, wurde eine eigene, stabile MockAPI implementiert. Diese stellt die gleichen Endpunkte bereit, jedoch mit kontrollierten und unveränderlichen Daten.

Verwendete Endpunkte der MockAPI:
<b>Verwendete Endpunkte der MockAPI:</b><br>

•GET /products – Ruft alle Produkte ab.
•GET /products/{id} – Ruft detaillierte Informationen zu einem Produkt ab.
•GET /categories – Ruft die verfügbaren Kategorien ab.
•GET /products/category/{category} – Ruft Produkte einer bestimmten Kategorie ab.

Die Daten der MockAPI werden im Repository abgefragt und im ViewModel verarbeitet, bevor sie an die View weitergegeben werden.

Warum eine eigene MockAPI?

✅ Stabilität – Keine unerwarteten Änderungen durch externe Nutzer.
✅ Zuverlässigkeit – Konsistente Produktdaten für Tests und Entwicklung.
✅ Flexibilität – Möglichkeit zur Anpassung der API-Struktur für zukünftige Erweiterungen.

#### 3rd-Party Frameworks
• <b>FirebaseAuth:</b><br>
Für die Benutzer-Authentifizierung (z. B. Anmeldung mit E-Mail).
	

## Ausblick

- [ ] Mehrere Markenklammotten mit einbringen
- [ ] Mehrere Zahlungsmöglichkeiten einbinden
- [ ] One-Click-Bestellung für wiederkehrende Käufer
- [ ] Wunschlisten teilen mit Freunden oder Familie
- [ ] ...
