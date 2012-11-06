Return-Path: util-linux-owner@vger.kernel.org
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:35877 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab2KFPGw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Nov 2012 10:06:52 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 1821377C425
	for <util-linux@vger.kernel.org>; Tue,  6 Nov 2012 16:06:48 +0100 (CET)
Message-ID: <1352214367.5099275f85792@imp.free.fr>
Date: Tue, 06 Nov 2012 16:06:07 +0100
From: mp.lists@free.fr
To: util-linux@vger.kernel.org
Subject: Accessibility of swap files
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi *,

I think, measures can|should be taken, which reduce the probability of having a
swap file inadvertently run with too open permissions.

As a first idea, it looks, as if such may be implemented, eg. by
     letting swapon [and fstab-based "mounting"] by default not enable a swap
file, if it has non-root access permissions
  || letting mkswap by default ignore too open settings of umask and create the
swap file mod 0600 instead
.
In both cases, an explicit switch|parameter could enable the present,
non-restrictive behaviour.


Best regards,

   Markus


PS: I'm speaking as of util-linux-ng version 2.17.2.
