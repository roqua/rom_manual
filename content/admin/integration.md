---
title: Integratie
sort: 450
---

RoQua kent twee integratie-methoden: de HTTP API waarmee onze applicatie
programmatisch ontsloten wordt, en de single sign-on koppelingen waarmee uw
gebruikers in RoQua kunnen inloggen zonder handmatige authenticatie.

Beide koppelingen hebben het concept van een "token". Voor de API-tokens is dat
waarmee uw applicatie zich authenticeerd bij onze service. Voor SSO-tokens wordt
de consumer_secret gebruikt om de login-URL te ondertekenen, zodat onze
applicatie kan controleren dat het een geldige login betreft.
