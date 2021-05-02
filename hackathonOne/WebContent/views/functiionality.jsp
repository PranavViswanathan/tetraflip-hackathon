<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="hackathonStylesheet.css">
<title>Homepage</title>
</head>
<body>
	<div>Teachable Machine Image Model</div>
	<button type="button" onclick="init()">Start</button>
	<div id="webcam-container"></div>
	<div id="label-container"></div>
	<script
		src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>
	<script type="text/javascript">
    // More API functions here:
    // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image

    // the link to your model provided by Teachable Machine export panel
    const URL = "https://teachablemachine.withgoogle.com/models/5bu2mv7az/";

    var ani;
    var loopFlag = 1;

    let model, webcam, labelContainer, maxPredictions;

	// Load the image model and setup the webcam
	async
	function init() {
		const modelURL = URL + "model.json";
		const metadataURL = URL + "metadata.json";

		// load the model and metadata
		// Refer to tmImage.loadFromFiles() in the API to support files from a file picker
		// or files from your local hard drive
		// Note: the pose library adds "tmImage" object to your window (window.tmImage)
		model = await
		tmImage.load(modelURL, metadataURL);
		maxPredictions = model.getTotalClasses();

		// Convenience function to setup a webcam
		const flip = true; // whether to flip the webcam
		webcam = new tmImage.Webcam(200, 200, flip); // width, height, flip
		await
		webcam.setup(); // request access to the webcam
		await
		webcam.play();

		ani = requestAnimationFrame(loop);

		// append elements to the DOM
		document.getElementById("webcam-container").appendChild(webcam.canvas);
		labelContainer = document.getElementById("label-container");
		for (let i = 0; i < maxPredictions; i++) { // and class labels
			labelContainer.appendChild(document.createElement("div"));
		}
	}

	window.addEventListener("keydown", checkKeyPress, false);
	function checkKeyPress(key) {
		if (key.keyCode == 27) {

			if (noOfApples > 0) {
				console.log('Final points: ', totalPoints / noOfApples);
			}

			loopFlag = 0;
			console.log(loopFlag);
		}
	}

	var points = 0;
	var totalPoints = 0;
	var noOfApples = 0;

	async
	function loop() {
		console.log(loopFlag);
		webcam.update();
		await
		predict();
		if (loopFlag == 1) {
			window.requestAnimationFrame(loop);
		}
	}

	// run the webcam image through the image model
	async
	function predict() {
		// predict can take in an image, video or canvas html element
		const prediction = await
		model.predict(webcam.canvas);
		for (let i = 0; i < maxPredictions; i++) {
			const classPrediction = prediction[i].className + ": "
					+ prediction[i].probability.toFixed(2);
			labelContainer.childNodes[i].innerHTML = classPrediction;
		}
		points = 1 * prediction[1].probability + 2 * prediction[2].probability
				+ 3 * prediction[3].probability + 4 * prediction[4].probability
				+ 5 * prediction[5].probability;
		if (prediction[6].probability < 0.5) {
			totalPoints = totalPoints + (points * 2);
			noOfApples = noOfApples + 1;
		}
	}
</script>