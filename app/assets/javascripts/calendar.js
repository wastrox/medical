  $(function() {
    $( ".datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: "dd.mm.yy",
	  dayNamesMin: [ "Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб" ],
	  monthNamesShort: [ "Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек" ],
	  showButtonPanel: false,
	  firstDay: 1,
	  minDate: "-75Y", maxDate: "-15Y",
	  showMonthAfterYear: false,
	  yearRange: '-75Y:-15Y',
    });
  });
