# dbtest.coffee

db = require('./db')
db.init()

restTable = db.getRestTable()

restTable.sync({force: true})
.then ->
	rec = [
		id: 1
		text: 'Wake up and attend keynote'
		priority: 8
	,
		id: 2
		text: 'Attend private party, collect biz cards'
		priority: 10
	,
		id: 3
		text: 'Learn about enterprise ExtJS development'
		priority: 6
	]
	for item in rec
		restTable.create item
.then ->
	console.log 'done'
	return
