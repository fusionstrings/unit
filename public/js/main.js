function registerDOMScript(){
	console.log(document.body);
}

function registerServiceWorker(){
	window.navigator.serviceWorker.register('/service-worker.js').then(function (registration) {
		// Registration was successful
		console.log('ServiceWorker registration successful with scope: ', registration.scope);
	}, function (err) {
		// registration failed :(
		console.log('ServiceWorker registration failed: ', err);
	});
}

function main(){
	if (typeof window !== undefined && 'addEventListener' in window) {
		window.addEventListener('load', function () {
			console.log('window', window)
			if('document' in window){
				registerDOMScript();
			}
			if ('navigator' in window && 'serviceWorker' in window.navigator) {
				registerServiceWorker();
			}
		});
	}
}

main();