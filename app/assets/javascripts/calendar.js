  $(function() {
    $( ".datepicker" ).datepicker({
      altFormat: "dd.mm.yyyy",
      changeMonth: true,
      changeYear: true,
      showOn: "button",
      buttonImage: "/assets/calendar.gif",
      buttonImageOnly: true,
      buttonText: "Календарь",
      dateFormat: "dd.mm.yyyy",
      monthNames: [ "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь" ],
	  dayNamesMin: [ "Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб" ],
	  monthNamesShort: [ "Янв", "Фев", "Мар", "Апр", "Май", "Июн", "Июл", "Авг", "Сен", "Окт", "Ноя", "Дек" ],
	  showButtonPanel: false,
	  firstDay: 1,
	  // minDate: "-75Y", maxDate: "-15Y",
	  showMonthAfterYear: false,
	  // yearRange: '-75Y:-15Y',
    });
  });
