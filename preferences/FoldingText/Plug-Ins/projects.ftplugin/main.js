define(function(require, exports, module) {
    'use strict';

    const promisify = (fn, ...args) => {
        return new Promise((resolve, reject) => {
            fn(...args, (err, data) => {
                if (err) {
                    return reject(err);
                }
                resolve(data);
            });
        });
    };

    require('./gapi.js');
    console.log("yolo");
    console.log('native', window.nativeViewController);
    console.log('open', window.open)
    window.open('https://seznam.cz', '_blank');

    async function init() {
        await promisify(gapi.load, 'client:auth2');
        await gapi.client.init({
            apiKey: 'AIzaSyAhqghfxGPoHhti3rAR_S4aaUm1r2qX1Y0',
            clientId: '12305674925-5ssro96s8641qhufs9n2ecndl8cvu7bv.apps.googleusercontent.com',
            scope: 'https://www.googleapis.com/auth/drive.metadata.readonly',
        })
    }



})