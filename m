Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39427 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbcDRMWk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 08:22:40 -0400
Date: Mon, 18 Apr 2016 14:22:38 +0200
From: Karel Zak <kzak@redhat.com>
To: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unshare -m and mount propagation
Message-ID: <20160418122238.o645avvzj2tzzwsd@ws.net.home>
References: <m3oaacfrn2.fsf@gmail.com>
 <20160418111628.cj5bscuuxee2xfcg@ws.net.home>
 <m3inzfkud2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m3inzfkud2.fsf@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 18, 2016 at 02:51:37PM +0300, Yuriy M. Kaminskiy wrote:
> Karel Zak <kzak@redhat.com> writes:
> 
> > On Fri, Mar 18, 2016 at 05:26:25AM +0300, Yuriy M. Kaminskiy wrote:
> >> I think this issue should be at least documented. And, maybe, default
> >> `--propagation` should be changed to `slave`.
> >
> > The reason why we use 'private' is that it's the kernel default for
> > years and it's what has been expected by users for long time before we
> > introduced --propagation and any unshare(1) default.
> >
> > The current --propagation default unifies things and makes unshare(1) 
> > portable to distributions where root fs is mounted as 'shared' (e.g. 
> > systemd distros) and all this in backwardly compatible way for users
> > who have no clue about --propagation.
> >
> > So, I don't think we want to change any default to corrupt scripts where
> > is no explicitly specified --propagation. 
> 
> By you already broke scripts that expected old a-la '--propagation
> unchanged' behavior.

Only if your system uses something else that kernel default 'private'
and you depend on this non-default setting. (IMHO relatively small 
groups of users)

The old "--propagation unchanged" makes unshare useless on some 
mainstream distros where default is 'shared'.

Anyway, we will not change any default now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
