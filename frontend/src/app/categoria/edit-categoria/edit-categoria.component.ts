import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Categoria } from 'src/app/model/categoria';
import { CategoriaService } from 'src/app/service/categoria.service';

@Component({
    selector: 'app-edit-categoria',
    templateUrl: './edit-categoria.component.html',
    styleUrls: ['./edit-categoria.component.css']
})
export class EditCategoriaComponent implements OnInit {

    categoria: Categoria;
    textInfo:string = "";

    constructor(private router: Router, private service: CategoriaService) {
        this.categoria = new Categoria();
    }

    ngOnInit(): void {
        this.getCategoria();
        this.eventModal();
    }

    getCategoria() {
        let idC = localStorage.getItem('idCat') ?? '';
        this.service.getCategoriaById(idC)
        .subscribe(data => {
            this.categoria = data;
        });
    }

    onSubmit() {
        this.service.updateUsuario(this.categoria)
        .subscribe(data => {
            this.showInfo('Categoria actualizada correctamente!');
        });
    }

    backList() {
        this.router.navigate(['/categoria/list']);
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
