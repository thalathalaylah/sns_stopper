const CDP = require('chrome-remote-interface');
const fs = require('fs');
const path = require('path');

function toBoolean(booleanStr) {
  return booleanStr.toLowerCase() === "true";
}

function readDomains() {
  return fs.readFileSync(path.resolve('../target_domains'), {encoding: 'utf8'});
}

function readExtensionUrl() {
  return fs.readFileSync(path.resolve('./extension_url'), {encoding: 'utf8'});
}

async function example(forbid) {
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
    await Page.navigate({url: readExtensionUrl().replace(/\n/g, '')});
    await Page.loadEventFired();

    let domains = forbid ? '' : readDomains().replace(/\n/g, '\\n');
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

example(toBoolean(process.argv[2]));
