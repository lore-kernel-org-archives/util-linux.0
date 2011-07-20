Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53579 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab1GTNvo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jul 2011 09:51:44 -0400
Date: Wed, 20 Jul 2011 15:51:37 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "corentin.labbe" <corentin.labbe@geomatys.fr>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] dmesg.c: print human readable timestamp
Message-ID: <20110720135137.GB22568@nb.net.home>
References: <4DD6593D.2090202@geomatys.fr> <20110629145957.GM6418@nb.net.home> <4E2449B6.1070105@geomatys.fr> <20110720124826.GA22568@nb.net.home> <7856072A9D04C24B82DFE2B1112FE38A08FE26DD8A@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A08FE26DD8A@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2011 at 03:33:04PM +0200, Voelker, Bernhard wrote:
> Karel Zak wrote:
> 
> > The latest dmesg(1) changes:
> >
> >  * -T, --ctime       : print human readable timestamps
> 
> shouln'd -T and -t or -r be mutually exclusive?
> 
> Currently, -T wins over -t, and -r wins over -T.

 Should be fixed now. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
