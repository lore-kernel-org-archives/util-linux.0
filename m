Return-Path: bensberg@justemail.net
Message-Id: <1415049315.2564297.186608257.366970B7@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <54566F88.4040101@gmx.com>
References: <1414444693-16407-1-git-send-email-bensberg@justemail.net>
 <1414444693-16407-4-git-send-email-bensberg@justemail.net>
 <544EECC9.2000300@gmx.com>
 <1414526532.495299.184374637.2BF00A99@webmail.messagingengine.com>
 <20141031095142.GX10134@x2.net.home> <54566F88.4040101@gmx.com>
Subject: Re: [PATCH 4/4] docs: improve wording and formattin of man page of
 hwclock
Date: Mon, 03 Nov 2014 22:15:15 +0100
List-ID: <util-linux.vger.kernel.org>


On Sun, Nov 2, 2014, at 18:53, JWP wrote:
> The first issue seems so trivial as to not justify any debate. I will
> however, expand on my original comment: if there is no grammar rule to
> decide a style choice, then the super-class style rule of 'be consistent'
> should be applied.  I do not find 'because I say so' to be a compelling
> argument.  

Fine.  But as you've said yourself: human language is illogical.  :)

> With regard to the second issue, I suggested 'how exactly to phrase that' 
> when I edited it the first time.

Ah.  When I edited it I didn't realize the v2.26 notes had been changed
after Karel had added them.  And now it took me a moment to realize that
JWP is the same as J William Piggott.  ...  Okay, never mind.

> Unless it can be rewritten in a way that 
> does not change its meaning, I feel it should remain as it is.

Well, there are several problems with your (and also Karels) version
of the text.  First, "automatically".  The word suggests to me that
there is/was a way to do this unautomatically, that is: by the use of
an option.  But is was never possible to make hwclock set the System
Clock to a drift-compensated time without touching the Hardware Clock
nor the adjtime file.  Second, "compensates time [...] to account for".
The expression in English is " to compensate something /for/ a deviance" --
there should be no "to account".  But the interposing of "read from the
Hardware Clock" makes the use of this expression difficult to grasp.
So it's better to rewrite the whole thing.  Third, a "the" is needed
before "time".  Fourth, the "This functionality" referring to --adjust
no longer being necessary during boot is awkward; it's second word
can simply de dropped.

So... my suggestion:

"Since v2.26 hwclock --hctosys does a better job at setting the System Clock:
it no longer simply copies the time from the Hardware Clock to the System Clock,
but it reads the Hardware Clock, applies a compensation for the systematic drift
to this read time, and sets the System Clock to the resulting time.  Thus it is
no longer necessary to run hwclock --adjust before doing hwclock --hctosys, and
therefore hwclock can be used very early on in the boot process when the root
filesystem is still read-only."

Any amendments?

Benno

-- 
http://www.fastmail.fm - Does exactly what it says on the tin
