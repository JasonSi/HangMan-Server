// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$("#apply_submit").click(function(){
  apple_id = $("#apple_id").val()
  email_reg = /^[\w+\-.]+@[A-Za-z\d\-.]+\.[A-Za-z]+$/
  if(apple_id.match(email_reg)){
    $.post("/",
    {
      "apple_id": $("#apple_id").val()
    },
    function(data,textStatus){
      if(textStatus === 'success'){
        if(data.result === 'failed'){
          alert("格式错误")
        } else if(data.result === 'success'){
          //申请成功，显示感谢
          alert(data.message)
        }
      } else {
        //请求失败处理待改进
        alert('网络错误！');
      }
    })
  } else {
    alert("格式错误")
  }
})
