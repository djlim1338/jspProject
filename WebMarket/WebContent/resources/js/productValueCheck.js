
var formInputs = document.getElementsByClassName("checkNull");  // input태그 빈칸 확인
var formRadiosCondition = document.getElementsByName("condition");  // 상태값 라디오 선택 확인

var frm = document.getElementById("newProductForm");  // 입력 form
var inputPruductId = document.getElementById("productId");  // 상품코드 INPUT
var hiddenOldPruductId = document.getElementById("productId_old");  // 상품코드 INPUT hidden
var samePruductIdStateImg = document.getElementById("samePruductIdStateImg");  // 중복확인 이미지
var samePruductIdBtn = document.getElementById("sameIdCheckBtn");  // 중복확인 버튼
var openWin;  // 새 창(popup)

var btnStrO = "확인완료"
var btnSrcO = "./resources/images/img_o_15.png"
var btnStrX = "중복확인"
var btnSrcX = "./resources/images/img_x_15.png"

function formSubmit(){
	for(var i=0; i<formInputs.length; i++){
		if(formInputs[i].value == null || formInputs[i].value == ""){
			alert("해당 필드가 비어있습니다.");
			formInputs[i].focus();
			return;
		}
	}
	
	var formRadioCounter = 0;
	for(; formRadioCounter<formRadiosCondition.length; formRadioCounter++){
		if(formRadiosCondition[formRadioCounter].checked == true) break;
	}
	if(formRadioCounter == formRadiosCondition.length){
		alert("상태를 선택하셔야 합니다.");
		formRadiosCondition[0].focus();
		return;
	}

	if(samePruductIdBtn.value == btnStrO){
		frm.submit();
	}
	else{
		pruductId = inputPruductId.value
		if(pruductId == null || pruductId == ""){
			alert("상품 코드를 입력해 주세요!");
			inputPruductId.focus();
		}
		else{
			alert("중복확인을 먼저 진행해 주세요!")
			samePruductIdBtn.focus();
		}
	}
}

function sameIdCheck(){  // 중복확인
	pruductId = inputPruductId.value
	var sendSrc = "./sameIdCheck.jsp?id="+pruductId;
	if(pruductId == null || pruductId == ""){
		alert("상품 코드를 입력해 주세요!");
		inputPruductId.focus();
		return;
	}
	if(samePruductIdBtn.value == btnStrO){
		alert("중복 확인을 이미 완료했습니다!\n변경하려면 입력값을 바꿔주세요!");
		return;
	}
	
	var popupWindowWidth = 350
	var popupWindowHeight = 100
	var popupWindowX = ((window.screen.width / 2) - (popupWindowWidth / 2))
	var popupWindowY = ((window.screen.height / 2) - (popupWindowHeight / 2))
	openWin = window.open(
			sendSrc, 
			"childForm", 
			"width="+popupWindowWidth
			+", height="+popupWindowHeight
			+", resizable = no, scrollbars = no, left="
			+popupWindowX
			+" top="+popupWindowY+"");
}

function sameCheckBtnChangeO(){  // 완료로 표시
	samePruductIdStateImg.src=btnSrcO;
	samePruductIdBtn.value=btnStrO;
	samePruductIdBtn.classList.replace("btn-danger", "btn-success");
}
function sameCheckBtnChangeX(){  // 미완료로 표시
	samePruductIdStateImg.src=btnSrcX;
	samePruductIdBtn.value=btnStrX;
	samePruductIdBtn.classList.replace("btn-success", "btn-danger");
}

function changePruductId(){  // 상품ID변경시 (둘다 고려)
	if(hiddenOldPruductId == null) {
		sameCheckBtnChangeX(); 
	}
	else{
		if((inputPruductId.value == hiddenOldPruductId.value)) sameCheckBtnChangeO(); 
		else sameCheckBtnChangeX(); 
	}
}

		
		