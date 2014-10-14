Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44313 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755232AbaJNNLn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 09:11:43 -0400
Date: Tue, 14 Oct 2014 15:11:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Fwd: Bug#764331: mount: "mount --bind -o remount" doesn't
 preserve flags
Message-ID: <20141014131139.GW8057@x2.net.home>
References: <5433bec30004719200003ea0000046dea00002d646a1@amlmta037.auone-net.jp>
 <5433F1AD.6070500@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5433F1AD.6070500@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 07, 2014 at 09:59:09AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> I thought that it had been established that the kernel did not support
> any other flags with MS_BIND, but this bug report seems to show that
> it did, and the new util-linux silently discards the flags.  Is this a
> bug?

 Seems like a bug, I'll try to play with that tomorrow. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
