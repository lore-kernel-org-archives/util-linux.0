Return-Path: util-linux-ng-owner@vger.kernel.org
Received: from mail.seebyte.com ([80.193.213.29]:47821 "EHLO mail.seebyte.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754425Ab0BIRJu (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 9 Feb 2010 12:09:50 -0500
Date: Tue, 9 Feb 2010 17:09:41 +0000
From: Stephane Chazelas <stephane.chazelas@seebyte.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: [mount] --bind -o suid/exec/...
Message-ID: <chaz20100209170941.GA18491@seebyte.com>
References: <chaz20100209152559.GA3693@seebyte.com> <20100209162305.GG6375@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100209162305.GG6375@nb.net.home>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux-ng.vger.kernel.org>

2010-02-09 17:23:05 +0100, Karel Zak:
[...]
> > mount --bind /here /there
> > mount -o remount,noexec /there
[...]
> >, or better, "mount" could
> > be changed so that one can do it in a single step with:
> > 
> > mount --bind -o noexec /here /there
> 
>  this is unsupported by kernel, the "remount" and "bind" are two
>  different operations.
[...]

Thanks Karel,

but what about changing mount(8) so that it does two mount(2)s
upon --bind -o?

One thing I've not mentionned is that it makes it quite awkward
to add it in /etc/fstab.

/here /there none bind 0 0
there-remount /there none remount,noexec 0 0

works with mount -a but not with Ubuntu's mountall(8) for
instance.

Cheers,
Stephane
