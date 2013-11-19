Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10321 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab3KSMQt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 07:16:49 -0500
Date: Tue, 19 Nov 2013 13:16:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: cfdisk trips on out of order logical partitions
Message-ID: <20131119121646.GF5572@x2.net.home>
References: <52851A42.7090401@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52851A42.7090401@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 14, 2013 at 01:45:22PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> cfdisk's partition parsing logic is flawed in that it assumes they are
> in order, so if you have out of order partitions it complains that
> they overlap.

 I currently don't plan to fix anything in cfdisk and sfdisk. I'd like
 to rewrite the code to use libfdisk to share code between all the
 fdisks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
