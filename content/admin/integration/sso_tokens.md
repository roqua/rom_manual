---
title: Single sign-on tokens
sort: 100
---

<img src="/rom_manual/assets/images/screenshots/admin_sso_tokens_index.png" />

## Aanmaken

Vul onder "consumer_key" een identificerende naam in. Bij IP-filter kunnen één of meerdere IP-adressen of IP-ranges worden opgegeven. Voor API-requests wordt dit IP-filter opgelegd op het afzend-adres van het HTTP-request. Bij SSO-koppelingen legt het IP-filter een beperking op voor geldige IP-adressen die mogen inloggen.

Daarnaast moet voor elke token worden aangegeven wat de acties zijn die met die sleutel gedaan mogen worden. Dit gaat met de vinkjes onder "Rechten". De tekst bij elk vinkje linkt naar de documentatie van het betreffende recht.

<img src="/rom_manual/assets/images/screenshots/admin_sso_tokens_new.png" />

Na aanmaken wordt de `consumer_secret` **eenmalig** getoond. Beschouw dit als een wachtwoord, en stuur het dus nooit onversleuteld naar collega's. In de ideale werkwijze wordt de code rechstreeks vanuit RoQua naar de configuratie van het doelsysteem gekopieerd.

<img src="/rom_manual/assets/images/screenshots/admin_sso_tokens_created.png" />

## Intrekken

Om te zorgen dat een token niet langer toegang heeft tot RoQua kan deze worden ingetrokken. Ingetrokken tokens blijven staan in het overzicht.

<img src="/rom_manual/assets/images/screenshots/admin_sso_tokens_revoked.png" />

