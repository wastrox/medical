  $(function() {
    $( ".datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: "dd.mm.yy",
	  dayNamesMin: [ "Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс" ],
	  monthNamesShort: [ "Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Aug", "Sep", "Okt", "Nov", "Dec" ],
	  showButtonPanel: false,
	  firstDay: 1,
	  minDate: "-75Y", maxDate: "-15Y",
	  showMonthAfterYear: false,
	  yearRange: '-75Y:-15Y',
    });
  });
