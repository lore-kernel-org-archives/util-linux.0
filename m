Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:34821 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753848Ab1GVKVL convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Jul 2011 06:21:11 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Date: Fri, 22 Jul 2011 12:21:08 +0200
Subject: RE: ionice: requires scheduling since
	7ab08ba3e5e6f161b93ff2b3b7d5b18dc7b44510
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3B4F@MCHP058A.global-ad.net>
References: <7856072A9D04C24B82DFE2B1112FE38A08FE2D3A66@MCHP058A.global-ad.net>
 <20110722085420.GP22568@nb.net.home>
 <7856072A9D04C24B82DFE2B1112FE38A08FE2D3AC2@MCHP058A.global-ad.net>
 <20110722094304.GQ22568@nb.net.home>
In-Reply-To: <20110722094304.GQ22568@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> Fixed.
> 
>  I've also added support for human readable class names, you can use:
> 
>    ionice -c best-effort /bin/foo

great, thanks!

One last corner case regarding -t (ignoring failure):

  $ schedutils/ionice -c 4 -t  schedutils/ionice 
  ionice: bad prio class 4
  $ schedutils/ionice -n 8 -t  schedutils/ionice 
  idle

With -c, a bad prio class leads to a failure, while it doesn't with -n.
Is this intended?

Berny
