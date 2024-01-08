# Relazione del Progetto: Applicazione Flutter per Squadre NBA
## Scopo del Progetto:
L'obiettivo del progetto è sviluppare un'applicazione mobile Flutter, dedicata alle squadre della lega NBA.
L'app fornisce informazioni dettagliate sulle squadre,  classifiche,  partite e statistiche di gioco.
L'obiettivo principale è offrire agli utenti un’ esperienza intuitiva e completa per seguire le principali informazioni e le prestazioni delle squadre NBA, durante la stagione corrente e quelle passate.

## Descrizione della Struttura dei Sorgenti:
Il progetto è strutturato in modo modulare, adottando una separazione delle responsabilità tra diversi componenti. Di seguito, una breve descrizione dei principali componenti:
# ViewModels (TeamList ViewModel, Standings ViewModel, Games ViewModel, Roster ViewModel, TeamStatistics ViewModel):  
Gestiscono i dati per le rispettive funzionalità dell'applicazione attraverso l'utilizzo di provider per la gestione dello stato. 
# Screens:
  - HomeScreen: Schermata principale che contiene un'app bar, un drawer e una bottom navigation bar per navigare tra le diverse sezioni principali dell'app.
  - TeamListScreen, StandingsListScreen, GamesListScreen: Schermate dedicate rispettivamente alla lista delle squadre, alle due classifiche per conference ed alle partite NBA.
  - TeamDetailsScreen, TeamStatisticsListScreen: Schermate per visualizzare i dettagli di una squadra, come roster, città ecc.  e le statistiche principali di gioco.
# Main:
main.dart: File principale che configura il “MaterialApp” e istanzia i provider necessari per l'intera app. Definisce le rotte e le schermate principali.

## API e Modelli:
nba_api.dart: Contiene le chiamate alle API della NBA utilizzate per ottenere i dati.
nba_team.dart, nba_roster.dart, nba_standings.dart, ecc.: Modelli che rappresentano le entità principali utilizzate nell'app.

## Punti di Forza:
Architettura Modulare:  La struttura modulare dell'applicazione consente una gestione più efficiente delle diverse funzionalità, facilitando la manutenzione e l'aggiunta di nuove features.
Utilizzo di Provider: 	L'utilizzo di provider per la gestione dello stato semplifica la condivisione dei dati tra le diverse parti dell'app senza dover passare manualmente gli oggetti attraverso i widget.
Routing Dinamico:  L'implementazione di rotte dinamiche per le schermate di dettaglio consente di gestire diversi scenari senza la necessità di definire rotte statiche per ogni possibile combinazione di dati.
Utilizzo di Workmanager: 	L'implementazione delle attività in background con Workmanager assicura un aggiornamento automatico delle partite, garantendo informazioni aggiornate.
Gestione Sicura della Chiave API con flutter_dotenv: 	L'uso di flutter_dotenv per la gestione della chiave API migliora la sicurezza e la gestione delle variabili sensibili.
Possibili Migliorie:
Aggiunta di test unitari e di integrazione:  L'introduzione di test unitari e di integrazione contribuirebbe a garantire la stabilità e la correttezza del codice.
Gestione errori più avanzata:  Un miglioramento nella gestione degli errori, inclusa la segnalazione all'utente, potrebbe rendere l'app più robusta e user-friendly.
Aggiunta di altre features:	Considerare aggiunta di altre features all’interno dell’applicazione, come  la possibilità di visualizzare i profili social delle squadre, inserimento di sezione per visualizzare la partita “live”, aggiunta di una sezione sulle ultime notizie relative ad infortuni, prossimi eventi, ecc. ed altre piccole migliorie.
## Conclusioni:
L'applicazione fornisce un' esperienza completa per chi si vuole informare sul mondo NBA, consentendo loro di accedere facilmente a informazioni principali sulle squadre e sulle loro relative prestazioni, permettendo a chiunque di rimanere aggiornato su ciò che succede.
Le scelte architetturali, come l'uso di provider e la struttura modulare, contribuiscono ad un codice organizzato e manutenibile. 
Con le possibili migliorie che abbiamo indicato, l'app potrebbe sicuramente migliorare e quindi  raggiungere livelli ancora più elevati di usabilità e affidabilità.
