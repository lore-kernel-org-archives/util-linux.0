Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20353 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753464Ab3JRL5L (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Oct 2013 07:57:11 -0400
Date: Fri, 18 Oct 2013 13:57:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid doesn't find lvm pv when boot loader installed
Message-ID: <20131018115707.GD15115@x2.net.home>
References: <525821B6.9010304@ubuntu.com>
 <20131014135953.GG28914@x2.net.home>
 <525C0743.9020706@ubuntu.com>
 <20131018093617.GC15115@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131018093617.GC15115@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 18, 2013 at 11:36:17AM +0200, Karel Zak wrote:
>  Now when I'm thinking about it ... maybe it would be good idea to add
>  to fdisk a warning to inform users that there is not only the new 
>  partition table but also anything else.

 implemented in libfdisk branch on github

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
