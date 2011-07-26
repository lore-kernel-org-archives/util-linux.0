Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110726142212.GB14764@nb.net.home>
References: <CAG27Bk0EkOe=dbt88PFtDKwyo9+0mZPaysVh0eM9BjWu4X8+vQ@mail.gmail.com>
	<20110726142212.GB14764@nb.net.home>
Date: Tue, 26 Jul 2011 18:38:26 +0200
Message-ID: <CAG27Bk3x9Oab431BM-+AnjQHYc5cwuDeho3ufzz46PpN_uJ5=Q@mail.gmail.com>
Subject: Re: [git pull] hwclock fixes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 26, 2011 at 16:22, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jul 26, 2011 at 12:42:46AM +0200, Sami Kerola wrote:
>> are available in the git repository at:
>> =A0 https://github.com/kerolasa/lelux-utiliteetit hwclock
>> =A0 =A0 =A0 hwclock: include-what-you-use header check
>
> =A0Hmm.. I see something completely different in the patch:
>
> =A0 =A0Showing 5 changed files with 171 additions and 216 deletions.
>
> =A0it seems like "use libc error facilities".

Do'h. One of my rebase fix something etc had lead to accidental
squash. The commit is split to two as it was meant to be.

>> =A0 =A0 =A0 hwclock: remove inb & outb functions
>
> Are you really sure? I think it depends on the header files, for
> example it seems GNU Hurd reads information from cmos
>
> http://www.spinics.net/lists/util-linux-ng/msg04179.html
>
> and we already talked about it:
>
> http://www.spinics.net/lists/util-linux-ng/index.html#04673

I did not study history well enough before proposing this. The commit
is thrown away.

>> =A0 =A0 =A0 hwclock: fix compiler warnings
>
> This is wrong for __alpha__ code where the variables are used.
>
> Move the comment before the function and the begin of the function to
> the #ifndef __alpha_ block, then you can use __unused__ for non-aplha
> only.

I changed the commit to have complete functions in precompiler if
statements. To me it looks most readable way of doing what you seem to
mean.

>> =A0 =A0 =A0 hwclock: move long options away from global scope
>
> But the enum {} does not have to be in the main().

Moved to the beginning of the file.

All is pushed to my repo with force. Let me know if there is something
other that needs nudging.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
