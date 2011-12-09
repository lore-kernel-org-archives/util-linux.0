Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35371 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab1LIMsj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Dec 2011 07:48:39 -0500
Date: Fri, 9 Dec 2011 13:48:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Mount -a and bind mounts. Bug?
Message-ID: <20111209124837.GA7960@nb.net.home>
References: <20111209123357.GA3173@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111209123357.GA3173@golden.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 09, 2011 at 12:33:58PM +0000, Andrew Walrond wrote:
> When using bind mounts, particularly when they are specified in
> /etc/fstab, 'mount -a' does not recognise that a mount is already
> mounted and will rebind another copy over the top with each mount
> -a.
> 
> Is this the expected behaviour? I'm not sure so I thought I'd ask.
> I'm using v2.20.1.

 - distro?
 - linked with libmount?
 - do you have regular mtab or symlink to /proc/mounts
 
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
