<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>jQuery tablesort.js examples</title>

	<style type="text/css">
	body {
	font: normal 14px/21px dotum, serif;
    background-color:#F5F7FA;
	}
	.example {
		float: left;
		width: 40%;
		margin: 5%;
	}
	table {
		font-size: 1em;
		border-collapse: collapse;
		margin: 0 auto
	}
	table, th, td {
		border: 1px solid #999;
		padding: 8px 16px;
		text-align: left;
	}
	th {
		background: #f4f4f4;
		cursor: pointer;
	}

	th:hover,
	th.sorted {
		background: #d4d4d4;
	}

	th.no-sort,
	th.no-sort:hover {
		background: #f4f4f4;
		cursor: not-allowed;
	}

	th.sorted.ascending:after {
		content: "  \2191";
	}

	th.sorted.descending:after {
		content: " \2193";
	}
	</style>
</head>
<body>



<div class="example ex-1">
	<table>
		<thead>
			<tr>
				<th>Name</th>
				<th>Band</th>
				<th>Date of Birth</th>
				<th class="number">Age</th>
				<th class="no-sort">Photo</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>블루비</td>
				<td>Radiohead</td>
				<td data-sort-value="2">October 7, 1968</td>
				<td>43</td>
				<td><img src="http://www.blueb.co.kr/SRC2/_image/s_01.jpg" width="50"></td>
			</tr>
			<tr>
				<td>네이버</td>
				<td>Bon Iver</td>
				<td data-sort-value="4">April 30, 1981</td>
				<td>30</td>
				<th><img src="http://www.blueb.co.kr/SRC2/_image/s_02.jpg" width="50"></td>
			</tr>
			<tr>
				<td>다음</td>
				<td>The Beatles</td>
				<td data-sort-value="1">June 18, 1942</td>
				<td>69</td>
				<td><img src="http://www.blueb.co.kr/SRC2/_image/s_03.jpg" width="50"></td>
			</tr>
			<tr>
				<td>네이트</td>
				<td>Iron & Wine</td>
				<td data-sort-value="3">July 26, 1974</td>
				<td>37</td>
				<td><img src="http://www.blueb.co.kr/SRC2/_image/s_04.jpg" width="50"></td>
			</tr>
		</tbody>
	</table>
</div>

<div class="example ex-2"></div>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function() {

	var $ = window.Zepto || window.jQuery;

	$.tablesort = function ($table, settings) {
		var self = this;
		this.$table = $table;
		this.$thead = this.$table.find('thead');
		this.settings = $.extend({}, $.tablesort.defaults, settings);
		this.$table.find('th:not(.no-sort)').bind('click.tablesort', function() {
			self.sort($(this));
		});
		this.index = null;
		this.$th = null;
		this.direction = null;
	};

	$.tablesort.prototype = {

		sort: function(th, direction) {
			var start = new Date(),
				self = this,
				table = this.$table,
				body = table.find('tbody').length > 0 ? table.find('tbody') : table,
				rows = this.$thead.length > 0 ? table.find('tbody tr') : table.find('tr').has('td'),
				cells = table.find('tr td:nth-of-type(' + (th.index() + 1) + ')'),
				sortBy = th.data().sortBy,
				sortedMap = [];

			var unsortedValues = cells.map(function(idx, cell) {
				if (sortBy)
					return (typeof sortBy === 'function') ? sortBy($(th), $(cell), self) : sortBy;
				return ($(this).data().sortValue != null ? $(this).data().sortValue : $(this).text());
			});
			if (unsortedValues.length === 0) return;

			self.$table.find('th').removeClass(self.settings.asc + ' ' + self.settings.desc);

			if (direction !== 'asc' && direction !== 'desc')
				this.direction = this.direction === 'asc' ? 'desc' : 'asc';
			else
				this.direction = direction;

			direction = this.direction == 'asc' ? 1 : -1;

			self.$table.trigger('tablesort:start', [self]);
			self.log("Sorting by " + this.index + ' ' + this.direction);

			for (var i = 0, length = unsortedValues.length; i < length; i++)
			{
				sortedMap.push({
					index: i,
					cell: cells[i],
					row: rows[i],
					value: unsortedValues[i]
				});
			}

			sortedMap.sort(function(a, b) {
				if (a.value > b.value) {
					return 1 * direction;
				} else if (a.value < b.value) {
					return -1 * direction;
				} else {
					return 0;
				}
			});

			$.each(sortedMap, function(i, entry) {
				body.append(entry.row);
			});

			th.addClass(self.settings[self.direction]);

			self.log('Sort finished in ' + ((new Date()).getTime() - start.getTime()) + 'ms');
			self.$table.trigger('tablesort:complete', [self]);
		},

		log: function(msg) {
			if(($.tablesort.DEBUG || this.settings.debug) && console && console.log) {
				console.log('[tablesort] ' + msg);
			}
		},

		destroy: function() {
			this.$table.find('th').unbind('click.tablesort');
			this.$table.data('tablesort', null);
			return null;
		}

	};

	$.tablesort.DEBUG = false;

	$.tablesort.defaults = {
		debug: $.tablesort.DEBUG,
		asc: 'sorted ascending',
		desc: 'sorted descending'
	};

	$.fn.tablesort = function(settings) {
		var table, sortable, previous;
		return this.each(function() {
			table = $(this);
			previous = table.data('tablesort');
			if(previous) {
				previous.destroy();
			}
			table.data('tablesort', new $.tablesort(table, settings));
		});
	};

});

</script>
<script type="text/javascript">
	$(function() {
		$('table').tablesort().data('tablesort');
	});
</script>
</body>

</html>