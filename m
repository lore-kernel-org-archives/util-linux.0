Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42131 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751615AbaJXU6I (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 16:58:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 92D4A20672
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 16:58:07 -0400 (EDT)
Message-Id: <1414184287.962524.183013401.569326CF@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 2/5] hwclock: clean up message periods/full stops
Date: Fri, 24 Oct 2014 22:58:07 +0200
In-Reply-To: <544A795B.8090301@gmx.com>
References: <5449BE57.9040203@gmx.com>
 <1414150431.840372.182833341.74402120@webmail.messagingengine.com>
 <544A4817.3070406@gmx.com> <20141024125939.GD10134@x2.net.home>
 <544A795B.8090301@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 18:07, JWP wrote:
> So what is the util-linux position on message punctuation in general, and
> line termination specifically?  The documentation seem to imply not using any.

The current situation is a mess.  And the documentation does not say
anything about what error messages, status reports, and imperatives
to the user should look like.  The general style seems to be:

1) Error messages (anything that is preceded by the program name
followed by a colon and a space, in thise case "hwclock: ") start with
a lowercase letter and do not end in a period, nor use any period.

2) Status reports and imperatives to the user use full sentences:
they start with a capital letter and end in a period.

So I think the following output is fairly good.

$ ./hwclock --debug
hwclock from util-linux 2.25.379-04c10
hwclock: cannot open /dev/rtc: Permission denied
Using direct I/O instructions to ISA clock.
hwclock: unable to get I/O port access:  the iopl(3) call failed.: Operation not permitted
hwclock: Probably you need root privileges.

The last line should not be preceded by "hwclock" as it's not
an error message.  And "the iopl(3) call failed." should obviously
not end in a period, and it starts with a space too many.

(Also, the phrases "Permission denied" and "Operation not permitted"
should not be capitalized, but they come from libc, so util-linux
cannot do anything about that.)

With line termination you mean the placings of \n?  When they
are needed, to break up a long message, preferably wrap the
text in the program at the same place.

To come back to your patch for a moment:

>  				printf(_("Clock drift factor was calculated as "
> -					 "%f seconds/day.\n"
> -					 "It is far too much. Resetting to zero.\n"),
> +					 "%f seconds/day\n"
> +					 "It is far too much, resetting to zero\n"),
>  				       drift_factor);

This would simply be a wrong change.  Literally your second line
says that resetting to zero is far too much.  When giving status
reports it won't hurt to be very clear, and punctuation is part
of that.  If asked, I would rewrite the above message as:

"The clock drift factor was calculated as %f seconds per day.\n"
"This is far too much.  It has been reset to zero.\n"

Benno

-- 
http://www.fastmail.fm - mmm... Fastmail...

