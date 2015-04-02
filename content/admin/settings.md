---
title: Instellingen
sort: 400
---

Hier kun je enkele instellingen maken voor de RoQua-applicatie zoals de weergave van een link naar de handleiding in de RoQua interface en of behandelaren gevraagd zullen worden om hun persoonlijke gegevens als zij voor het eerst van RoQua gebruik maken. Verder kun je opgeven na welke periode klaarstaande vragenlijsten een rood label krijgen en welk exportformaat gebruikt wordt voor het verzenden van ORU-berichten.

## Actieve functies

<div style="height: 230px; overflow: hidden">
  <img src="/assets/images/screenshots/instellingen.png" />
</div>

<ul>
  <li><strong>Invulperiode</strong> geeft aan na hoeveel tijd de labels van klaarstaande vragenlijsten rood zullen worden. Dit is ter attentie voor medewerkers, maar hangen verder geen consequenties aan.</li>
  <li><strong>Cache-tijd NAW</strong> geeft aan hoe lang RoQua de NAW-gegevens die worden opgehaald via een A19-koppeling zelf bewaart. Gegevens die we altijd behouden zijn postcode, geboortedatum en geslacht (voor onderzoek), en mobiele telefoonnummer en e-mailadres (voor automatische protocollen).</li>
</ul>

## Migreren ORU-koppeling

Voer de volgende stappen uit voor het migreren van de ORU-koppeling naar het meest recente exportformaat:

<ol>
  <li>
    Selecteer op de RoQua <strong>acceptatieomgeving</strong> het meest recente exportformaat als ORU-versie.
    <div style="height: 130px; overflow: hidden; border: 1px solid #ddd">
      <img style="margin-top: -210px" src="/assets/images/screenshots/instellingen.png" />
    </div>
  </li>
  <li>Controleer of dit exportformaat ook op de RoQua productieomgeving bestaat door de sleutel te vergelijken (het rijtje tekens tussen haakjes). Wanneer het formaat niet op productie bestaat, kies je een oudere versie die wel op acceptatie én productie bestaat.</li>
  <li>Klik op "Instellingen opslaan" op de RoQua <strong>acceptatieomgeving</strong>.</li>
  <li>
    Klik vervolgens op de "Genereer schema" knop om voor alle vragenlijsten een leeg ORU-bericht te   verzenden.
    <div style="height: 85px; overflow: hidden; border: 1px solid #ddd">
      <img style="margin-top: -340px" src="/assets/images/screenshots/instellingen.png" />
    </div>
  </li>
  <li>Gebruik de verzonden ORU-berichten om de database schema's bij te werken op de communicatieserver van je organisatie.</li>
  <li>Controleer of de schema-wijzigingen succesvol zijn doorgevoerd door nogmaals voor alle vragenlijsten lege ORU-berichten te verzenden.</li>
  <li>
    Selecteer op de RoQua <strong>productieomgeving</strong> het exportformaat met dezelfde sleutel (het rijtje tekens tussen haakjes) als het formaat wat geselecteerd is op de acceptatieomgeving en klik op "Instellingen opslaan".
    <div style="height: 130px; overflow: hidden; border: 1px solid #ddd">
      <img style="margin-top: -210px" src="/assets/images/screenshots/instellingen.png" />
    </div>
  </li>
</ol>

De ORU-koppeling is succesvol gemigreerd!
