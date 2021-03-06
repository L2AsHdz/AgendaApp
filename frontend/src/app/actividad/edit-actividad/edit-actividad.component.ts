import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import flatpickr from 'flatpickr';
import { Spanish } from 'flatpickr/dist/l10n/es';
import rangePlugin from 'flatpickr/dist/plugins/rangePlugin';
import { Actividad } from 'src/app/model/actividad';
import { Categoria } from 'src/app/model/categoria';
import { Proyecto } from 'src/app/model/proyecto';
import { ActividadService } from 'src/app/service/actividad.service';
import { CategoriaService } from 'src/app/service/categoria.service';
import { ProyectoService } from 'src/app/service/proyecto.service';

@Component({
    selector: 'app-edit-actividad',
    templateUrl: './edit-actividad.component.html',
    styleUrls: ['./edit-actividad.component.css']
})
export class EditActividadComponent implements OnInit {

    actividad: Actividad;
    categorias: Categoria[];
    textInfo:string = "";

    constructor(private router: Router,
        private actividadService: ActividadService,
        private categoriaService: CategoriaService,
        private proyectoService: ProyectoService) {

        this.actividad = new Actividad();
        this.categorias = new Array();
    }

    ngOnInit(): void {
        let user: String = localStorage.getItem('user') ?? '';
        this.categoriaService.getCategorias(user)
            .subscribe(data => {
                this.categorias = data;
            });

        this.getActividad();
        this.setFlatPickr();

        this.eventModal();
    }

    private getActividad() {
        let idAct: String = localStorage.getItem('idActividad') ?? '';
        this.actividadService.getById(idAct)
            .subscribe(data => {
                this.actividad = data;
            });
    }

    private setFlatPickr() {
        flatpickr('#fechaInicio', {
            plugins: [rangePlugin({ input: "#fechaFin" })],
            locale: Spanish
        });
    }

    onSubmit() {
        let fechaFin: HTMLInputElement = document.querySelector('#fechaFin') ?? new HTMLInputElement();
        this.actividad.fechaFin = fechaFin.value;
        this.actividadService.update(this.actividad)
            .subscribe(data => {
                this.showInfo('Actividad actualizada correctamente');
            });
    }

    backList() {
        this.router.navigate(['/actividad/list']);
    }

    private showInfo(info:string){
        this.textInfo = info;
        document.getElementById("btnModalInfo")?.click();
    }

    private eventModal(){
        document.getElementById('modalInfo')?.addEventListener('hidden.bs.modal', ()=> {
            this.backList();
        });
    }
}
