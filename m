Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout1.mk-netzdienste.de ([85.220.139.132]:42679 "EHLO
	mailout1.mk-netzdienste.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751083AbaIJA54 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Sep 2014 20:57:56 -0400
Received: from aktivanet.de (ip4d15c93d.dynamic.kabel-deutschland.de [77.21.201.61])
	by mailout1.mk-netzdienste.de (Postfix) with ESMTPSA id 7663923EF7E
	for <util-linux@vger.kernel.org>; Sun,  7 Sep 2014 22:21:27 +0200 (CEST)
Date: Sun, 7 Sep 2014 22:13:00 +0200
From: "Helmut Hullen" <hhullen@aktivanet.de>
To: util-linux@vger.kernel.org
In-Reply-To: <540CA199.8070307@gmail.com>
Subject: Re: mount error message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Message-ID: <D0PbA82ReQB@helmut.hullen.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Bruce,

Du meintest am 07.09.14:

> I have a user that complains that mount is giving an incorrect error
> message under some circumstances.  For instance if mtab is symlinked
> to /proc/self/mounts the command and /run is not in fstab:

> $ mount /run

> returns an error message:

>    mount: /run: No such file or directory

> However if mtab is a regular file, the error message is:

>    mount: can't find /run in /etc/fstab

> It would be appropriate if both situations could return the 2nd
> message.

There's no need to put the device into a special line in "/etc/fstab".

        mount /dev/sdxn /run

should always work, with the appropriate values for x and n.

Viele Gruesse!
Helmut

