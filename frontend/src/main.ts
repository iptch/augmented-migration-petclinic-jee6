import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
import { createCustomElement } from '@angular/elements';
import { DemoComponent } from './app/demo/demo.component';

bootstrapApplication(AppComponent, appConfig)
  .then((ref) => {
    const injector = ref.injector;

    const elements: any[] = [[DemoComponent, 'demo-element']];
    for (const [component, name] of elements) {
      const el = createCustomElement(component, { injector });
      customElements.define(name, el);
    }
  })
  .catch((err) => console.error(err));
