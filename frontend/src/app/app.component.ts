import { Component, Injector } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { createCustomElement } from '@angular/elements';
import { PopupComponent } from './popup/popup.component';
import { PopupService } from './popup/popup.service';
@Component({
  standalone: true,
  selector: 'app-root',
  template: ``,
  providers: [PopupService],
  imports: [RouterOutlet, PopupComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent {
  title = 'Angular 18 Petclinic';
  constructor(injector: Injector, public popup: PopupService) {
    // Convert `PopupComponent` to a custom element.
    const PopupElement = createCustomElement(PopupComponent, { injector });
    // Register the custom element with the browser.
    customElements.define('popup-element', PopupElement);
  }
}
