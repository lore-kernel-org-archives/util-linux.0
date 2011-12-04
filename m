Return-Path: util-linux-owner@vger.kernel.org
Received: from gimli.pitney-fabs.co.uk ([87.106.140.52]:35233 "EHLO
	gimli.pitney-fabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab1LDMFy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 Dec 2011 07:05:54 -0500
Received: from host81-139-106-247.in-addr.btopenworld.com ([81.139.106.247] helo=golden.localdomain)
	by gimli.pitney-fabs.co.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <walrond.andrew@gimli.pitney-fabs.co.uk>)
	id 1RXApL-0001Qm-0Q
	for util-linux@vger.kernel.org; Sun, 04 Dec 2011 12:05:51 +0000
Date: Sun, 4 Dec 2011 12:05:49 +0000
From: Andrew Walrond <andrew@walrond.org>
To: util-linux@vger.kernel.org
Subject: Re: agetty problem after upgrading v2.19.1 -> v2.20.1
Message-ID: <20111204120548.GA23245@golden.localdomain>
References: <20111203171658.GA9780@golden.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111203171658.GA9780@golden.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

After reading the following from Andries Brouwer's excellent "The Linux Kernel",
     http://www.win.tue.nl/~aeb/linux/lk/lk-10.html#ss10.3

>
> How does one get a controlling terminal? Nobody knows, this is a great mystery.
>
> The System V approach is that the first tty opened by the process becomes its controlling tty.
>
> The BSD approach is that one has to explicitly call
>
>    ioctl(fd, TIOCSCTTY, ...);
>
> to get a controlling tty.
>
> Linux tries to be compatible with both, as always, and this results in a very obscure complex of conditions. Roughly:
>
> The TIOCSCTTY ioctl will give us a controlling tty, provided that (i) the current process is a session leader, and (ii) it does not yet have a controlling tty, and (iii) maybe the tty should not already control some other session; if it does it is an error if we aren't root, or we steal the tty if we are all-powerful.
>
> Opening some terminal will give us a controlling tty, provided that (i) the current process is a session leader, and (ii) it does not yet have a controlling tty, and (iii) the tty does not already control some other session, and (iv) the open did not have the O_NOCTTY flag, and (v) the tty is not the foreground VT, and (vi) the tty is not the console, and (vii) maybe the tty should not be master or slave pty." 
>

it seems obvious that agetty is always going to fail unless it has already been made a session leader by the caller. Indeed, modifying init to call setsid() before exec'ing agetty makes everything work again.
What's not so obvious to me is whether agetty should always expect this, or become a session leader of it's own accord.

Andrew Walrond
