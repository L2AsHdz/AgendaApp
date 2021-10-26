import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import flatpickr from 'flatpickr';
import { Spanish } from 'flatpickr/dist/l10n/es';
import { Usuario } from 'src/app/model/usuario';
import { UsuarioService } from 'src/app/service/usuario.service';
@Component({
    selector: 'app-add-usuario',
    templateUrl: './add-usuario.component.html',
    styleUrls: ['./add-usuario.component.css']
})
export class AddUsuarioComponent implements OnInit {

    usuario: Usuario;
    textInfo:string = "";

    constructor(private router:Router, private service: UsuarioService) {
        this.usuario = new Usuario();
    }

    ngOnInit(): void {
        flatpickr('#fecha', {
            locale: Spanish
        });
    }

    onSubmit() {
        this.service.createUser(this.usuario)
        .subscribe(data => {
            this.showInfo('Agregado con exito');
            localStorage.setItem('user', this.usuario.username.toString());
            this.router.navigate(['/calendar-dia']);
        });
    }

    private showInfo(info:string){
        this.textInfo = info;
        document.getElementById("btnModalInfo")?.click();
    }

}
