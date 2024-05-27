package org.woehlke.jee6.petclinic.dao;

import org.woehlke.jee6.petclinic.entities.Pet;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.logging.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: tw
 * Date: 06.01.14
 * Time: 20:34
 * To change this template use File | Settings | File Templates.
 */
@Stateless
public class PetDaoImpl implements PetDao {

    private static Logger log = Logger.getLogger(PetDaoImpl.class.getName());

    @PersistenceContext(unitName="jee6petclinic")
    private EntityManager entityManager;


    @Override
    public void addNew(Pet pet) {
        log.info("addNewPet: "+pet.toString());
        entityManager.persist(pet);
    }

    @Override
    public Pet findById(long petId) {
        return entityManager.find(Pet.class, petId);
    }

    @Override
    public void update(Pet pet) {
        log.info("updatePet: "+pet.toString());
        entityManager.merge(pet);
    }
}
