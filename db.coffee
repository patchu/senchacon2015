# db.coffee

Sequelize = require("sequelize")

restTable = null

init = ->
	dbSql = new Sequelize 'database', 'username', 'password',
		dialect: 'sqlite'
		storage: "./rest.sqlite"
		# storage: ':memory:'
		logging: false

	restTable = dbSql.define 'Rest',
		id:
			type: Sequelize.INTEGER
			primaryKey: true
		text: Sequelize.STRING(200)
		priority: Sequelize.INTEGER

getRestTable = ->
	return restTable


sendObjResponse = (rows, callback) ->
	ar = []
	for row in rows
		ar.push row.dataValues
	retobj =
		success: true
		total: ar.length
		data: ar
	if callback
		callback(retobj)
	return


list = (callback) ->
	restTable.findAll
		order: 'id'
	.then (rows) ->
		sendObjResponse rows, callback
		return
	return

get = (recid, callback) ->
	restTable.findAll
		where:
			id: recid
	.then (rows) ->
		sendObjResponse rows, callback
		return
	return

insert = (insertObj, callback) ->
	restTable.max 'id'
	.then (retval) ->
		nextid = retval + 1
		insertObj.id = nextid

		restTable.create insertObj
		.complete (err, results) ->
			retobj =
				success: true
			if err
				retobj.success = false
				console.log 'error: ', err
			callback retobj
			return
		return
	return


update = (updateObj, callback) ->
	restTable.update updateObj,
		where:
			id: updateObj.id
	.then ->
		# always returns true
		retobj =
			success: true
		callback retobj
		return
	return


destroy = (recid, callback) ->
	restTable.destroy
		where:
			id: recid
	.then ->
		retobj =
			success: true
		# return true no matter what
		callback retobj
		return
	return

exports.init = init
exports.list = list
exports.get = get
exports.destroy = destroy
exports.insert = insert
exports.update = update
exports.getRestTable = getRestTable
