Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:48649 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab3JGXdR (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 7 Oct 2013 19:33:17 -0400
Message-ID: <525344BB.80502@draigBrady.com>
Date: Tue, 08 Oct 2013 00:33:15 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Tommi Kyntola <tommi.kyntola@gmail.com>
CC: Sami Kerola <kerolasa@gmail.com>, util-linux-ng@vger.kernel.org
Subject: Re: [RFC/PATCH] week numbers for cal
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com> <CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com> <CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com> <52522615.4010304@draigBrady.com> <CAO2cUkQuNiHwdmxACq1i1W8ix1teVvtUi9McPtksRrFC-M7F3g@mail.gmail.com> <5252EA23.4080508@draigBrady.com> <CAO2cUkTZeLMTh=_nsHcXzUKeq6sGJ9+5V_KocMs-g7SdE3n=0w@mail.gmail.com>
In-Reply-To: <CAO2cUkTZeLMTh=_nsHcXzUKeq6sGJ9+5V_KocMs-g7SdE3n=0w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/07/2013 06:59 PM, Tommi Kyntola wrote:
>> It's generally best to avoid optional args on short args,
>> as in this case -w3 is ambiguous and -wj is problematic.
>> So I'd instead support an interface like -w,--week[=NUM]
> 
> Agreed. I dropped the :: from the short arg.

lgtm

thanks,
Pádraig.
