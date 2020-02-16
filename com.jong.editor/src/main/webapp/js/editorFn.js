/**
 * 
 */
var editorFn = {
	$editor : null,
	init : function(editor) {
		this.$editor = $(editor);
		this.$editor.children(".editorDiv").height(300);
		this.$editor.children(".editorHTMLDiv").height(300);
		this.$editor.children(".editorHTMLDiv").hide();
		this.connectEvt();
	},
	connectEvt : function() {
		var that = editorFn;
		var $editorToolbar = that.$editor.children(".editorToolbar");
		var $editorModal = that.$editor.children(".modal");

		$editorToolbar.children(".imgModalBtn").on("click", that.showImgUploadModal);
		$editorToolbar.children(".toHTMLBtn").on("click", that.convertToHTML);
	
		$editorModal.on("click", ".sendImgBtn", that.uploadImg);
		$editorModal.on("change", ".imgFile", function() { that.readURL(this); });
		$editorModal.on("hide.bs.modal", that.initImgUploadModal);
	},
	initImgUploadModal : function() {
		var $modal = editorFn.$editor.children(".modal");
		var $imgFile_P = $modal.find(".imgFile").parent();
		var $miribogi_P = $modal.find(".miribogi").parent();
		var newImgFile = document.createElement("input");
		var newMiribogi = document.createElement("img");
		
		newImgFile.setAttribute("type", "file");
		newImgFile.setAttribute("class", "imgFile form-control form-control-sm");
		newMiribogi.setAttribute("class", "miribogi form-control form-control-sm mx-auto");

		$imgFile_P.children().remove();
		$miribogi_P.children().remove();

		$imgFile_P.append(newImgFile);
		$miribogi_P.append(newMiribogi);
	},
	showImgUploadModal : function() {
		editorFn.$editor.children(".modal").modal("show");
	},
	uploadImg : function() {
		var that = editorFn;
		var $modal = that.$editor.children(".modal");
		var formData = new FormData();
		
		formData.append("img", $modal.find(".imgFile")[0].files[0]);
		formData.append("width", $modal.find(".width").val());
		formData.append("height", $modal.find(".height").val());
		formData.append("uploadFolder", that.$editor.children("[name='uploadFolder']").val());
		
		$.ajax({
			url : 'imgUpload.do',
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			dataType : "json",
			success : function(data) {
				var imgTag = document.createElement("img");

				imgTag.setAttribute("src", data.uploadPath + "/" + data.uploadFolder + "/" + data.imgSrc);
				imgTag.setAttribute("width", data.width);
				imgTag.setAttribute("height", data.height);
				
				that.$editor.children(".editorDiv").append(imgTag);
				that.$editor.children(".modal").modal("hide");
			},
			error:function(request,status,error){
				alert("에러가 발생하였습니다. console을 확이해주십시오.");
				console.log(error);
		    }
		});
	},
	readURL : function(input) {
		var $editorModal = editorFn.$editor.children(".modal");
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$editorModal.find(".miribogi").width($editorModal.find(".width").val());
				$editorModal.find(".miribogi").height($editorModal.find(".height").val());
				$editorModal.find(".miribogi").attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	},
	convertToEditor : function() {
		var that = editorFn;
		var $editorDiv = that.$editor.children(".editorDiv");
		var $editorHTMLDiv = that.$editor.children(".editorHTMLDiv");
		var $editorToolbar = that.$editor.children(".editorToolbar");

		$editorDiv.html($editorHTMLDiv.text());
		$editorDiv.show();
		$editorHTMLDiv.hide();
		$editorToolbar.children("button").prop("disabled", false);
		$editorToolbar.children(".toHTMLBtn").off("click");
		$editorToolbar.children(".toHTMLBtn").on("click", that.convertToHTML);
	},
	convertToHTML : function() {
		var that = editorFn;
		var $editorDiv = that.$editor.children(".editorDiv");
		var $editorHTMLDiv = that.$editor.children(".editorHTMLDiv");
		var $editorToolbar = that.$editor.children(".editorToolbar");

		$editorHTMLDiv.text($editorDiv.html());
		$editorHTMLDiv.show();
		$editorDiv.hide();
		$editorToolbar.children("button").prop("disabled", true);
		$editorToolbar.children(".toHTMLBtn").prop("disabled", false);
		$editorToolbar.children(".toHTMLBtn").off("click");
		$editorToolbar.children(".toHTMLBtn").on("click", that.convertToEditor);
	},
	getEditorHTML : function() {
		return editorFn.$editor.children(".editorDiv").html();
	},
	getEditorTEXT : function() {
		return editorFn.$editor.children(".editorDiv").text();
	},
	getImgNmArr : function() {
		var imgNmArr = [];
		var $img = editorFn.$editor.children(".editorDiv").find("img");
		$img.each(function(i) {
			var temp = $img.eq(i).attr("src").split("/");
			imgNmArr.push(temp[temp.length - 1]);
		});
		return imgNmArr;
	}
}