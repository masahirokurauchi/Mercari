$(function(){
	function buildCategoryForm(categories) { // カテゴリのフォームを組み立ててappendする。

	    let options = ``;  // buildOption関数でこれを組み立てる
	    categories.choices.forEach(function (category) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
	      options += buildOption(category);
	    });
	    
	    let blank = "---";
	    
	    let html = `
	                <select required="required" name="item[category_id]" class="select-category">
	                  <option value="">${blank}</option>
	                  ${options}
	                </select>
	                `
	    return html;
	}

	function buildOption(category) { // 渡されてきたデータを使ってoptionタグを組み立てる。
		let option = `
	                 <option value="${category.id}">${category.name}</option>
	                 `
	    return option;
	}

	$(document).on("change", ".select-category", function () {
	  var category_id = $(this).val();
	  // ↓追加
	  if (!category_id) { // 「---」が選択されたら終了
	  // 後続（変更されたのが親カテゴリなら子孫全て、子カテゴリなら孫カテゴリ、孫カテゴリなら無し）を消去しておく。
	  $(this).nextAll('.select-category').remove();
	      return false;
	  }
	  // 孫カテゴリのフォームが存在しており尚且つvalueが空のとき（つまりバグっている時）
      // 強制的にリロードさせる
      if ($(`select[name="item[category_id]"]`).eq(2)[0] && !$(`select[name="item[category_id]"]`).eq(2).val()) {
        //戻るボタンを押したときカテゴリのselectがバグっている場合、リロードさせる。
        location.reload();
      }
	  $.ajax({
	      url: `/api/categories`,
	      type: 'GET',
	      data: {
	        category_id: category_id
	      },
	      dataType: 'json',
	       })
	      .done(function (categories) {
	        if (categories.choices.length == 0){
	          return false;
	        }
	        var html = buildCategoryForm(categories) // カテゴリのフォームを組み立ててる。
	        // ↓追加
	        $(this).nextAll('.select-category').remove();
	        $("select.select-category:last").after(html); // カテゴリのフォームたちの一番最後にappendする。
	        // ↓追加
	      }.bind(this));
	});
});