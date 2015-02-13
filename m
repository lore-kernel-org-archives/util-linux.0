Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20150213092131.GM32318@ws.net.home>
References: <54DC88BF.5040702@draigBrady.com>
	<87h9uqv6lv.fsf@hobgoblin.ariadne.com>
	<20150213092131.GM32318@ws.net.home>
Date: Fri, 13 Feb 2015 10:33:23 +0000
Message-ID: <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
        =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigbrady.com>,
        mrmazda@earthlink.net, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On 13 February 2015 at 09:21, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Feb 12, 2015 at 10:21:48PM -0500, Dale R. Worley wrote:
>> I don't particularly like colorization.  But technically, it seems to me
>> that what is needed is a systematic way for the user to indicate his
>> colorization preferences to *all* utilities.  And a corresponding way
>> for the system to provide defaults for those user preferences.
>>
>>
>> Only when there is a systematic framework for colorization will all the
>> programs allow colorizing to be configured.
>
> It would be possible to create a shared library from our lib/colors.c
> to support terminal-colors.d/... :-)

Or add the needed to ncurses. Isn't that better than adding a new
library?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
