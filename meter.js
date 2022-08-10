if (localStorage.distance > 0) {
  resume();
} else {
  reset();
  if (typeof localStorage.userid === "undefined") {
    $("#register_info").modal("show");
  } else {
    //updatelocation();
    //setInterval(updatelocation, 60000);
  }
}

var i = -1;
var lastd = 0;
var latavg = 0;
var lngavg = 0;
var data = [];

var timer;

if (typeof localStorage.fee === "undefined") {
  var package = {
    fee: 0,
    extrah: 180,
    extrakm: 40,
    freekm: 0,
    freeh: 0,
    free_limit: 25,
  };
} else {
  var package = {
    fee: localStorage.fee,
    extrah: localStorage.extrah,
    extrakm: localStorage.extrakm,
    freekm: localStorage.freekm,
    freeh: localStorage.freeh,
    free_limit: localStorage.free_limit,
  };
}

// fill package data on UI
for (p in package) {
  $("*[data-val='" + p + "']")
    .val(package[p])
    .text(package[p]);
}

// update package data
$("#package_edit_save").on("click", function () {
  for (p in package) {
    package[p] = Math.abs($("#" + p).val());
    localStorage.setItem(p, Math.abs($("#" + p).val()));
    $("*[data-val='" + p + "']").text(package[p]);
  }
});

function gps() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      update,
      function () {
        console.log("geolocation not available");
      },
      {
        timeout: 5000,
        enableHighAccuracy: true,
      }
    );
  }
}

var free_limit = Number(package.free_limit);

var speedlimit = 0;
var trafficlimit = free_limit / 3.6;

function update(position) {
  var distance = localStorage.distance;

  var now = new Date();
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;

  data.push({
    time: now,
    lat: lat,
    lng: lng,
  });
  i++;

  if (i == 0) {
    latavg = lat;
    lngavg = lng;
    return;
  }

  var tdiff = now - localStorage.starttime;
  $("*[data-val='time']").text(timediffstring(Math.abs(tdiff)));

  var d = Math.round(
    getdistance(
      latavg,
      lngavg,
      (latavg + +data[i].lat) / 2,
      (lngavg + +data[i].lng) / 2
    )
  );
  //var d2 = Math.round(getdistance(data[i-1].lat,data[i-1].lng,data[i].lat,data[i].lng));
  var speed =
    Math.round((d * 100000) / (data[i].time - data[i - 1].time)) / 100;

  $('*[data-val="speed"]').text(Math.round(speed * 360) / 100);

  latavg = (latavg + +data[i].lat) / 2;
  lngavg = (lngavg + +data[i].lng) / 2;

  if (!isNaN(d) && i > 1) {
    if (speed > speedlimit) {
      document.getElementById("pause").classList.add("pause");
      document.getElementById("traffic").classList.remove("traffic");
      document.getElementById("idle").classList.remove("idle");

      if (
        (data[i - 1].lat >= data[i - 2].lat &&
          data[i].lat >= data[i - 1].lat) ||
        (data[i - 1].lng >= data[i - 2].lng &&
          data[i].lng >= data[i - 1].lng) ||
        (data[i].lat <= data[i - 1].lat &&
          data[i - 1].lat <= data[i - 2].lat) ||
        (data[i].lng <= data[i - 1].lng && data[i - 1].lng <= data[i - 2].lng)
      ) {
        distance = +d + +distance;
      }
    }

    if (speed < trafficlimit && speed > 0) {
      document.getElementById("pause").classList.remove("pause");
      document.getElementById("traffic").classList.add("traffic");
      document.getElementById("idle").classList.remove("idle");
    } else if (speed == 0) {
      document.getElementById("traffic").classList.remove("traffic");
      document.getElementById("idle").classList.add("idle");
    }
  }

  $('*[data-val="distance"]').text(distance / 1000);
  localStorage.setItem("distance", distance);
  $("#price").text(price(distance, tdiff));
}

function getdistance(lat1, lon1, lat2, lon2) {
  var radlat1 = (Math.PI * lat1) / 180;
  var radlat2 = (Math.PI * lat2) / 180;
  var theta = lon1 - lon2;
  var radtheta = (Math.PI * theta) / 180;
  var dist =
    Math.sin(radlat1) * Math.sin(radlat2) +
    Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
  dist = Math.acos(dist);
  dist = (dist * 180) / Math.PI;
  dist = dist * 60 * 1.1515;
  return dist * 1.609344 * 1000;
}

function timediffstring(timediff) {
  var days = Math.floor(timediff / (1000 * 60 * 60 * 24));
  var hours = Math.floor((timediff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((timediff % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((timediff % (1000 * 60)) / 1000);

  days = days == 0 ? "" : days + "d ";
  hours = hours == 0 ? "" : hours + "h ";
  minutes = minutes == 0 ? "" : minutes + "m ";
  seconds = seconds == 0 ? "" : seconds + "s ";

  return days + hours + minutes + seconds;
}

function timediffstring2(timediff) {
  if (timediff <= 0) {
    return "0 h";
  }

  var days = Math.floor(timediff / (1000 * 60 * 60 * 24));
  var hours = Math.floor((timediff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((timediff % (1000 * 60 * 60)) / (1000 * 60));

  days = days == 0 ? "" : days + "d ";
  hours = hours == 0 ? "" : hours + "h ";
  minutes = minutes == 0 ? "" : minutes + "m ";

  return days + hours + minutes;
}

function start() {
  $("#start_btn").hide();
  $("#resume_btn").hide();
  $("#reset_btn").hide();
  $("#stop_btn").show();
  $("#change_package").hide();
  $("#package_edit_btn").hide();

  starttime = new Date();

  localStorage.setItem("starttime", starttime.getTime());
  localStorage.setItem("distance", 0);

  timer = setInterval(gps, 1000);
}

function stop() {
  $("#stop_btn").hide();
  $("#resume_btn").show();
  $("#reset_btn").show();

  clearInterval(timer);
}

function resume() {
  $("#stop_btn").show();
  $("#resume_btn").hide();
  $("#reset_btn").hide();
  $("#start_btn").hide();

  timer = setInterval(gps, 1000);
  $("#package_edit_btn").hide();
}

function reset() {
  $("#start_btn").show();
  $("#reset_btn").hide();
  $("#resume_btn").hide();
  $("#stop_btn").hide();

  clearInterval(timer);

  localStorage.setItem("distance", 0);
  localStorage.setItem("starttime", 0);

  $("#diatance_meter").text(0);
  $("*[data-val='time']").text(0);
  $('*[data-val="speed"]').text(0);
  $("#price").text(0);
  $("#distance").text(0);

  $("#package_edit_btn").show();

  $("#extra_distance").text(0);
  $("#extra_time").text(0);

  $("#extrah_price").text(0);
  $("#extrakm_price").text(0);

  document.getElementById("pause").classList.remove("pause");
  document.getElementById("traffic").classList.remove("traffic");
  document.getElementById("idle").classList.add("idle");
}

function price(d, t) {
  var per_second = Number(package.extrah) / 3600;
  var per_meter = Number(package.extrakm) / 1000;
  var free_meters = Number(package.freekm) * 1000;
  var free_seconds = Number(package.freeh) * 3600;
  var fee = Number(package.fee);
  var free_limit = Number(package.free_limit);

  var free_seconds_per_meter = 3.6 / free_limit;

  var free_seconds2 = Math.round(
    Math.max(d - free_meters, 0) * free_seconds_per_meter
  );

  var price_distance = Math.round(Math.max(d - free_meters, 0) * per_meter);
  var price_time = Math.round(
    Math.max(t / 1000 - free_seconds - free_seconds2, 0) * per_second
  );

  $("#extrakm_price").text(price_distance);
  $("#extrah_price").text(price_time);

  $("#extra_distance").text(Math.max(Math.round(d - free_meters) / 1000, 0));
  $("#extra_time").text(
    Math.max(Math.round((t / 1000 - free_seconds - free_seconds2) / 36) / 100),
    0
  );

  var price = fee + price_distance + price_time;

  return formatprice(price);
}

function formatprice(price) {
  return (Math.round(price * 10000) / 10000)
    .toString()
    .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function updatelocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      function (position) {
        $.ajax({
          type: "POST",
          url: "../api/meter/updatelocation.php",
          data: {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
            id: localStorage.userid,
          },
          dataType: "json",
          success: function (response) {
            console.log(response);
          },
        });
      },
      function () {
        console.log("geolocation not available");
      },
      {
        timeout: 5000,
        enableHighAccuracy: true,
      }
    );
  }
}
