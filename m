Return-Path: assafgordon@gmail.com
Date: Fri, 10 Feb 2017 21:38:00 +0000
From: Assaf Gordon <assafgordon@gmail.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] hwclock: use gnulib's parse_datetime2 function
Message-ID: <20170210213759.GD24787@gmail.com>
References: <bbd64daa-5431-8c7d-580b-3382a33edccd@gmx.com>
 <621b8782-5b62-d07c-c81f-3cfcfbeef8ae@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <621b8782-5b62-d07c-c81f-3cfcfbeef8ae@gmx.com>
List-ID: <util-linux.vger.kernel.org>

Hello William,

two minor suggestions:

On Fri, Feb 10, 2017 at 04:08:20PM -0500, J William Piggott wrote:

>+	if (parse_datetime2 (&when, ctl.date_opt, NULL, ctl.debug))

1.
The 'flags' parameter in parse_datetime2 should be
considered as a bit-field, not a boolean.

It's true that in parse-datetime.h [1] the only
existing flag is the debug flag with a value of one,
but we made it so that other future flags are also possible
[2]. I believe 'ctl.debug' is treated like a boolean.

[1] 
http://git.savannah.gnu.org/cgit/gnulib.git/tree/lib/parse-datetime.h
[2]
https://lists.gnu.org/archive/html/bug-gnulib/2016-08/msg00024.html


BTW,
Turning on the debug flag for parse_datetime2 will emit
the parsing steps to STDERR, which will look like so:
https://lists.gnu.org/archive/html/bug-gnulib/2016-08/msg00019.html
(might be good for util-linux, or might be an overkill).


2.
The latest version of 'parse_datetime2' function takes 6 parameters,
not just 4. The extra 2 are timezone specific values.
Added here:
http://git.savannah.gnu.org/cgit/gnulib.git/commit/lib?id=4e6e16b3f43ce


regards,
 - assaf
