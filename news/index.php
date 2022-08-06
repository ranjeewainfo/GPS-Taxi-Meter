<?php
require "../src/config.php";

//page setup
page_setup([
  "id" => "news",
  "title" => "News and updates",
  "size" => "box-lg"
]);

require($head);

?>
<div class="icard">

  <div class="icard-top banner">
    News and Updates
  </div>

  <div id="newslist"></div>

</div>

<script id="template" type="text/template">

  <div class="list p-2">
    {{#data}}
    <div class="li-item" id="{{id}}">

        <div class="li-content py-3">

            <div class="news-title">{{title}}</div>

            <div class="text-xs">
              <span class="text-muted">{{date}}&nbsp; {{time}}</span>
            </div>

            <div class="news-content">
              {{{content}}}
            </div>

        </div>

    </div>

    {{/data}}

  </div>

</script>

<script>
  $.getJSON(API + "news.php", function(response) {
    template = $("#template").html();
    content = Mustache.render(template, response);
    $("#newslist").html(content);
  });
</script>
<?php require($footer); ?>