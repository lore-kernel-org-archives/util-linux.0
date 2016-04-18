Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:53213 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025AbcDRLv7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 07:51:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1as7iZ-0007qP-DM
	for util-linux@vger.kernel.org; Mon, 18 Apr 2016 13:51:51 +0200
Received: from ppp37-190-56-88.pppoe.spdop.ru ([37.190.56.88])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 13:51:51 +0200
Received: from yumkam by ppp37-190-56-88.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 18 Apr 2016 13:51:51 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: unshare -m and mount propagation
Date: Mon, 18 Apr 2016 14:51:37 +0300
Message-ID: <m3inzfkud2.fsf@gmail.com>
References: <m3oaacfrn2.fsf@gmail.com>
	<20160418111628.cj5bscuuxee2xfcg@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Fri, Mar 18, 2016 at 05:26:25AM +0300, Yuriy M. Kaminskiy wrote:
>> I think this issue should be at least documented. And, maybe, default
>> `--propagation` should be changed to `slave`.
>
> The reason why we use 'private' is that it's the kernel default for
> years and it's what has been expected by users for long time before we
> introduced --propagation and any unshare(1) default.
>
> The current --propagation default unifies things and makes unshare(1) 
> portable to distributions where root fs is mounted as 'shared' (e.g. 
> systemd distros) and all this in backwardly compatible way for users
> who have no clue about --propagation.
>
> So, I don't think we want to change any default to corrupt scripts where
> is no explicitly specified --propagation. 

By you already broke scripts that expected old a-la '--propagation
unchanged' behavior.
E.g. one my script did
   unshare -m sh -c 'mount --make-rslave /; ...'
Now I must check for util-linux version and either use --propagation
option, or mount --make-rslave (you cannot revert back from private to
slave).
(And as I said, 'private' breaks umount propagation and thus very bad for
long-running namespaces).

