import { Component, Input, OnInit, inject } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { NotifierService } from 'angular-notifier';
import { Item } from '../../model/item';
import { ItemService } from '../../services/item.service';
import { ItemEditComponent } from '../item-edit/item-edit.component';

@Component({
  selector: 'app-item-list',
  templateUrl: './item-list.component.html',
  styleUrl: './item-list.component.scss'
})

export class ItensListComponent implements OnInit{
  
  @Input() public itens: Item[] = [];
  readonly displayedColumns: string[] = ['id', 'nome', 'quantidade', 'acoes'];
  readonly dialog = inject(MatDialog);
  
  private readonly notifier: NotifierService;

  constructor(private itemService: ItemService, private notifierService: NotifierService) {
    this.notifier = notifierService;
  }

  ngOnInit(): void {
    this.pesquisar();
  }

  private pesquisar() {
    this.itemService.consultarTodos().subscribe((res) => {
      this.itens = res;
    });
  }

  onAdd() {
    const dialogRef = this.dialog.open(ItemEditComponent, {
      width: '800px',
      data: {},
    });

    dialogRef.afterClosed().subscribe(result => {
      this.pesquisar();
    });
  }

  onEdit(item: Item) {
    const dialogRef = this.dialog.open(ItemEditComponent, {
      width: '800px',
      data: {item: item},
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result !== undefined) {
        this.pesquisar();
      }
    });
  }

  onDelete(item: Item) {
    if(item.id != undefined && confirm("Tem certeza que deseja excluir esse item?")) {
      this.itemService.excluirItem(item.id).subscribe((res) => {
        this.notifier.notify('success', 'Item excluído com sucesso');
        this.pesquisar();
      });
    }
  }
}
