Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:39297 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752701Ab2DPKWN convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Apr 2012 06:22:13 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: "dave@gnu.org" <dave@gnu.org>
CC: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Date: Mon, 16 Apr 2012 12:22:12 +0200
Subject: RE: [PATCH 5/8] sfdisk: fix silly mbyte typo
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C26@MCHP058A.global-ad.net>
References: <1334569484.2552.14.camel@offbook>
	 <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C0D@MCHP058A.global-ad.net>
 <1334571237.2552.18.camel@offbook>
In-Reply-To: <1334571237.2552.18.camel@offbook>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Davidlohr Bueso wrote:

On Mon, 2012-04-16 at 11:53 +0200, Voelker, Bernhard wrote:
> Davidlohr Bueso wrote:
> > -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
> > +	printf(_("Units = megabytes of 1048576 bytes, blocks of 1024 bytes"
...
> > 
> > not silly:
> > http://en.wikipedia.org/wiki/Mebibyte
> 
> hehe, silly me then.

no worries ;-)

Maybe this is better?

-	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
+	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"

Berny
