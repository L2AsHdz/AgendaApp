import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Usuario } from 'src/app/model/usuario';
import { UsuarioService } from 'src/app/service/usuario.service';

@Component({
    selector: 'app-login',
    templateUrl: './login.component.html',
    styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

    usuario: Usuario;

    constructor(private router: Router, private service: UsuarioService) {
        this.usuario = new Usuario();
    }

    ngOnInit(): void {
    }

    registrar(): void {
        this.router.navigate(['/addUser']);
    }

    onSubmit(): void {
        this.service.signIn(this.usuario)
        .subscribe(user => {
            if (user) {
                sessionStorage.setItem('user', user.username.toString());
                this.router.navigate(['listCategoria']);
            } else {
                alert('Credenciales incorrectas!');
            }
        });
    }

}
