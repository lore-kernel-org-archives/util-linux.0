Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28714 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab1GTMsc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jul 2011 08:48:32 -0400
Date: Wed, 20 Jul 2011 14:48:26 +0200
From: Karel Zak <kzak@redhat.com>
To: "corentin.labbe" <corentin.labbe@geomatys.fr>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg.c: print human readable timestamp
Message-ID: <20110720124826.GA22568@nb.net.home>
References: <4DD6593D.2090202@geomatys.fr> <20110629145957.GM6418@nb.net.home> <4E2449B6.1070105@geomatys.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E2449B6.1070105@geomatys.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2011 at 04:56:54PM +0200, corentin.labbe wrote:
> Perhaps we could keep my patch and add a warning about "problem with
> suspend/resume" (both at first line when -H is used and in
> manpages).  Like "Warning timestamp could be inaccurate if you have
> used SUSPEND/RESUME"

 I agree.

> If you are agree with that I will update my patch accordingly.

 I have already added this feature to the code.

 The latest dmesg(1) changes:

  * -T, --ctime       : print human readable timestamps

[Mon Jul 18 22:30:51 2011] Bluetooth: L2CAP ver 2.15
[Mon Jul 18 22:30:51 2011] Bluetooth: L2CAP socket layer initialized
[Mon Jul 18 22:30:51 2011] Bluetooth: BNEP (Ethernet Emulation) ver 1.3


  * -d, --show-delta  : display the time spent between messages.
                       (based on kernel scripts/show_delat).

[   37.727490 <    0.157379>] Bluetooth: L2CAP ver 2.15
[   37.729090 <    0.001600>] Bluetooth: L2CAP socket layer initialized
[   37.964308 <    0.235218>] Bluetooth: BNEP (Ethernet Emulation) ver 1.3


 It's possible to mix the options (dmesg -d -T):

[Mon Jul 18 22:30:51 2011 <    0.157379>] Bluetooth: L2CAP ver 2.15
[Mon Jul 18 22:30:51 2011 <    0.001600>] Bluetooth: L2CAP socket layer initialized
[Mon Jul 18 22:30:51 2011 <    0.235218>] Bluetooth: BNEP (Ethernet Emulation) ver 1.3


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
