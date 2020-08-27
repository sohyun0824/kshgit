var _token = jwtToken;


/*
���� �α��� / �α׾ƿ� ���� ���ϰ�� ó���ҷ���

//���� ���丮������ ��ū �����´�
var _token = sessionStorage.getItem("jwtToken");

//��ū�� ������� �������� ������ ��ū�� Ȱ��
if(_token == null) {
    _token = sessionStorage.setItem('jwtToken', jwtToken);
}
*/

//����� �� ��� getCookie �Լ� ���Ǻ��� ȣ���� ���� �����
function getCookie( name )
{
    var nameOfCookie = name + "=";
    var x = 0;
    while ( x <= document.cookie.length )
    {
        var y = (x+nameOfCookie.length);
        if ( document.cookie.substring( x, y ) == nameOfCookie ) {
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) );
        }
        x = document.cookie.indexOf( " ", x ) + 1;
        if ( x == 0 )
            break;
    }
    return "";
}

function useOwnJWT() {
   var is_cached = getCookie("is_cached"); // Y or N
   if(is_cached) {
       if(is_cached == "N") {
           sessionStorage.setItem('_JWT', jwtToken);
       } else {
           if(sessionStorage.getItem('_JWT')) {
               _token = sessionStorage.getItem('_JWT');
           }
       }
   }
}
function update_when_loggin() {

    var is_login = getCookie("is_login"); // Y or N
    if(is_login && is_login == "Y") {
        sessionStorage.setItem('_JWT', jwtToken);
    }
}
// useOwnJWT();
// update_when_loggin();

var kurlyApi = axios.create({
    baseURL: apiDomain
});

//��� ����� ������ ��ū�� �Բ� ������.
kurlyApi.interceptors.request.use(function (config) {
    // Do something before request is sent
    // console.log(config);
    if( !config._retry) {
        //console.log(config._retry);
        config.headers.authorization = 'Bearer '+_token;
    }
    config.headers.accept =  "application/json";
    
    // 301 error - hotfix
    if(config.url.indexOf('?') === -1){
        config.url += '?ver=1';    
    }
    
    return config;
}, function (error) {
    // Do something with request error
    return Promise.reject(error);
});
var countkurlyApi = 0
//��� ���信 ���Ѿ����� �ð�� �����ϵ��� ó���Ѵ�.
kurlyApi.interceptors.response.use(function (response){
    return response
}, function (error) {
    var originalRequest = error.config;
    if (error.response.status === 401 && !originalRequest._retry) {
        originalRequest._retry = true; // now it can be retried
        if (countkurlyApi > 3) {
            countkurlyApi = 0;
            return;
        }
        countkurlyApi++
        return kurlyApi.post('/v1/users/auth/token').then(function (response) {
            _token = response.data.data.token;
            sessionStorage.setItem('_JWT', _token);
            originalRequest.headers['authorization'] = 'Bearer ' + _token; // new header new token
            return kurlyApi(originalRequest); // retry the request that errored out
        }).
        catch(function(error) {
            // sessionStorage.setItem('jwtToken', null);
            alert('���ΰ�ħ�� �ٽ� �õ����ּ���.')
            return;
        })
    }
    // Do something with response error
    return Promise.reject(error)

});