import { Component, Inject, OnInit } from '@angular/core';
import { Item } from '../../model/item';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { NotifierService } from 'angular-notifier';
import { ItemService } from '../../services/item.service';
import { CategoriaService } from '../../services/categoria.service';
import { Categoria } from '../../model/categoria';

@Component({
  selector: 'app-item-edit',
  templateUrl: './item-edit.component.html',
  styleUrl: './item-edit.component.scss'
})
export class ItemEditComponent implements OnInit {

  categorias: Categoria[] = [];
  formGroup!: FormGroup;
  private readonly notifier: NotifierService;

  constructor(public dialogRef: MatDialogRef<ItemEditComponent>, @Inject(MAT_DIALOG_DATA) public data: any, private fb: FormBuilder,
    private itemService: ItemService, private notifierService: NotifierService, private categoriaService: CategoriaService) {
    this.notifier = notifierService;
  }

  ngOnInit(): void {
    this.formGroup = this.fb.group({
      id: [{ value: null, disabled: true }, Validators.required],
      nome: ['', Validators.required],
      quantidade: [0],
      localizacao: [null],
      categoria: [null, Validators.required]
    });

    this.formGroup.patchValue(this.data.item);
    this.buscarTodasCategorias();
  }

  private buscarTodasCategorias() {
    this.categoriaService.consultarTodas().subscribe((res) => {
      this.categorias = res;
    });
  }

  public close(): void {
    this.dialogRef.close(false);
  }

  public salvar(): void {
    this.formGroup.markAllAsTouched();
    if (this.formGroup.valid) {
      let item = new Item();
      let categoria = new Categoria()
      item.id = this.formGroup.get('id')?.value;
      item.nome = this.formGroup.get('nome')?.value;
      item.quantidade = this.formGroup.get('quantidade')?.value;
      item.localizacao = this.formGroup.get('localizacao')?.value;
      categoria = this.formGroup.get('categoria')?.value;
      item.categoria = categoria;

      this.itemService.salvarItem(item).subscribe((res) => {
        if (res) {
          this.dialogRef.close(true);
          this.notifier.notify('success', 'Item cadastrado com sucesso');
        }
        else
          this.notifier.notify('error', 'Um erro ocorreu, por favor tente novamente mais tarde');
      });
    }
  }

  get formControlNome() {
    return this.formGroup.get('nome');
  }

  get formControlCategoria() {
    return this.formGroup.get('categoria');
  }
}
