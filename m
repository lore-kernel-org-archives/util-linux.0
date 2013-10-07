Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:55995 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab3JGRGq (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 7 Oct 2013 13:06:46 -0400
Message-ID: <5252EA23.4080508@draigBrady.com>
Date: Mon, 07 Oct 2013 18:06:43 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Tommi Kyntola <tommi.kyntola@gmail.com>
CC: Sami Kerola <kerolasa@gmail.com>, util-linux-ng@vger.kernel.org
Subject: Re: [RFC/PATCH] week numbers for cal
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com> <CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com> <CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com> <52522615.4010304@draigBrady.com> <CAO2cUkQuNiHwdmxACq1i1W8ix1teVvtUi9McPtksRrFC-M7F3g@mail.gmail.com>
In-Reply-To: <CAO2cUkQuNiHwdmxACq1i1W8ix1teVvtUi9McPtksRrFC-M7F3g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/07/2013 12:39 PM, Tommi Kyntola wrote:
> Why not. I wasn't sure what exactly should be done with 52 when many
> years have days belonging to two different 52 weeks, but I came up
> with a spec that says it points to the week that starts during the
> relevant year.
> 
> A patch in guthub:
> https://github.com/Kynde/util-linux/commit/3a53abddc14f46eccb4264668b24875054f5ba62

It's generally best to avoid optional args on short args,
as in this case -w3 is ambiguous and -wj is problematic.
So I'd instead support an interface like -w,--week[=NUM]

thanks,
Pádraig.

