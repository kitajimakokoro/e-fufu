// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// ファイル選択時に選択したファイル名を表示する
jQuery(document).on('turbolinks:load', function(){
// ファイル選択ボタンがクリックされた時に以下の処理が呼び出される
//選択されたファイルの名前はe.target.files[0].nameによって取得
  $('input[type="file"]').change(function(e){
    var fileName = e.target.files[0].name;
// ファイル名が含まれるlabel要素のテキストが更新される
  $('label[for="inputFile"]').text(fileName);
  });
});
