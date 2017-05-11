/**
 * Created by erik.little on 5/11/17.
 */

(function() {
    const name = 'hello_world';

    $.get({ url: '/api/name/echo/?' + $.param({ name: name }), success: (response) => {
        $('#name').text(response['name']);
    }});
})();
