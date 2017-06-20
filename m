Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdFTLPE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jun 2017 07:15:04 -0400
Date: Tue, 20 Jun 2017 13:14:58 +0200
From: Karel Zak <kzak@redhat.com>
To: L A Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Patch: ensure mount & umount are root-owned before setting SUID
 bit
Message-ID: <20170620111458.yumisqle5gp4vrf5@ws.net.home>
References: <5935E44B.8000405@tlinx.org>
 <20170606093607.xrxel4ny4hjoe4iv@ws.net.home>
 <5936B8E5.8050901@tlinx.org>
 <5936C623.4030205@tlinx.org>
 <1496762476.3406840.1000540040.654CDA1A@webmail.messagingengine.com>
 <5936D40E.3040000@tlinx.org>
 <5936E292.4000709@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5936E292.4000709@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 06, 2017 at 10:12:50AM -0700, L A Walsh wrote:
> L A Walsh wrote:
> > 
> > 
> > Maybe the install should check to see
> > if it is root before setting a SUID bit on the executable?
> Maybe this can be applied to source tree sometime before nxt release?
> Won't help if you are running the make as 'root', but at least
> it will flag an error when you try to "make install" it...

Fixed thanks!

    Karel
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
