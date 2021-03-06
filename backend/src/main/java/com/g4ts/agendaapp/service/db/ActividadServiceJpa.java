package com.g4ts.agendaapp.service.db;

import com.g4ts.agendaapp.model.Actividad;
import com.g4ts.agendaapp.model.Proyecto;
import com.g4ts.agendaapp.model.Usuario;
import com.g4ts.agendaapp.repository.ActividadRepository;
import com.g4ts.agendaapp.service.IActividadService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ActividadServiceJpa implements IActividadService {

    private ActividadRepository actividadRepository;

    public ActividadServiceJpa(ActividadRepository actividadRepository) {
        this.actividadRepository = actividadRepository;
    }

    @Override
    public List<Actividad> findAll() {
        return actividadRepository.findAll();
    }

    @Override
    public Actividad findById(Integer id) {
        Optional<Actividad> optionalActividad = actividadRepository.findById(id);
        if (optionalActividad.isPresent()) return optionalActividad.get();
        return null;
    }

    @Override
    public void save(Actividad actividad) {
        actividadRepository.save(actividad);
    }

    @Override
    public void deleteById(Integer id) {
        actividadRepository.deleteById(id);
    }

    @Override
    public List<Actividad> findAllByProyecto(Proyecto proyecto) {
        return actividadRepository.findAllByProyecto(proyecto);
    }

    @Override
    public List<Actividad> findAllByUsuario(Usuario usuario) {
        return actividadRepository.findAllByUsuario(usuario);
    }
}
