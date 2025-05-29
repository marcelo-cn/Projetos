import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';
import { API_URL } from '../constants/variaveis-ambiente';
import { Categoria } from '../model/categoria';

@Injectable({
  providedIn: 'root'
})
export class CategoriaService {

  private readonly API = API_URL + '/categoria';

  constructor(private httpClient: HttpClient) { }

  consultarTodas(): Observable<Categoria[]> {
    return this.httpClient.get<Categoria[]>(`${this.API}/buscar-todas`);
  }

}
