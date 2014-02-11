Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48863 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbaBKJac (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Feb 2014 04:30:32 -0500
Date: Tue, 11 Feb 2014 10:30:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Can't unmount broken nfs mount
Message-ID: <20140211093027.GU8506@x2.net.home>
References: <52F95FD1.5090305@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F95FD1.5090305@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 10, 2014 at 06:25:05PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Forwarding from debian bug #711183:
> 
> User reports that a broken nfs mount has its mounted directory in
> /proc/mounts renamed from /foo to /foo\040(deleted) when an nfs mount
> is broken due to an unreachable server, and this prevents unmounting
> it since umount can not find "/foo" in /proc/mounts.  Is this a kernel
> bug, or something that umount needs to work around?

 I don't think this is a kernel bug, we already support "(deleted)" for
 /proc/swaps in libmount. All we need is to improve  libmount/src/tab_parse.c 
 to supports this suffix in mount tables too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
