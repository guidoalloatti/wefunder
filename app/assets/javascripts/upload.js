const element = document.querySelector('#customText');
console.log(element)
FileUpload.getInstance(element).update({defaultMsg: 'Hello this is custom message' });