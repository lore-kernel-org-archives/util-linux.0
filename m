Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20171204120404.aa4p6p2o3goupsq3@ws.net.home>
References: <20171203125117.28159-1-kerolasa@iki.fi> <20171203125117.28159-3-kerolasa@iki.fi>
 <20171204120404.aa4p6p2o3goupsq3@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 4 Dec 2017 13:20:01 +0000
Message-ID: <CAG27Bk3ScbYMxT3xi8x6tmx6map3_gRbddbU1p9nN=k3NJQMuQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] docs: improve setarch(8) manual page
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

On 4 December 2017 at 12:04, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Dec 03, 2017 at 12:51:16PM +0000, Sami Kerola wrote:
>>  \fB\-3\fR, \fB\-\-3gb\fR
>> -Specifies that processes should use a maximum of 3GB of address space on systems where it is supported (ADDR_LIMIT_3GB).
>> +Specifies
>> +.I program
>> +should use a maximum of 3GB of address space.  Supported on x86 (as of
>> +2017-12-02).  Turns on ADDR_LIMIT_3GB.
>
> What is the magic day 2017-12-02 ?
>
> Frankly, I don't like dates in docs. It's better to use versions
> "since util-linux v2.31" or "since Linux v4.32", etc.

Fair enough. I will figure out how to make this better.

>>  \fB\-\-4gb\fR
>> -Ignored (for backward compatibility only).
>> +Ignored for backward compatibility only.
>
> Dmitry is right, the old version is better.

How about text:

This option is no-op compatibility with an old Debian setarch
implementation. Please do not use.

>> +This makes
>> +.BR select (2),
>> +.BR pselect (2),
>> +and
>> +.BR ppoll (2)
>> +system calls preserve the timeout value instead of storing the unslept time
>> +when interrupted by a signal handler.  Use when
>> +.I program
>> +depends on this behavior, and the source code is not available to be fixed.
>
> See Dmitry's note ;-)

How about this:

-- snip
This makes
.BR select (2),
.BR pselect (2),
and
.BR ppoll (2)
system calls preserve the timeout value instead of storing the unslept time
when interrupted by a signal handler. Use when
.I program
depends on this behavior. For more details see the timeout description from
.BR select (2)
manual page. Turns on STICKY_TIMEOUTS.
-- snip

My remote git has the latest.

https://github.com/kerolasa/lelux-utiliteetit/blob/2017wk48/sys-utils/setarch.8

And that branch also has FIXME item near FDPIC_FUNCPTRS description.
Proposal(s) welcome how to make that text understandable.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
