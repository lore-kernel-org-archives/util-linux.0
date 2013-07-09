Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47329 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab3GIJIy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Jul 2013 05:08:54 -0400
Date: Tue, 9 Jul 2013 11:08:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, ebiederm@xmission.com, mtk.manpages@gmail.com
Subject: Re: [PATCH/RFC] unshare: add --fork/--mount-proc options for pid
 namespaces
Message-ID: <20130709090850.GA24716@x2.net.home>
References: <1372377898-2602-1-git-send-email-vapier@gentoo.org>
 <201307011047.05595.vapier@gentoo.org>
 <20130703103635.GA722@x2.net.home>
 <201307031308.31557.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201307031308.31557.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 03, 2013 at 01:08:30PM -0400, Mike Frysinger wrote:
> i'm not familiar with that flag as it's 
> not in the mount(2) man page (looks like it's listed as a TODO).

 the flag is used for mount --make-private, 

 http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/filesystems/sharedsubtree.txt

> Acked-by: Mike Frysinger <vapier@gentoo.or>

 Merged, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
