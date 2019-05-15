// Authenticating Requests with JS - convert to Ruby



// Get Access token using client credential
// https://developer.domain.com.au/docs/authorisation/client-credentials-grant

// For HTTP requests use axios - equilivent to Ruby HTTParty
const axios = require('axios')
const querystring = require('querystring')

/**
 * Get access token using client credential auth flow
 * @param {string} clientId Your client's Id
 * @param {string} secret Your client's secret
 */

function getAccessToken(clientId, secret) {
  //querysting.stringify method produces a URL string from the object. Basically translates into grant_type=client_credentials&scope=api_agencies_read&scope=api_listings_read

    var data = querystring.stringify({
        grant_type: 'client_credentials',
        scope: 'api_agencies_read api_listings_read'
    });

    // Now make http request
    return axios.post('https://auth.domain.com.au/v1/connect/token', data, {
        headers: {
            'Authorization': `Basic ${base64(`${clientId}:${secret}`)}`,
            'Content-Type': 'application/x-www-form-urlencoded',
        }
    }).then(result => { // .then returns a promise (result)
        const { access_token } = result.data;
        //store your access_token for authenticating your API calls
        console.log(access_token);
    }).catch(err => console.error(err.response.data)) //.catch deals with rejected cases
}

function base64(str) { // node method 
    return Buffer.from(str).toString('base64')
}

module.exports = getAccessToken 





// Making a request to get listing by id
const axios = require('axios')
/**
 * Get listing by id
 * @param {string} listingId
 * @param {string} accessToken
 */
function getListingById(listingId, accessToken) {
    return axios.get(`https://api.domain.com.au/v1/listings/${listingId}`, {
        headers: {
            'Authorization': `Bearer ${accessToken}`,
        }
    }).then(result => {
        const { data } = result;
        console.log(data);
    }).catch(err => console.error(err.response.data))
}

module.exports = getListingById 



