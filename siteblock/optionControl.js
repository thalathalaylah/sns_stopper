const CDP = require('chrome-remote-interface');
const fs = require('fs');
const path = require('path');

function toBoolean(booleanStr) {
  return booleanStr.toLowerCase() === "true";
}

function convertToText(domains) {
  let text = '';
  for(let domain of domains) {
    text = text + domain + '\\n'
  }
  return text;
}

async function example(forbid) {
  let client;
  let settings = require('../settings.json');
  try {
    // connect to endpoint
    client = await CDP();
    // extract domains
    const {Network, Page, Runtime} = client;
    // setup handlers
    Network.requestWillBeSent((params) => {
      // console.log(params.request.url);
    });
    // enable events then start!
    await Network.enable();
    await Page.enable();

    await Page.navigate({url: settings.extensionOptionUrl});
    await Page.loadEventFired();

    let domains = forbid ? convertToText(settings.targetDomains) : '';

    await Runtime.evaluate({expression: 'document.querySelector(\'#rules\').value = \'' + domains + '\'; save_options();'});
    await Runtime.evaluate({expression: 'window.history.back(-1)'});
  } catch (err) {
    console.error(err);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

example(toBoolean(process.argv[2]));
