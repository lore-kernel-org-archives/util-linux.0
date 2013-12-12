Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675Ab3LLQY3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Dec 2013 11:24:29 -0500
Date: Thu, 12 Dec 2013 17:02:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: read only bind mount ignores ready only
Message-ID: <20131212160233.GL16572@x2.net.home>
References: <52A878C5.6050505@ubuntu.com>
 <20131212120544.GJ16572@x2.net.home>
 <52A9CF3E.1040402@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52A9CF3E.1040402@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 12, 2013 at 09:59:10AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/12/2013 7:05 AM, Karel Zak wrote:
> > I have it implemented, so
> > 
> > mount --bind --read-only /mnt /mnt
> > 
> > is interpreted as two requests (two mount(2) calls)
> > 
> > mount --bind /mnt /mnt mount -o remount,bind,ro /tmp
> 
> And mount -o bind,ro is the same right?  So you can set up a ro bind
> mount in fstab?

 Yes, but it is not in the git tree yet (I'd like to wait for Miklos's
 reply).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
