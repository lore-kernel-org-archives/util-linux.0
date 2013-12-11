Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab3LKQEJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Dec 2013 11:04:09 -0500
Date: Wed, 11 Dec 2013 17:03:59 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Czerner <lczerner@redhat.com>,
        Sten Heinze <shze@gmx.de>, util-linux@vger.kernel.org
Subject: Re: Automatic SSD trim script
Message-ID: <20131211160359.GB16572@x2.net.home>
References: <trinity-43b508b8-bb14-4ad1-81b0-a22e3bd084b4-1386271207144@3capp-gmx-bs30>
 <20131206104944.GE16891@x2.net.home>
 <alpine.LFD.2.00.1312091438300.2143@localhost.localdomain>
 <20131210154442.GC8419@x2.net.home>
 <52A8444F.2040904@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52A8444F.2040904@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 11, 2013 at 10:54:07AM +0000, Pádraig Brady wrote:
> If this was common it might be worth avoiding processing the same entry multiple times.

 Implemented. I have also added --uniq to findmnt, so you will see your
 /home only once :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
