Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:13849 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945999AbWLVJG7 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 04:06:59 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2915698uga
        for <util-linux-ng@vger.kernel.org>; Fri, 22 Dec 2006 01:06:58 -0800 (PST)
Message-ID: <787b0d920612220106g20809381ge4800f3524a21da8@mail.gmail.com>
Date: Fri, 22 Dec 2006 04:06:57 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Bryan Henderson" <bryanh@giraffe-data.com>
Subject: Re: splitting util-linux (was: kill)
Cc: kzak@redhat.com, ethanol@armory.com, ams@gnu.org, P@draigbrady.com,
        util-linux-ng@vger.kernel.org
In-Reply-To: <60569.bryanh@giraffe-data.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <45890A78.1030105@draigBrady.com>
	 <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz>
	 <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com>
	 <20061221215312.GP5971@petra.dvoda.cz>
	 <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
	 <60569.bryanh@giraffe-data.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 Dec 2006 07:13:47 +0000, Bryan Henderson <bryanh@giraffe-data.com> wrote:
> >I see rdev. If I remember right, that's used for the pre-2.6 kernels
> >when you use "dd" to put a raw kernel image on a floppy.
>
> Yeah, that's classic Unix.  I don't think it was ever actually used
> much for floppy disks, because you can also just put a filesystem and
> LILO on a floppy; that's what I've always done.  I didn't know they
> eliminated the integrated boot loader in 2.6.

My memory of rdev is dim, but I sure do remember putting the kernel
right on the floppy.

The compressed kernel was less than 400 kB.
That allowed for a compressed RAM disk of 1 MB.
I'd place the compressed RAM disk image at an
offset of 400 kB, then somehow indicate this to
the kernel. Maybe it was in the header, but maybe
it was a compile option.

None of this busybox nonsense of course... just
grab regular stuff from /bin and /lib, any file from /etc
that wasn't obviously useless, a real /dev... but then
along came big bad libc 6.

Anyway... this stuff is no longer useful at all.
