Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout04.t-online.de ([194.25.134.18]:39023 "EHLO
	mailout04.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3ETJB2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 May 2013 05:01:28 -0400
Date: 20 May 2013 10:03:00 +0200
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CXE+rHTuCXB@helmut.hullen.de>
In-Reply-To: <5198086A.1010903@tlinx.org>
Subject: Re: new mount is broken w/regard to devnames in /etc/fstab
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Linda,

Du meintest am 18.05.13:



> There are 2 problems -- they are unlikely to be
> directly related, but are in so much as they are in the new version
> of mount.

> 1) How is one supposed to get the real root device?
> It's not /dev/root -- and on my system /dev/root doesn't even exist.
> (though to be fair, it has in the past -- udev musta got sloppy this
> time, and did point to the real root device).  But how can I get
> /proc to display the real root device instead of some fake name.

        rdev

should do the job.

Viele Gruesse!
Helmut
