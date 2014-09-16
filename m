Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbaIPNgR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Sep 2014 09:36:17 -0400
Date: Tue, 16 Sep 2014 15:36:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Dylan Cali <calid1984@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: mount error message
Message-ID: <20140916133612.GH7867@x2.net.home>
References: <540CA199.8070307@gmail.com>
 <20140910084732.GN21325@x2.net.home>
 <loom.20140911T034049-77@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <loom.20140911T034049-77@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 11, 2014 at 01:52:44AM +0000, Dylan Cali wrote:
> Hello I'm the user in question.  The specific situation was a boot time
> failure where /proc had failed to mount.  So to enumerate the conditions and
> the result:
> 
> 1) /proc is not mounted (or has failed to mount)
> 2) /etc/mtab is a symlink to /proc/mounts (or /proc/self/mounts)
> 3) /run is not in /etc/fstab
> 4) The directory /run exists on the filesystem

Very special use-case :-)

> In this situation 'mount /run' results in: 
> mount: /run: mount failed: No such file or directory
> 
> Obviously mount is referring to /etc/mtab not existing, so the error message
> at present is misleading.

Fixed in master branch. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
