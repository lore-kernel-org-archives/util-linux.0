Return-Path: assafgordon@gmail.com
Date: Tue, 28 Feb 2017 17:01:23 +0000
From: Assaf Gordon <assafgordon@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [V2 0/4] hwclock: remove date(1)
Message-ID: <20170228170122.GA18228@gmail.com>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
 <20170228133713.377klbjm44roizx6@ws.net.home>
 <0d36f495-d691-9e80-9c05-461d3563b468@gmx.com>
 <20170228161000.ijlouecku6a37quk@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170228161000.ijlouecku6a37quk@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

Hello,

On Tue, Feb 28, 2017 at 05:10:00PM +0100, Karel Zak wrote:
>On Tue, Feb 28, 2017 at 10:23:39AM -0500, J William Piggott wrote:
>> My impression is that the original parse_datetime() is stable. It seems
>> like most of the changes now involve parse_datetime2() to expand
>> capabilities.

More specifically: parse_datetime was made it re-entrant (removed 
global timezone  variables) and was added debugging code.
I don't think the parser itself has changed in a long while.

>Fortunately, this stuff is easy to test, so we can create regression
>tests for all the possible formats to be sure we do not introduce any
>regression.

A description of all types of accepted inputs for gnu date
(and techincally: gnulib's parse_datetime) is here:
 https://www.gnu.org/software/coreutils/manual/html_node/Date-input-formats.html

>> > I guess it will be possible to move it to lib/parse-datetime.c and use
>> > it on another places in util-linux (instead of our minimalistic
>> > parse_datetime()), right?
>>
>> Sure, I think a name change to avoid confusion with gnulib would be
>> good. Maybe just parse_date.c?

If you copy the gnulib's parser and adjust it,
I might suggest doing away first with relative times,
then perhaps with timezones.

There are some confusing combinations, especially with
relative times (e.g. "20170228 + 2 days" vs "20:45:45 + 2 days", the 
latter parsed as "8:45:45pm+02:00TZ + 1 day"),
and then with all sorts of things that are taken as timezones (like 
"2017A" which is parsed as '8:17pm in timezone -01:00'.

If you don't want to meddle with the parser (which is understandable),
as a fallback you might want to add a minor piece of code
that ensures any timezone/relative parts were not encountered during the 
parsing.
To do that, I'd add a small check at the end of 'parse_datetime2',
and look at the fields of 'struct parse_control':
http://git.savannah.gnu.org/cgit/gnulib.git/tree/lib/parse-datetime.y#n172

something like:

    if (pc.dsts_seen==0 && pc.rels_seen==0 && pc.zones_seen==0 etc.)

Then the parser didn't encounter these parts.

I'm happy to help with testing if needed.

regards,
 - assaf

P.S.
In fact, I wonder if it'll be easier to add such a flag to gnulib's 
parse_datetime2 , something like 'PARSE_DATETIME_NO_RELATIVE'
and 'PARSE_DATETIME_NO_ZONE' which will reject such input.
