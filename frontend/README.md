# Frontend

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 18.0.2.

```bash
sudo npm install -g @angular/cli
ng new frontend
cd frontend
ng add @anfular/elements
npm install @webcomponents/custom-elements
```

Change `angular.json`

```json
    "build": {
        "options": {
            "outputHashing": "none",
            "outputPath": "../petclinic-jee6/src/main/webapp",
            ...
        }
    }
```

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `../petclinic-jee6/src/main/webapp/dist` directory.

## Running end-to-end tests

Run `npm run e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Generate Open API

Install the cli

```bash
npm install @openapitools/openapi-generator-cli -g
```

Generate files

```
openapi-generator-cli generate -i petclinic-openapi.yaml -g typescript-angular -o src/app/api
```
