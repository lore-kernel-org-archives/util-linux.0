Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:29003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab2DPK1x (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Apr 2012 06:27:53 -0400
Date: Mon, 16 Apr 2012 12:27:48 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "dave@gnu.org" <dave@gnu.org>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/8] sfdisk: fix silly mbyte typo
Message-ID: <20120416102748.GA3510@x2.net.home>
References: <1334569484.2552.14.camel@offbook>
 <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C0D@MCHP058A.global-ad.net>
 <1334571237.2552.18.camel@offbook>
 <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C26@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F0FCE9C26@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 16, 2012 at 12:22:12PM +0200, Voelker, Bernhard wrote:
> Maybe this is better?
> 
> -	printf(_("Units = mebibytes of 1048576 bytes, blocks of 1024 bytes"
> +	printf(_("Units = 1MiB, blocks of 1024*1024 bytes"

 +1


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
