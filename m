Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:52514 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932781Ab1KIAJ2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Nov 2011 19:09:28 -0500
Subject: Re: behavior of "# mount /dev"
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: KIMURA Masaru <hiyuh.root@gmail.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <CAPYQg32qP3Xb_gS45Md6ArqJGx22xZUdCg-W4z5f1ji2id7aSA@mail.gmail.com>
References: <CAPYQg32qP3Xb_gS45Md6ArqJGx22xZUdCg-W4z5f1ji2id7aSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Nov 2011 01:09:24 +0100
Message-ID: <1320797364.3005.10.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-11-08 at 17:01 +0900, KIMURA Masaru wrote:
> Hi,
> 
> A user continues to mumble about behavior of "# mount /dev" in this list [1].
> He said, he did accidentally type
> 
>  # mount /dev

This will fail since /dev is immediately mounted and populated at boot
time (by udev among others).

> 
> and "ls /dev" shows only initctl under /dev.
> 
> "man mount" said,
> 
>        If only directory or device is given, for example:
> 
>               mount /dir
> 
>        then mount looks for a mountpoint and if not found then for a
> device in the /etc/fstab file.
> 
> so I guess this is an undocumented behavior.
> 
> Naohiro Aota explains that this is expected tmpfs' behavior in kernel. [2]

A whole lot of processes expect /dev/shm to be present; but mount(8)'s
relationship with tmpfs is no different than with any other linux
filesystem.

> And I think "just don't do such thing."
> But this user still doesn't accept this undocumented mount  behavior.
> 
> any thought?

All in all I'm not sure I follow this problem and Google translate isn't
helping much either. What is very strange is that /dev is not mounted at
startup, and the user should address *that* issue instead of manually
mounting /dev.

> 
> [1] http://ml.gentoo.gr.jp/users/201111.month/2194.html
> [2] http://ml.gentoo.gr.jp/users/201111.month/2195.html
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


