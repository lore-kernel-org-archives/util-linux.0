Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140724094454.GJ26781@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
	<1406066459-4816-7-git-send-email-kerolasa@iki.fi>
	<20140724094454.GJ26781@x2.net.home>
Date: Sat, 26 Jul 2014 15:54:13 +0100
Message-ID: <CAG27Bk2j0ozDCp56o2_Tt5bi+yGZ6brnS7Z9O4dKwRbahHWYXQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] logger: add function pointer to choose how logging
 is done
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Kodiak Firesmith <ksf@sei.cmu.edu>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 24 July 2014 10:44, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jul 22, 2014 at 11:00:55PM +0100, Sami Kerola wrote:
>> +     void (*syslogfp)(struct logger_ctl *ctl, char *msg);
>
>  What about to move it to the control struct too?

Oh, I see. Done, and that allows the later main() clean up.

https://github.com/kerolasa/lelux-utiliteetit/commit/4d0dc65a487f7bc24899e622158b604fe95d1c4b

>> +     if (server) {
>> +             ctl.fd = inet_socket(server, port, socket_type);
>> +             syslogfp = syslog_rfc3164;
>> +     } else if (usock) {
>> +             ctl.fd = unix_socket(usock, socket_type);
>> +             syslogfp = syslog_rfc3164;
>> +     } else {
>> +             openlog(ctl.tag ? ctl.tag : xgetlogin(), ctl.logflags, 0);
>> +             syslogfp = syslog_local;
>> +     }
>
> Maybe it would be better to create small functions
>
>   logger_open()
>   logger_log()
>   logger_close()
>
> to keep main() simple and readable and without all the details like
> "if (usock) ...".

Done in new main() clean up commit.

https://github.com/kerolasa/lelux-utiliteetit/commit/bb840ac3eb832f404f470f8933070f228a104b8e

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
