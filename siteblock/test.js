const CDP = require('chrome-remote-interface');
const fs = require('fs');
const path = require('path');


function readDomains() {
  return fs.readFileSync(path.resolve('../target_domains'), {encoding: 'utf8'});
}

async function example() {
  let client;
  try {
    // connect to endpoint
    client = await CDP();
    // extract domains
    const {Network, Page, DOM, Runtime} = client;
    // setup handlers
    Network.requestWillBeSent((params) => {
      // console.log(params.request.url);
    });
    // enable events then start!
    await Network.enable();
    await Page.enable();
    await Page.navigate({url: 'chrome-extension://mackolfpcjdnngofjhoklekgeloifkom/html/options.html'});
    await Page.loadEventFired();

    let domains = readDomains().replace(/\n/g, '\\n');
    console.log(domains);

    await Runtime.evaluate({expression: 'document.querySelector(\'#rules\').value = \'' + domains + '\'; save_options();'});
  } catch (err) {
    console.error(err);
  } finally {
    if (client) {
      await client.close();
    }
  }
}

example();
