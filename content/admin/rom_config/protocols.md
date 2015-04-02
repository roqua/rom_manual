# Protocollen

## Protocollen

In het overzicht van protocollen is te zien welke protocollen er zijn, en welke metingen dat protocol heeft. Ook is het hier mogelijk een nieuw protocol te maken. Doorklikken op de naam van het protocol biedt toegang tot het beheren van metingen van dat protocol, terwijl doorklikken op de naam van een meting rechtstreeks naar het beheren van die meting gaat, alwaar vragenlijsten kunnen worden toegewezen aan die meting.

Verwijderen van protocollen gaat via de prullenbak-knop. Verwijderde protocollen kunnen later hersteld worden.

<%= screenshot "admin_protocols_index" %>

<ul class="hints hints-sidebar">
  <li>Verwijderde protocollen en metingen blijven zichtbaar in de Admin, maar zijn niet zichtbaar in de EPD-weergave. Protocollen kunnen nooit volledig verwijderd worden, omdat ingevulde lijsten (en andere gegevens) bijhouden vanuit welk protocol dat gedaan is, en deze relatie moet in stand gehouden worden voor historische data.</li>
</ul>


## Metingen

Bij elk protocol is een lijst van metingen, en het is mogelijk nieuwe metingen toe te voegen. Klik daarvoor op de knop "Nieuwe meting aanmaken". Verwijderen van metingen gaat via de prullenbak-knop. Verwijderde metingen kunnen later hersteld worden.

<%= screenshot "admin_protocols_measurements" %>


## Vragenlijsten

Bij elke meting staat de lijst van vragenlijsten weergegeven. Onderaan is het tevens mogelijk om extra lijsten toe te voegen. Met de pijltjes bij een lijst is het mogelijk om de volgorde van de vragenlijsten te veranderen.

Bij een meting kunt u per vragenlijst een aantal opties instellen. Klik daarvoor op de <%= icon "edit_icon" %>-knop bij de vragenlijst. In het volgende scherm zijn een aantal opties in te stellen voor de gekozen vragenlijst. Deze opties blijven altijd beperkt tot de vragenlijst binnen deze meting, lijsten kunnen dus per meting verschillende opties hebben.

<%= screenshot "admin_recently_answered_questionnaires_timespan" %>

### Standaard aangevinkt

RoQua heeft de mogelijkheid om vragenlijsten binnen een meting standaard aangevinkt te maken wanneer je vragenlijsten gaat klaarzetten.

### Tijdspanne

Bij elke vragenlijst van een protocol kan een tijdspanne worden ingesteld. Deze tijdspanne wordt gebruikt om te bepalen of een lijst nog recent genoeg is ingevuld om niet nog een keer te hoeven worden afgenomen.

Het effect van deze instelling is dat wanneer een medewerker een lijst gaat klaarzetten, en deze lijst is nog in bijvoorbeeld de afgelopen 3 weken ingevuld, dan wordt deze lijst los van de rest weergegeven. Recent ingevulde vragenlijsten zijn nooit standaard aangevinkt.

<%= screenshot "epd_recently_answered_fixed_questionnaires" %>


