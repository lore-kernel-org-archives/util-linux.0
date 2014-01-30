Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbaA3IQz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 30 Jan 2014 03:16:55 -0500
Date: Thu, 30 Jan 2014 09:16:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
Message-ID: <20140130081651.GE22884@x2.net.home>
References: <52E91888.4080601@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52E91888.4080601@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 29, 2014 at 10:04:40AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I could have sworn that the pivot_root syscall was considered a
> fragile dirty hack that needed to die in a fire, and everyone switched

 everyone switched to our switch_root :-)

> to run-init years ago.  Am I misremembering things or does anyone know
> what I'm talking about?

 Well, I still see that people use pivot_root.

 Anyway, I don't see any info about pivot_root syscall deprecation in
 Linux kernel source tree.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
