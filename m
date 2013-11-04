Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52465 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab3KDK3g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 05:29:36 -0500
Date: Mon, 4 Nov 2013 11:29:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: /proc/mounts doesn't store bind flag
Message-ID: <20131104102932.GF23604@x2.net.home>
References: <5273DCB6.4020909@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5273DCB6.4020909@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 01, 2013 at 12:54:14PM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> When symlinking /etc/mtab to /proc/mounts, bind mounts no longer have
> the bind option stored.  Is this a bug or working as intended?

 This is expected thing. All utils that expect "bind" flag are broken.

 There is nothing like "bind" mountpoint (and kernel does not maintain
 such information at all), all mountpoints are equal, there is nothing
 like a primary (original) mountpoint. 
 
 You have to think about it as about hardlinks for files. The bind 
 operation creates just another path to the filesystem. That's all.

  mount /dev/sda1 /A
  mount --bind /A /B
  umount /A

 then /B is still valid (BTW, this is impossible to describe in
 the traditional /etc/mtab where was always relation between 
 /A and /B).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
