// Generated by CoffeeScript 1.8.0
var db, restTable;

db = require('./db');

db.init();

restTable = db.getRestTable();

restTable.sync({
  force: true
}).then(function() {
  var item, rec, _i, _len, _results;
  rec = [
    {
      id: 1,
      text: 'Wake up and attend keynote',
      priority: 8
    }, {
      id: 2,
      text: 'Attend private party, collect biz cards',
      priority: 10
    }, {
      id: 3,
      text: 'Learn about enterprise ExtJS development',
      priority: 6
    }
  ];
  _results = [];
  for (_i = 0, _len = rec.length; _i < _len; _i++) {
    item = rec[_i];
    _results.push(restTable.create(item));
  }
  return _results;
}).then(function() {
  console.log('done');
});
