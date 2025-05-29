import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';
import { API_URL } from '../constants/variaveis-ambiente';
import { Item } from '../model/item';

@Injectable({
  providedIn: 'root'
})
export class ItemService {

  private readonly API = API_URL + '/item';

  constructor(private httpClient: HttpClient) { }

  consultarTodos(): Observable<Item[]> {
    return this.httpClient.get<Item[]>(`${this.API}/buscar-todos`);
  }

  salvarItem(item: Item): Observable<boolean> {
    return this.httpClient.post<boolean>(`${this.API}/salvar-item`, item);
  }

  excluirItem(id: number): Observable<boolean> {
    return this.httpClient.delete<boolean>(`${this.API}/excluir-item/${id}`);
  }

}
