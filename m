Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:63464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752134Ab1F2JMx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jun 2011 05:12:53 -0400
Date: Wed, 29 Jun 2011 11:12:50 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH] umount: do not hang with disconnected NFS mounts
Message-ID: <20110629091250.GG6418@nb.net.home>
References: <20110629082408.GA27888@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110629082408.GA27888@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 29, 2011 at 10:24:09AM +0200, Petr Uzel wrote:
> Since util-linux commit f4612577c942a3683b97632ad0b49671897c2070,
> umount stat(2)s its argument to check whether it can be associated
> with some loop device. This could hang with broken NFS mounts.
> 
> Fix by first checking mtab if umount's argument is mounted and only if
> we fail, check if there is a loop device associated.
> 
> http://marc.info/?l=util-linux-ng&m=130924963804836&w=2
> 
> Reported-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  mount/umount.c |   42 ++++++++++++++++++++++--------------------
>  1 files changed, 22 insertions(+), 20 deletions(-)

 Applied, thanks (also to Konstantin)!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
