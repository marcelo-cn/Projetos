import { Categoria } from "./categoria";

export class Item {
  id?: number;
  nome?: string;
  quantidade?: number;
  localizacao?: string;
  categoria?: Categoria;
}
