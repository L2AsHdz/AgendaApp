import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Categoria } from 'src/app/model/categoria';
import { Usuario } from 'src/app/model/usuario';
import { CategoriaService } from 'src/app/service/categoria.service';

@Component({
    selector: 'app-add-categoria',
    templateUrl: './add-categoria.component.html',
    styleUrls: ['./add-categoria.component.css']
})
export class AddCategoriaComponent implements OnInit {

    categoria: Categoria;
    textInfo:string = "";

    constructor(private router: Router, private service: CategoriaService) {
        this.categoria = new Categoria();
    }

    ngOnInit(): void {
        this.eventModal();
    }

    onSubmit() {
        this.categoria.usuario.username = localStorage.getItem('user') ?? '';
        this.service.createCategoria(this.categoria)
        .subscribe(data => {
            this.showInfo('Categoria agregada con exito');
        });
    }

    private eventModal(){
        document.getElementById('modalInfo')?.addEventListener('hidden.bs.modal', ()=> {
            this.backList();
        });
    }

    backList() {
        this.router.navigate(['/categoria/list']);
    }

    private showInfo(info:string){
        this.textInfo = info;
        document.getElementById("btnModalInfo")?.click();
    }

}
