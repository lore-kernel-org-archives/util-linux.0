Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout07.t-online.de ([194.25.134.83]:35614 "EHLO
	mailout07.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab3EUCfg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 May 2013 22:35:36 -0400
Date: 21 May 2013 04:28:00 +0200
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <CXJ1$W69CXB@helmut.hullen.de>
In-Reply-To: <5198086A.1010903@tlinx.org>
Subject: Re: new mount is broken w/regard to devnames in /etc/fstab
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Linda,

Du meintest am 18.05.13:

> 1) How is one supposed to get the real root device?

        rdev

> It's not /dev/root -- and on my system /dev/root doesn't even exist.
> (though to be fair, it has in the past -- udev musta got sloppy this
> time, and did point to the real root device).

My system doesn't use "udev", it has no "/dev/root" entry, and it shows  
since some (few) years "/dev/root" when I invoke "df". No problem.

Viele Gruesse!
Helmut
