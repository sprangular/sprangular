(function() {
  var formatMessage, messages;

  messages = {
    required: "can't be blank",
    greaterThan: "must be greater than {{arg}}",
    greaterThanOrEqual: "must be greater than or equal to {{arg}}",
    lessThan: "must be less than {{arg}}",
    lessThanOrEqual: "must be less than or equal to {{arg}}",
    regex: 'is invalid',
    length: "length must be {{length}}",
    lengthGreaterThan: "length must be greater than {{length}}",
    lengthLessThan: "length must be less than {{length}}",
    number: "must be a number"
  };

  formatMessage = function(messageKey, args) {
    var key, message, regex, value;
    message = messages[messageKey];
    for (key in args) {
      value = args[key];
      regex = RegExp("{{" + key + "}}", "g");
      message = message.replace(regex, value);
    }
    return message;
  };

  window.Validity = {
    MESSAGES: messages,
    RULES: {
      required: function(object, attr) {
        if (!object[attr]) {
          return formatMessage('required');
        }
      },
      greaterThan: function(object, attr, arg) {
        if (!(Number(object[attr]) > arg)) {
          return formatMessage('greaterThan', {
            arg: arg
          });
        }
      },
      greaterThanOrEqual: function(object, attr, arg) {
        if (!(Number(object[attr]) >= arg)) {
          return formatMessage('greaterThanOrEqual', {
            arg: arg
          });
        }
      },
      lessThan: function(object, attr, arg) {
        if (!(Number(object[attr]) < arg)) {
          return formatMessage('lessThan', {
            arg: arg
          });
        }
      },
      lessThanOrEqual: function(object, attr, arg) {
        if (!(Number(object[attr]) <= arg)) {
          return formatMessage('lessThanOrEqual', {
            arg: arg
          });
        }
      },
      regex: function(object, attr, arg) {
        if (!String(object[attr]).match(arg)) {
          return formatMessage('regex');
        }
      },
      length: function(object, attr, arg) {
        var length, value;
        value = object[attr] || '';
        if (typeof arg === 'number') {
          if (value.length !== arg) {
            return formatMessage('length', {
              length: arg
            });
          }
        } else if (typeof arg === 'object') {
          if (length = arg['greaterThan']) {
            if (value.length < length) {
              return formatMessage('lengthGreaterThan', {
                length: length
              });
            }
          }
          if (length = arg['lessThan']) {
            if (value.length > length) {
              return formatMessage('lengthLessThan', {
                length: length
              });
            }
          }
        }
      },
      number: function(object, attr) {
        if (typeof object[attr] !== 'number') {
          return formatMessage('number');
        }
      }
    },
    _normalizeRules: function(rules) {
      var attr, def, dict, self;
      self = this;
      dict = {};
      for (attr in rules) {
        def = rules[attr];
        self._normalizeRule(attr, def, dict);
      }
      return dict;
    },
    _normalizeRule: function(attr, def, dict) {
      var key, rule, self, val, _i, _len;
      dict[attr] || (dict[attr] = {});
      switch (typeof def) {
        case 'string':
          dict[attr][def] = null;
          break;
        case 'object':
          self = this;
          if (Array.isArray(def)) {
            for (_i = 0, _len = def.length; _i < _len; _i++) {
              rule = def[_i];
              self._normalizeRule(attr, rule, dict);
            }
          } else {
            for (key in def) {
              val = def[key];
              dict[attr][key] = val;
            }
          }
      }
      return dict;
    },
    define: function(klass, rules) {
      if (rules == null) {
        rules = {};
      }
      klass.validations = this._normalizeRules(rules);
      klass.prototype.validate = function() {
        var arg, attr, error, fn, name, object, validations, value, _base, _ref;
        object = this;
        this.errors = {};
        _ref = klass.validations;
        for (attr in _ref) {
          validations = _ref[attr];
          value = object[attr];
          for (name in validations) {
            arg = validations[name];
            error = null;
            if (fn = Validity.RULES[name]) {
              error = fn(object, attr, arg);
            } else {
              fn = object[name];
              if (!(fn && typeof fn === 'function')) {
                throw "Validator " + name + " is not defined";
              }
              error = fn.apply(object, [attr, arg]);
            }
            if (error) {
              (_base = object.errors)[attr] || (_base[attr] = []);
              object.errors[attr].push(error);
            }
          }
        }
        return this.errors;
      };
      klass.prototype.isValid = function() {
        var key, value, _ref;
        this.validate();
        _ref = this.errors;
        for (key in _ref) {
          value = _ref[key];
          return false;
        }
        return true;
      };
      return klass.prototype.isInvalid = function() {
        return !this.isValid();
      };
    }
  };

}).call(this);
