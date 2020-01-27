import 'package:anime_planet/logic/CounterBloc.dart';
import 'package:anime_planet/logic/RateBloc.dart';
import 'package:anime_planet/logic/StatusBloc.dart';
import 'package:anime_planet/logic/anime_tag.dart';
import 'package:anime_planet/logic/anime_type.dart';
import 'package:anime_planet/widgets/table/cells/data_cell_drop_down_status.dart';
import 'package:anime_planet/widgets/table/cells/data_cell_rating_bar.dart';
import 'package:anime_planet/widgets/table/cells/data_cell_title.dart';
import 'package:anime_planet/widgets/table/cells/watching_data_cell_drop_down_episodes.dart';
import 'package:anime_planet/widgets/table/cells/watching_data_cell_episode_counter.dart';
import 'package:flutter/material.dart';

import 'logic/anime_type.dart';

class ModelWatching{
  ModelWatching(
    this.title,
    this.type,
    this.year,
    this.avg,
    this.status,
    this.eps,
    this.epsMax,
    this.rating);

  String title;
  int type;
  String year;
  double avg;
  StatusModel status;
  int eps;
  int epsMax;
  double rating;
  bool showWidget;
}

class WatchingDataSource extends DataTableSource {

  final List<ModelWatching> _watching = <ModelWatching>[
    ModelWatching('One Punch Man', AnimeTypes.TV, '2016', 4.1, StatusBloc.watching, 11, 13, 5.0),
    ModelWatching('High School DXD', AnimeTypes.TV, '2012', 5.0, StatusBloc.watching, 10, 12, 4.9),
  ];


  void _sort<T>(Comparable<T> getField(ModelWatching d), bool ascending) {
    _watching.sort((ModelWatching a, ModelWatching b) {
      if (!ascending) {
        final ModelWatching c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _watching.length)
      return null;
    final ModelWatching watching = _watching[index];

    CountBl _counterBloc = new CountBl(model: CounterModel(watching.eps, watching.epsMax));
    StatusBloc _statusBloc = new StatusBloc();
    RateBloc _rateBloc = new RateBloc(model: RateModel(watching.rating, 5.0));

    _statusBloc.setStatus(watching.status);
    
    var rating = DataCellRatingBar(rateBloc: _rateBloc,);

    var status = DataCellDropDownStatus(bloc: _statusBloc,);
    var cellEpisodeDropDownSelected = WatchingDataCellDropDownEpisodes(counterBloc: _counterBloc,);
    var cellEpisodeButtonCounter = WatchingDataCellEpisodeCounter(counterBloc: _counterBloc);

    var data = "${AnimeTags().getTag(211)}";
    print(data);
var watchingTitle = DataCellTitle(title: watching.title,);

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(watchingTitle),
        DataCell(Text('${watching.type}')),
        DataCell(Text('${watching.year}')),
        DataCell(Text('${watching.avg}')),
        DataCell(status),
        DataCell(cellEpisodeDropDownSelected),
        DataCell(rating),
        DataCell(cellEpisodeButtonCounter),
      ],
    );
  }

  @override
  int get rowCount => _watching.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

}

class WatchingDataTable extends StatefulWidget {
  WatchingDataTable(this.context);
  final BuildContext context;

  @override
  _WatchingDataTableState createState() => _WatchingDataTableState(context);
}

class _WatchingDataTableState extends State<WatchingDataTable> {
  _WatchingDataTableState(this.mContext);
  BuildContext mContext;

  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  final WatchingDataSource _watchingDataSource = WatchingDataSource();

  void _sort<T>(Comparable<T> getField(ModelWatching d), int columnIndex, bool ascending) {
    _watchingDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scrollbar(
        child: ListView(
      //padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        PaginatedDataTable(
          header: const Text('Watching'),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: <DataColumn>[
            DataColumn(
              label: const Text('title'),
              onSort: (int columnIndex, bool ascending) => _sort<String>((ModelWatching d) => d.title, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('type'),
              onSort: (int columnIndex, bool ascending) => _sort<String>((ModelWatching d) => d.type, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('year'),
              onSort: (int columnIndex, bool ascending) => _sort<String>((ModelWatching d) => d.year, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('avg'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<num>((ModelWatching d) => d.avg, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('status'),
              onSort: (int columnIndex, bool ascending) => _sort<String>((ModelWatching d) => d.status.status, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('eps'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<num>((ModelWatching d) => d.eps, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text('rating'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<num>((ModelWatching d) => d.rating, columnIndex, ascending),
            ),
            DataColumn(
              label: const Text(' '),
            ),
          ],
          source: _watchingDataSource,
        ),
      ],
        ),
    );
  }
}