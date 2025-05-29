import { Routes } from '@angular/router';
import { ItensListComponent } from './almoxarifado/componentes/item-list/item-list.component';
import { HomeComponent } from './almoxarifado/componentes/home/home.component';

export const APP_ROUTES: Routes = [
 

  { path: '', component: HomeComponent },
  { path: 'itens', component: ItensListComponent },
];
