# SMMR

SMMR ir vasaras plānošanas sistēma, kas vienā vietā apvieno to-do sarakstu, ceļojumu galamērķus, mūzikas bibliotēku un filmu bibliotēku.

## Galvenās iespējas

- Lietotāja reģistrācija, pieslēgšanās un izrakstīšanās.
- Konta iestatījumi, paroles maiņa un konta dzēšana.
- Personīgs vasaras darbu vai vēlmju to-do saraksts.
- Ceļojumu sadaļa ar galamērķiem, aptuvenām nedēļas izmaksām un apskates objektiem.
- Mūzikas sadaļa ar dziesmu nosaukumiem, māksliniekiem, vākiem, izdošanas gadiem, žanru filtriem un Apple iTunes dziesmu priekšskatījumiem.
- Filmu sadaļa ar filmu nosaukumiem, studijām, izdošanas gadiem, plakātiem un žanru filtriem.
- Windows stila darbvirsmas saskarne ar mapju ikonām.

## Tehnoloģijas

- Laravel
- PHP
- MySQL
- Vue.js
- Tailwind CSS
- Vite
- Apple iTunes Search API dziesmu vākiem un priekšskatījumiem

## Datu bāze

Sistēmā tiek glabāti:

- lietotāji;
- lietotāju sesijas;
- lietotāju to-do ieraksti;
- dziesmas;
- mūzikas žanri;
- filmas;
- filmu žanri;
- ceļojumu galamērķi;
- apskates objekti.

## Lokāla palaišana

1. Uzstādi PHP, Composer, Node.js un MySQL.
2. Izveido `.env` failu no `.env.example`.
3. Norādi datu bāzes pieslēgumu `smmr_app`.
4. Palaid migrācijas:

```bash
php artisan migrate
```

5. Aizpildi lokālos mūzikas, filmu un ceļojumu datus:

```bash
php -r "$pdo = new PDO('mysql:host=127.0.0.1;port=3306;dbname=smmr_app', 'root', ''); $pdo->exec(file_get_contents('database/seed_local_media.sql')); $pdo->exec(file_get_contents('database/seed_travel.sql'));"
```

6. Palaid frontend izstrādes serveri:

```bash
npm run dev
```

7. Palaid Laravel serveri:

```bash
php artisan serve
```

## Projekta mērķis

Projekta mērķis ir palīdzēt lietotājam ērtāk saplānot vasaru. Lietotājs var pierakstīt savas ieceres, atrast iespējamos ceļojumu galamērķus, izvēlēties mūziku un apskatīt filmas, ko varētu izmantot vasaras atpūtai.
