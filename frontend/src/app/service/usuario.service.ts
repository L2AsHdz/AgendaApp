    import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Rol } from '../model/rol';
import { Solicitud } from '../model/solicitud';
import { Usuario } from '../model/usuario';

@Injectable({
    providedIn: 'root'
})
export class UsuarioService {

    constructor(private http: HttpClient) { }

    url = 'http://localhost:3000/backend/usuario';

    getUsuarios() {
        return this.http.get<Usuario[]>(`${this.url}/list`);
    }

    createUser(user: Usuario) {
        return this.http.post<Usuario>(`${this.url}/add`, user);
    }

    getUsuarioById(username: String) {
        return this.http.get<Usuario>(`${this.url}/get/${username}`);
    }

    updateUsuario(usuario: Usuario) {
        return this.http.put<Usuario>(`${this.url}/update`, usuario);
    }

    delete(username: String) {
        return this.http.delete<Usuario>(`${this.url}/delete/${username}`);
    }

    signIn(usuario: Usuario) {
        return this.http.post<Usuario>(`${this.url}/signIn`, usuario);
    }

    getRols(username: String) {
        return this.http.get<Rol[]>(`${this.url}/roles/${username}`);
    }

    hasRol(rol: String, roles: Rol[]): boolean {
        let flag: boolean = false;

        roles.forEach(r => {
            if (r.tipo == rol) {
                flag = true;
            }
        });

        return flag;
    }
    
    getUserMatch(match : string){
        return this.http.get<string[]>(`${this.url}/match/${match}`);
    }
    
}
