import { Component } from '@angular/core';

@Component({
  selector: 'app-my-element',
  standalone: true,
  imports: [],
  templateUrl: './my-element.component.html',
  styleUrl: './my-element.component.css',
})
export class MyElementComponent {
  msg = {
    welcome: 'Welcome to Webcomponents',
    firstSteps: 'First Steps:',
    myElement: 'my-element works! It really works!',
    petTypes: 'add some Pet Types like dog, cat, mouse, ...',
    specialties:
      'add some Specialties for Veterinarians like dentist, anesthetist, radiology, ...',
    veterinarian: 'add a Veterinarian',
    owner: 'add an Owner, add him a Pet and his Pet a visit.',
    sourceCode: 'Source Code:',
    github: 'Github: https://github.com/phasenraum2010/jee6-petclinic',
    projectPage: 'Project Page: http://www.thomas-woehlke.de/p/jee6-petclinic/',
    bugs: 'Bugs: https://github.com/phasenraum2010/jee6-petclinic/issues',
  };
}
