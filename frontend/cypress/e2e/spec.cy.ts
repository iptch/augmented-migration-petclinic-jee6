describe('template spec', () => {
  it('passes', () => {
    cy.visit('https://example.cypress.io')
  })

  /* ==== Test Created with Cypress Studio ==== */
  it('Add new speciality', function() {
    /* ==== Generated with Cypress Studio ==== */
    cy.visit('http://localhost:8080/jee6-petclinic-1.0-SNAPSHOT');
    cy.get(':nth-child(4) > a').click();
    cy.get('#specialtiesForm\\:addNewSpecialty').click();
    cy.get('#addNewSpecialtyForm\\:name').clear('dentist');
    cy.get('#addNewSpecialtyForm\\:name').type('dentist');
    cy.get('#addNewSpecialtyForm\\:save').click();
    /* ==== End Cypress Studio ==== */
  });

  /* ==== Test Created with Cypress Studio ==== */
  it('Add new pet type', function() {
    /* ==== Generated with Cypress Studio ==== */
    cy.visit('http://localhost:8080/jee6-petclinic-1.0-SNAPSHOT/');
    cy.get(':nth-child(5) > a').click();
    cy.get('#petTypesForm\\:getNewPetTypeForm').click();
    cy.get('#addNewPetTypeForm\\:name').clear('cat');
    cy.get('#addNewPetTypeForm\\:name').type('cat');
    cy.get('#addNewPetTypeForm\\:save').click();
    /* ==== End Cypress Studio ==== */
  });

  /* ==== Test Created with Cypress Studio ==== */
  it('Add veterinarian', function() {
    /* ==== Generated with Cypress Studio ==== */
    cy.visit('http://localhost:8080/jee6-petclinic-1.0-SNAPSHOT/');
    cy.get('.nav > :nth-child(3) > a').click();
    cy.get('#veterinariansForm\\:getNewVetForm').click();
    cy.get('#addNewVeterinarianForm\\:j_idt13SourceList > :nth-child(1)').click();
    cy.get('#addNewVeterinarianForm\\:firstName').clear('Peter');
    cy.get('#addNewVeterinarianForm\\:firstName').type('Peter');
    cy.get('#addNewVeterinarianForm\\:lastName').clear('Pan');
    cy.get('#addNewVeterinarianForm\\:lastName').type('Pan');
    cy.get('.btn-add > .fa').click();
    cy.get('#addNewVeterinarianForm\\:save').click();
    /* ==== End Cypress Studio ==== */
  });
})