# Webcomponents

Um ein Angular-Projekt zu erstellen, das mehrere Komponenten als Webkomponenten bereitstellt, kannst du die folgenden Schritte befolgen:

1.  **Neues Angular-Projekt erstellen**:

    ```
    ng new angular
    ```

2.  **Angular Elements hinzufügen**: Installiere das `@angular/elements` und `@webcomponents/custom-elements` Paket:

Gehe dazu in die Angular App

```
cd angular
```

Und füge die Depdency dazu

```
ng add @angular/elements
npm install @webcomponents/custom-elements
```

3. Damit es ohne Hash gebuilded wird und der Name immer gleich ist werden sollen die Dateien ohne hash erstellt werden

Das aus main-FZS25YQ5.js main.js wird dies wird es das Einbinden vereinfachen.
Dazu öffne die angular.json und ändere die Datei so dass in dem JSON outputingHash none ist. Beachte dass bei production du das all überschreiben musst.

```
"projects": {
  "my-webcomponents-app": {
    "architect": {
      "build": {
        "options": {
          "outputHashing": "none",
          ...
        },
        "configurations": {
          "production": {
            "outputHashing": "none",
            ...
          }
        }
      }
    }
  }
}



```

Teste es mit einem ng build und kontrolliere ob die hashes weg sind:

```
ng build
Initial chunk files | Names         |  Raw size | Estimated transfer size
main.js             | main          | 194.83 kB |                53.14 kB
polyfills.js        | polyfills     |  33.33 kB |                10.81 kB
scripts.js          | scripts       |  19.04 kB |                 5.12 kB
styles.css          | styles        |   0 bytes |                 0 bytes
```

4.  **Komponenten erstellen**: Erstelle eine neue Standalone-Komponente:

    `ng generate component my-element`
