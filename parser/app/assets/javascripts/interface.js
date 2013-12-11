/*function get_highlight_info() {
	window.alert('fuck you');
	window.confirm('fuck you?');
	var sel = window.getSelection();
	var container = sel.getRangeAt(0).commonAncestorContainer;
	var parent_node = container.parentNode;
	var tag_obj = { 
		name: container.tagName,
		attributes: get_attributes(container.attributes),
			};
	alert(tag_obj.name);
	alert(tag_obj.attributes);
};

function get_attributes(attributes)
	var attr_arr = {};

	for (i=0; i<attributes.length; i++) {
		attr_arr[attributes[i].nodeName] = attributes[i].value;
	};

	return attr_arr;
};


function Tag(node) {
	var tag = 
	return tag;
};*/ 
/*
function selectify() {
	var sel = window.getSelection();
	var container = sel.getRangeAt(0).commonAncestorContainer;
	var container_name = container.tagName;
	var attributes = container.attributes;
	var select_str = container_name.toLowerCase() + parse_attributes(attributes);
	return select_str;
};

function parse_attributes(attributes) {
	var attrs = [];
	for (i=0;i<attributes.length;i++) {
		var name = attributes[i].nodeName;
		var value = attributes[i].value;
    var attr = "[" + name + "=" + value + "]";
    attrs.push(attr);
	};

	var attrs_con = attrs.join('');
	return attrs_con;
};
*/

var shithead = [];
var dickhead = [];

function get_buttons() {
	var buttons = {
		yes: document.getElementById("yesbutton"),
		no: document.getElementById("nobutton"),
		too_much: document.getElementById("toomuch"),
		too_little: document.getElementById("toolittle"),
		popUp: document.getElementById("popUpDialog"),
		backtrack: document.getElementById("bcktrk"),
	};

	return buttons;
};

function show_buttons() {
	for (i = 0; i < arguments.length; i++) {
		$(arguments[i]).show();
	};
};

function hide_buttons() {
	for (i = 0; i < arguments.length; i++) {
		$(arguments[i]).hide();
	};
};


function selectify() {
	var sel = window.getSelection();
	var container = sel.getRangeAt(0).commonAncestorContainer;
	var backtrack = []
	remove_wrapper(container, backtrack);
};
	
function remove_wrapper(container, backtrack) {
	if ($(container).prop('tagName') != 'BODY') {
		remove_selection(container, backtrack);
	};
};

function remove_selection(container, backtrack) {
	$(container).hide();
	var buttons = get_buttons();
	show_buttons(buttons.popUp, buttons.too_much, buttons.too_little);

	buttons.yes.onclick = function () {
		hide_buttons(buttons.popUp, buttons.too_much, buttons.too_little);
		var taggert = new Taggert(container, $(container).parent()[0]);
		shithead.push(taggert);
	};

	buttons.too_much.onclick = function () { 
		$(container).show();
		hide_buttons(buttons.popUp, buttons.too_much, buttons.too_little);
		
		if (backtrack.length > 0) {
			bck = backtrack.pop();
			$(bck).show();
			remove_selection(bck, backtrack);
		};

	};

	buttons.too_little.onclick = function () {
		$(container).show();
		hide_buttons(buttons.popUp, buttons.too_much, buttons.too_little);
		backtrack.push(container);
		remove_wrapper($(container).parent()[0], backtrack);
	};
};

function finer_selectify(container) {
	var children = $(container).children();
	child_iterator(children, 0);
};

function child_iterator(children, i) {
	var buttons = get_buttons();

	if (i < children.length) { 
		check_child(children, i);
	}

	else {
		show_buttons([buttons.popUp, buttons.too_little]);

		buttons.yes.onclick = function () {
			hide_buttons(buttons.popUp, buttons.too_little);
		};

		buttons.too_little.onclick = function() {
			hide_buttons(buttons.popUp, buttons.too_little);
			remove_selection($(children[0]).parent()[0]);
		};

	};
};

function check_child(children, i) {
	var buttons = get_buttons()
	show_buttons(buttons.popUp, buttons.no);

	var child = children[i];
	$(child).hide();

	buttons.yes.onclick = function () {
		var taggert = new Taggert(child, $(child).parent()[0]);
		shithead.push(taggert);
		hide_buttons(buttons.popUp, buttons.no);
		child_iterator(children, i + 1);
	};

	buttons.no.onclick = function () { 
		$(child).show();
		hide_buttons(buttons.popUp, buttons.no);
		child_iterator(children, i + 1);
	};
};


function body_finder() {
	var sel = window.getSelection();
	var container = sel.getRangeAt(0).commonAncestorContainer;
	var backtrack = []
	body_selector(container, backtrack);
};

function body_selector(container, backtrack) {
	var buttons = get_buttons();
	var siblings = $(container).siblings();
	siblings.hide();

	show_buttons(buttons.popUp, buttons.too_much, buttons.too_little);

	buttons.yes.onclick = function () {
		hide_buttons(buttons.popUp, buttons.too_much, buttons.too_little);
		var taggert = new Taggert(container, $(container).parent()[0]);
		dickhead.push(taggert);
	};

	buttons.too_much.onclick = function () {
		hide_buttons(buttons.popUp, buttons.too_much, buttons.too_little);
		siblings.show();
		if (backtrack.length > 0) {
			bck = backtrack.pop();
			body_selector(bck, backtrack);
		};
	};

	buttons.too_little.onclick = function () {
		hide_buttons(buttons.popUp, buttons.too_much, buttons.too_little);
		siblings.show();
		backtrack.push(container);
		body_selector($(container).parent()[0], backtrack);
	};

	};

function Taggert(tag, parent) {
	this.tag = new Tag(tag);
	this.parent = new Tag(parent);
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

function save_info() { 
	var assface = {bad: shithead, good: dickhead}
	
	send_info(assface);
};