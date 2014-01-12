var bad_rules = [];
var good_rules = [];




function filter_list(list) {
	var filtered = $(list).not("script").not("[style*='display: none']");
	return filtered;
}

function get_selection() {
	var sel = window.getSelection();
	var container = sel.getRangeAt(0).commonAncestorContainer;
	return container;
}

function remove_everything() {
	var everything = $('body').children().not("div[id*='fuckespn']");
	var everything_filtered = filter_list(everything);
	var remove = new ElementsRemover(everything_filtered);
	remove.remove();
};

function selectify() {
	return remove(get_selection());
};

function body_finder() {
	return select(get_selection());
};

function remove(element) {
	var remover = new SelectionRemover(element);
	remover.remove();
	return remover;
}

function select(element) {
	var selector = new BodySelector(element);
	selector.select();
	return selector;
}

function remove_finely(elements) {
	var fine_remover = new ElementsRemover(elements);
	fine_remover.remove_elements();
	return fine_remover;
}


function Buttons () { 
	this.buttons = {
		yes: document.getElementById("yesbutton"),
		no: document.getElementById("nobutton"),
		too_much: document.getElementById("toomuch"),
		too_little: document.getElementById("toolittle"),
		popUp: document.getElementById("popUpDialog"),
		backtrack: document.getElementById("bcktrk"),
	};

	this.args = arguments;
	that = this;

  var get_buttons = function () { 
		used_butts = [];
		for (i = 0; i < that.args.length; i++) {
			used_butts.push(that.buttons[that.args[i]]);
		};
		return used_butts;
	};

	this.used_buttons = get_buttons();

	this.hide_buttons = function () { 
		$(that.used_buttons).hide(); 
	 }

	this.show_buttons = function () { 
		$(that.used_buttons).show(); 
	}

};

function ElementsRemover(elements) {
	this.elements = filter_list(elements);
	this.not_removed = [];
	this.bad_rules = [];
	var that = this;
	this.buttons = new Buttons('popUp', 'yes', 'no');

	var counter = 0;

	this.remove_elements = function() {
		if (counter < that.elements.length) {
			element = that.elements[counter];
			counter += 1;
			remove_element(element);
		}

		else {
			that.log_results();

		};
	};

	remove_element = function(element) {
		that.buttons.show_buttons();

		$(element).hide();

		that.buttons.buttons.yes.onclick = function () {
			that.bad_rules.push(element);
			that.buttons.hide_buttons();
			that.remove_elements();
		};

		that.buttons.buttons.no.onclick = function () { 
			$(element).show();
			that.not_removed.push(element);
			that.buttons.hide_buttons()
			that.remove_elements();
		};
	};

	this.log_results = function() {
		for (i = 0; i < that.bad_rules.length; i++) {
			bad_rules.push(that.bad_rules[i]);
		};
	};

	this.make_next_round_step_down = function () { 
		next_round = [];
		
		for (i = 0; i < this.not_removed.length; i++) {
			children = $.makeArray(this.not_removed[i].children);

			if (children.length > 0) {
				next_round = next_round.concat(children);
			};
		};

		next_round = filter_list(next_round);
	
		if (next_round.length > 0) { that.next_round = next_round; };
	};

	this.make_next_round_step_up = function () {
		next_round = [];

		for (i = 0; i < this.not_removed.length; i++) {
			parent = this.not_removed[i].parentNode;
			if (!$.inArray(parent, next_round)) {
				next_round.push(parent);
			};
		};

		next_round = filter_list(next_round);

		if (next_round.length > 0) { that.next_round_up = next_round; };
	}
}

function SelectionRemover(selection) {
	this.selection = selection;
	this.current_element = this.selection;
	this.buttons = new Buttons('popUp', 'yes', 'too_much', 'too_little');
	var that = this;
	backtrack = [];

	this.remove = function() {
		$(that.current_element).hide();
		show_buttons();
		that.buttons.buttons.yes.onclick = function () { hide_buttons(); yes(); };
		that.buttons.buttons.too_much.onclick = function () { hide_buttons(); too_much(); };
		that.buttons.buttons.too_little.onclick = function () { hide_buttons(); too_little(); };
	};

	var yes = function () { 
		that.log();
	};

	var too_much = function () {
		$(that.current_element).show();
		go_back();
	};

	var too_little = function () {
		backtrack.push(that.current_element);
		that.current_element = $(that.current_element).parent()[0];
		that.remove();
	}

	var go_back = function () { 
		if (backtrack.length > 0) {
			back = backtrack.pop();
			$(back).show();
			that.current_element = back;
			that.remove();
		};
	};

	this.log = function () { 
		bad_rules.push(that.current_element);
	};

	var show_buttons = function () {
		that.buttons.show_buttons();
	}

	var hide_buttons = function () {
		that.buttons.hide_buttons();
	}

};



function BodySelector(selection) {
	this.selection = selection;
	this.current_element = this.selection
	this.buttons = new Buttons('popUp', 'yes', 'too_much', 'too_little');

	var siblings = [];
	var backtrack = [];
	var that = this;

	this.select = function () {
		show_buttons();
	  siblings = get_siblings(that.current_element);
		$(siblings).hide();
	
		that.buttons.buttons.yes.onclick = function () { hide_buttons(); yes(); };

		that.buttons.buttons.too_much.onclick = function () { hide_buttons(); too_much; };

		that.buttons.buttons.too_little.onclick = function () { hide_buttons(); too_little; };
	}

	var yes = function ()  {
		log(that.current_element);
	}

	var too_much = function () { 
		$(siblings).show();

		if (backtrack.length > 0) {
			that.current_element = backtrack.pop();
			that.select();
		};
	}

	var too_little = function () { 
		$(siblings).show();
		backtrack.push(that.current_element);

		var parent = $(that.current_element).parent()[0];
		
		if (parent.tagName.toLowerCase() != "body") {
			that.current_element = parent;
			that.select();
		};
	}

	var get_siblings = function(element) {
		var siblings = $(element).siblings().not("div[id*='fuckespn']");
	  return filter_list(siblings);
	}

	var log = function() {
		good_rules.push(that.current_element);
	};

	var show_buttons = function () {
		that.buttons.show_buttons();
	}

	var hide_buttons = function () {
		that.buttons.hide_buttons();
	}

};




function Tag(tag) {
	this.name = tag.tagName;
	this.attributes = [];
	for (i = 0; i < tag.attributes.length; i++) {
		name = tag.attributes[i].name;
		attribute = {
			name: tag.attributes[i].name,
			values: tag.attributes[i].value,
		}
		this.attributes.push(attribute)
	};
};

function tag(list) {
	Tag_list = []

	for (entry in list) {
		Tag_list.push(new Tag(list[entry]));
	};

	return Tag_list;
}

function save_info() { 
	
	var data = {};

	if (bad_rules.length > 0) {
		data.bad = tag(bad_rules);
	};

	if (good_rules.length > 0) {
		data.good = tag(good_rules);
	};

	if (bad_rules.length != 0 || good_rules.length != 0) {
		send_info(data);
	};

};

/*
var taggert = new Taggert(container, $(container).parent()[0]);

function Taggert(tag, parent) {
	this.tag = new Tag(tag);
	this.parent = new Tag(parent);
};
*/