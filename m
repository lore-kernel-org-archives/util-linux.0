Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20140106123040.GA31045@x2.net.home>
References: <201312222142.44536.vapier@gentoo.org>
	<20140106123040.GA31045@x2.net.home>
Date: Mon, 6 Jan 2014 12:55:08 +0000
Message-ID: <CAG27Bk0wpvkoRxL1G4Yd6AE8J9L6tCZzeeYr6qX_KDn+MCwYew@mail.gmail.com>
Subject: Re: tests: cal/bigyear only works on 64bit (sizeof(long) == 8) systems
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 6 January 2014 12:30, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Dec 22, 2013 at 09:42:43PM -0500, Mike Frysinger wrote:
>> that's a signed long type, so on 32bit systems, you get:
>>           cal: Year 1234567890123456789       ...cal: illegal year value:
>>
>> should the test detect the sizeof(long) and then calculate a number that is
>> smaller than that ?
>
>  It would be better to keep cal(1) arch insensitive.
>
>  Sami, why we need so huge year numbers and why the number is signed?
>  I guess it would be enough to  use "unsigned int" (UINT_MAX is 4294967295).

Hi Mike & Karel,

Year was left signed because someone said it might be interesting to
know pre-year-zero outputs. After a bit research the pre-zero year
calendars are theoretical construct, mostly because agreement in
western world is not more than couple hundred years old. That means
pre-zero calendar could only be considered as a what a modern western
people think the calendar should have looked. Whether that is
valuable, interesting, useful, etc is a different question.

Meanwhile the big year test is clearly broken. I recon there should be
a version for various sizes of INT_MAX tests, and depending how large
values are supported by system corresponding tests are ran.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
