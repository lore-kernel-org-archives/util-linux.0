Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout.teamix.de ([194.150.191.118]:49662 "EHLO
	mailout.teamix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbFIInt convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 9 Jun 2015 04:43:49 -0400
Received: from exchange01.nbg.teamix.net (unknown [IPv6:2001:67c:14c:64:306c:b60d:93de:8b04])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by mailout.teamix.de (Postfix) with ESMTPS id 9DBEF382BB
	for <util-linux@vger.kernel.org>; Tue,  9 Jun 2015 10:38:04 +0200 (CEST)
Received: from merkaba.localnet (p549FCABB.dip0.t-ipconnect.de
 [84.159.202.187])	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by rproxy.teamix.net (Postfix) with ESMTPSA
 id 3CE8C7A0AA	for <util-linux@vger.kernel.org>; Tue,  9 Jun 2015 10:37:47
 +0200 (CEST)
From: Martin Steigerwald <ms@teamix.de>
To: <util-linux@vger.kernel.org>
Subject: chrt: inconsistency in --help
Date: Tue, 9 Jun 2015 10:37:46 +0200
Message-ID: <716925135.onXIMLDpa0@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

﻿Hi!

In wheezy I have (util-linux 2.20.1-5.3):

somehost:~$ chrt --help

chrt - manipulate real-time attributes of a process

Set policy:
  chrt [options] <policy> <priority> {<pid> | <command> [<arg> ...]}

Get policy:
  chrt [options] {<pid> | <command> [<arg> ...]}


And this works for a PID if I place "-p" with the options. Like this:

chrt -p -i 0 $$
chrt -pi 0 $$
chrt -i -p 0 $$
chrt -ip 0 $$


In Jessie I have(util-linux 2.25.2-6):

somehost:~$ chrt --help

chrt - manipulate real-time attributes of a process

Set policy:
  chrt [options] [<policy>] <priority> [-p <pid> | <command> [<arg>...]]

Get policy:
  chrt [options] -p <pid>


And this doesn´t work:

chrt -i 0 -p $$
chrt: failed to execute -p: No such file or directory


Suggestion:

1) Either make chrt command parsing more flexible (preffered)

2) or or even and change set policy to

Set policy:
  chrt [options] [-p] [<policy>] <priority> [<pid> | <command> [<arg>...]]


But well second option separates -p from pid. So maybe option 1 is the way 
to go.

What do you think?

Ciao,

-- 
Martin Steigerwald  | Consultant / Trainer

teamix GmbH
Südwestpark 43
90449 Nürnberg

Tel.:  +49 911 30999 55 | Fax: +49 911 30999 99
mail: martin.steigerwald@teamix.de | web:  http://www.teamix.de | blog: http://blog.teamix.de

Amtsgericht Nürnberg, HRB 18320 | Geschäftsführer: Oliver Kügow, Richard Müller

***Nicht verpassen: NSX Roadshow "Optimierte Sicherheit für das moderne Rechenzentrum - Sicherheit im Wandel" mit teamix, TrendMicro und VMware***
Nürnberg 18.06. | München 02.07. | Frankfurt 16.07. | Stuttgart 23.07.

Jetzt anmelden: www.teamix.de/nsx-roadshow

