Return-Path: dsd.olpc@gmail.com
MIME-Version: 1.0
Sender: dsd.olpc@gmail.com
In-Reply-To: <20110725090624.GU22568@nb.net.home>
References: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com>
	<20110724195713.GH3469@thunk.org>
	<20110725090624.GU22568@nb.net.home>
Date: Mon, 25 Jul 2011 10:20:55 +0100
Message-ID: <CAGq3pz4PH-MK5+AgBTnq03atWUxMEdVreUtoVeqrkOkcc+8DZQ@mail.gmail.com>
Subject: Re: Can't remount loopback ext4 without /etc/mtab
From: Daniel Drake <dsd@laptop.org>
To: Karel Zak <kzak@redhat.com>
Cc: "Ted Ts'o" <tytso@mit.edu>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On 25 July 2011 10:06, Karel Zak <kzak@redhat.com> wrote:
> =A0mount(8) "bug"
>
> =A0The kernel does not accept any SELinux specific mount options for
> =A0MS_REMOUNT. We already have exception for this in mount(8) ... and I
> =A0hate it, but our SELunux kernel guys are happy with this strange
> =A0behavior:
>
> =A0https://bugzilla.redhat.com/show_bug.cgi?id=3D563267#c9

That view might have changed, I found these commits:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3Dff36fe2c845cab2102e4826c1ffa0a6ebf487c65
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3D026eb167ae77244458fa4b4b9fc171209c079ba7
(from https://bugzilla.redhat.com/show_bug.cgi?id=3D676630 )

I'm going to test them against F15 kernel later today.

Thanks,
Daniel
