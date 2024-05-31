import { bootstrapApplication } from '@angular/platform-browser';
import { createCustomElement } from '@angular/elements';
import { AppComponent } from './app/app.component';
import { MyElementComponent } from './app/my-element/my-element.component';
import { importProvidersFrom } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

bootstrapApplication(AppComponent, {
  providers: [importProvidersFrom(BrowserModule)],
})
  .then((ref) => {
    const injector = ref.injector;
    const myElement = createCustomElement(MyElementComponent, { injector });
    customElements.define('my-element', myElement);
  })
  .catch((err) => console.error(err));
