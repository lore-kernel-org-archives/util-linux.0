Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab1KIKz3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Nov 2011 05:55:29 -0500
Date: Wed, 9 Nov 2011 11:55:26 +0100
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: prlimit: SYS_prlimit undeclared on OpenSuSE 11.4
Message-ID: <20111109105526.GK16397@nb.net.home>
References: <7856072A9D04C24B82DFE2B1112FE38A0D86B2EBA0@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0D86B2EBA0@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 09, 2011 at 10:32:06AM +0100, Voelker, Bernhard wrote:
> Compiling the new prlimit (from latest git pull)
> fails here on "openSUSE 11.4 (x86_64)":
> 
>   CC     prlimit.o
> prlimit.c: In function 'prlimit':
> prlimit.c:139:17: error: 'SYS_prlimit' undeclared (first use in this function)

 Should be SYS_prlimit64. Fixed, git pull and try it again.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
