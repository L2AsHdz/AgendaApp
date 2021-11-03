import { Plugin } from "./plugin";
import { Usuario } from "./usuario";

export class Post {
    id: string;
    plugin: Plugin;
    contenido: string;
    fecha: string;
    usuario: Usuario;

    constructor() {
        this.plugin = new Plugin();
        this.usuario = new Usuario();
    }
}
