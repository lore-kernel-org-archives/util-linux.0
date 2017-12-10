Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f196.google.com ([209.85.223.196]:37065 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdLJKyN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 10 Dec 2017 05:54:13 -0500
Received: by mail-io0-f196.google.com with SMTP id d16so6721104iob.4
        for <util-linux@vger.kernel.org>; Sun, 10 Dec 2017 02:54:13 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20171209012937.GA27446@altlinux.org>
References: <20171203125117.28159-1-kerolasa@iki.fi> <20171203125117.28159-3-kerolasa@iki.fi>
 <20171204120404.aa4p6p2o3goupsq3@ws.net.home> <CAG27Bk3ScbYMxT3xi8x6tmx6map3_gRbddbU1p9nN=k3NJQMuQ@mail.gmail.com>
 <20171209012937.GA27446@altlinux.org>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 10 Dec 2017 10:54:11 +0000
Message-ID: <CAG27Bk18wEs=ryrt_dY34HqkV26YzHjEC13ykrLbtgn7Pmt3Zw@mail.gmail.com>
Subject: Re: [PATCH 3/4] docs: improve setarch(8) manual page
To: Sami Kerola <kerolasa@iki.fi>, Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 December 2017 at 01:29, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Mon, Dec 04, 2017 at 01:20:01PM +0000, Sami Kerola wrote:
>> On 4 December 2017 at 12:04, Karel Zak wrote:
>> > On Sun, Dec 03, 2017 at 12:51:16PM +0000, Sami Kerola wrote:
> [...]
>> >>  \fB\-\-4gb\fR
>> >> -Ignored (for backward compatibility only).
>> >> +Ignored for backward compatibility only.
>> >
>> > Dmitry is right, the old version is better.
>>
>> How about text:
>>
>> This option is no-op compatibility with an old Debian setarch
>> implementation. Please do not use.
>
> Let's add a description that is informative but without giving advice.
> For example,
>
> "This option has no effect.  It is retained for backward compatibility only,
> and may be removed in future releases."

Hi Dmitry,

Your text is better. Added to most recent version of this change:

https://github.com/kerolasa/lelux-utiliteetit/commit/e9ebe4c52755edc736b2c440c8dc3b93678e69d1

>> >> +This makes
>> >> +.BR select (2),
>> >> +.BR pselect (2),
>> >> +and
>> >> +.BR ppoll (2)
>> >> +system calls preserve the timeout value instead of storing the unslept time
>> >> +when interrupted by a signal handler.  Use when
>> >> +.I program
>> >> +depends on this behavior, and the source code is not available to be fixed.
>> >
>> > See Dmitry's note ;-)
>>
>> How about this:
>>
>> -- snip
>> This makes
>> .BR select (2),
>> .BR pselect (2),
>> and
>> .BR ppoll (2)
>> system calls preserve the timeout value instead of storing the unslept time
>
> I'm not sure about "unslept time" phrase.  Wouldn't a more formal
> description be better, .e.g.
>
> This makes
> ...
> system calls preserve the timeout value instead of modifying it to reflect
> the amount of time not slept when interrupted by a signal handler.
> ...

That is better. Used in the most recent update.

>> when interrupted by a signal handler. Use when
>> .I program
>> depends on this behavior. For more details see the timeout description from
>
> s/from/in/

Fixed.

>> .BR select (2)
>> manual page. Turns on STICKY_TIMEOUTS.
>> -- snip
>
> On the whole, this looks much better.
>
>> My remote git has the latest.
>>
>> https://github.com/kerolasa/lelux-utiliteetit/blob/2017wk48/sys-utils/setarch.8
>>
>> And that branch also has FIXME item near FDPIC_FUNCPTRS description.
>> Proposal(s) welcome how to make that text understandable.
>
> What about this text:
>
> "Treat user-space function pointers to signal handlers as pointers
> to address descriptors.  This option has no effect on architectures
> that do not support FDPIC ELF binaries.  Turns on FDPIC_FUNCPTRS."

Used almost as-is. I included list of architectures that are expected to
work with a recent kernel version.

If no further objections. Karel could you have final review and merge
from my remote branch 2017wk48.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
