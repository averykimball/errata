// Ramda style utility functions

// Function covenant : (key, value))
var traverseObj = function (func, obj) {
  var partialTraverse =  function (partialObj) {
    for (var c in partialObj) {
      func(c, partialObj[c]);
      if (partialObj[c] !== null && typeof (partialObj[c]) === "object") {
        traverseObj(func, partialObj[c]);
      }
    }
    return partialObj;
  };
  
  if (obj === null || typeof obj === "undefined") {
    return partialTraverse; 
  } else {
    return partialTraverse(obj);
  }
};

// Function covenant : (key, value))
var mapObj = function (func, obj) {
  if (obj === null || typeof obj === "undefined") {
    return function(partialObj){
      var partialAccumulator = [];
      traverseObj(function(key, value) {
        partialAccumulator.push(func(key, value));
      }, partialObj);
      return partialAccumulator;
    };
  } else {
    var accumulator = [];
    traverseObj(function(key, value) {
      accumulator.push(func(key, value));
    });
    return accumulator;
  }
};

// Use in conjunction with mapObj for traversing/maniping trees
var pathedObj = function (func, obj, path) {
  if (path === null || typeof path === "undefined") {
    return function (partialPath) {};
  };
};
