$(document).ready(function() {

  if (!$('#selected-item-images')[0]) return false; //カテゴリのフォームがないなら以降実行しない。

  const item_images_limit = 5; //添付できる画像の枚数
  const form = $("form"); //form要素を変数に入れておく
  
  function buildImagePreview(blob, index) { //選択した画像ファイルのプレビューを表示する。
    html = `
            <div class="item-image new" data-index=${index}>
              <img src =${blob} class="item-image__image">
              <div class="item-image__buttons">
                <div class="item-image__buttons--edit">
                編集
                </div>
                <div class="item-image__buttons--delete">
                削除
                </div>
              </div>
            </div>
            `;
    $("#select-image-button").before(html);
  }
  /////////buildImagePreview()ここまで/////////

  function newUploadItemImageField() { //新規画像投稿用のfile_fieldを作成しappendする。
    let new_file_field_index = $(`.new-item-image`).last()[0].dataset.index
    // Numberメソッド→引数を数値に変換する
    // datasetメソッドで取得すると全て文字列になってしまうためこうする
    // dataメソッドならこれをやる必要はない
    new_file_field_index = Number(new_file_field_index) + 1;
    let html = `
                <input class="new-item-image" id="file_field_index_${new_file_field_index}" name="item[item_images_attributes][${new_file_field_index}][image]" accept="image/*" type="file" data-index="${new_file_field_index}">
              `
    $("#image-file-fields").append(html);
  }
  /////////newUploadItemImageField()ここまで/////////

  ///////////////////////////////////////////////////////////////
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時。/////////
  ///////////////////////////////////////////////////////////////
  $("#select-image-button").on("click", function () {
    if ($(".item-image__image").length >= item_images_limit) { //プレビュー画像のlength＝UPされた画像の枚数。画像枚数の上限に引っかかる場合はここで終了。
      alert.log("これ以上画像UPできません ");
      return false;
    }
    let file_field = $(`.new-item-image`).last(); // 新規投稿画像用の最後のfile_field（最後のfile_fieldは中身がないため）を取得する。
    file_field.trigger("click"); // file_fieldをクリックさせる。
  });
  /////////画像の投稿ボタン（グレーのブロック）をクリックした時ここまで/////////


  /////////////////////////////////////////////
  /////////画像の削除ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $("#selected-item-images").on("click", ".item-image__buttons--delete", function (e) {
    e.stopPropagation(); // 親要素のイベントが発火するのを防ぐ。
    let image_wrapper = $(this).parents(".item-image"); // 削除する画像の大枠を取得する。
    let index = image_wrapper[0].dataset.index; //何番目の画像を削除するか選択する。
    image_wrapper.remove() // プレビュー画像を削除する。
    $(`#item_item_images_attributes_${index}__destroy`).prop("checked", true); //削除予定か否かのチェックをいれておく。
    $(`#file_field_index_${index}`).remove();
  });
  /////////画像の削除ボタンをクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////画像の編集ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $("#selected-item-images").on("click", ".item-image__buttons--edit", function (e) {
    e.stopPropagation(); // 親要素のイベントが発火するのを防ぐ。
    let index = $(this).parents(".item-image")[0].dataset.index; //何番目の画像を変更するかを取得する。
    $(`#file_field_index_${index}`).trigger("click");
  });
  /////////画像の編集ボタンをクリックした時ここまで/////////

  /////////////////////////////////////////////
  /////////file_fieldが変化した時/////////
  ////////////////////////////////////////////
  $(`#image-file-fields`).on("change", `input[type="file"]`, function (e) { //新しく画像が選択された、もしくは変更しようとしたが何も選択しなかった時
    let file = e.target.files[0];
    let index = $(this)[0].dataset.index //何番目の画像か
    if (!file) { // fileの中身がない＝画像を変更しようとしたが何も選択しなかった場合
      // 削除ボタンを押したときと同じ挙動をさせる
      $(`.item-image[data-index=${index}]`).find(".item-image__buttons--delete").trigger("click");
      return false;
    }
    let blob = window.URL.createObjectURL(file); //選択された画像をblob形式に変換する。
    //↑このblobをsrc属性値として使ったimgタグを表示することで、投稿画像のプレビュー機能になる。
    if ($(`.item-image[data-index=${index}]`)[0]) { // 既に画像がある＝画像変更の場合
      let before_image = $(`.item-image[data-index=${index}]`).find(".item-image__image");
      // プレビューを変更して終了
      before_image.attr('src', blob);
      return false;
    }
    buildImagePreview(blob, index); // 選択された画像のプレビューを表示する。
    newUploadItemImageField(); //新規画像投稿用のfile_fieldを組み立ててappendする。
  });
  /////////file_fieldが変化した時ここまで/////////

  /////////////////////////////////////////////
  /////////出品/編集ボタンをクリックした時/////////
  ////////////////////////////////////////////
  $(`input[type="submit"]`).on("click", function (e) {  // formをsubmitではなく、送信ボタンをclickにしておく
    e.preventDefault();

    let url = "/api" + form.attr("action");
    let formData = new FormData(form[0]);

    $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function (item) {
        if (item.error) { // @errorがある場合、何かしらエラーが発生している
          // アラートを表示して中断
          alert(item.error);
          return false;
        }
        $("form").append(`<input type="hidden" value="true" name="completed">`)
        $("form").submit();
      })
      .fail(function () {
        alert("商品出品に失敗しました");
      })
      .always(function () {
        $(".button").prop('disabled', false);
      })

  })
  /////////出品/編集ボタンを押した時ここまで/////////

});