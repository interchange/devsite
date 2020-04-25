$(document).ready(function() {
    const months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
    ];

    $.ajax({
        url: 'https://api.github.com/repos/interchange/interchange/commits',
        success: function(result) {
            console.log(result);
            result
                .filter(commit => commit.parents.length < 2)
                .slice(0, 7).forEach(commit => {
                    const elem = $(
                        '<li class=""></li>'
                    );
                    const link = $('<a></a>', {
                        href: commit.html_url
                    });
                    link.text(commit.commit.message.split('\n')[0]);
                    elem.appendTo('#commits-list');
                    elem.append(link);

                    const info = $('<p></p>');

                    const author = $('<a></a>', {
                        href: commit.author.html_url
                    });
                    author.text(commit.author.login);

                    const date = new Date(commit.commit.committer.date);
                    info.text(' committed on ' + months[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear());
                    info.prepend(author);
                    elem.append(info);
                });
        },
        error: function(result) {
            console.log(result);
            $('#commits-list').append('<li>Unable to fetch recent commits.</li>');
        }
    });
});
