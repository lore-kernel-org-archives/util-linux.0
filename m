Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f180.google.com ([209.85.128.180]:44908 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3JGR7r (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 7 Oct 2013 13:59:47 -0400
Received: by mail-ve0-f180.google.com with SMTP id jz11so3744980veb.39
        for <util-linux-ng@vger.kernel.org>; Mon, 07 Oct 2013 10:59:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5252EA23.4080508@draigBrady.com>
References: <CAO2cUkTj+f+6xrgr6+WzY9D+TwwZHWYhMfuMKKYF=39vJ8wU6w@mail.gmail.com>
	<CAG27Bk3APFUnaWq+TzK9p3snpAzZ2v4SBoikB+8HWHaPojZVMQ@mail.gmail.com>
	<CAO2cUkRXsUrK=kZsx=yHAKR+Ht2baA5bLiTwU4J9UD4sEbBepg@mail.gmail.com>
	<52522615.4010304@draigBrady.com>
	<CAO2cUkQuNiHwdmxACq1i1W8ix1teVvtUi9McPtksRrFC-M7F3g@mail.gmail.com>
	<5252EA23.4080508@draigBrady.com>
Date: Mon, 7 Oct 2013 20:59:46 +0300
Message-ID: <CAO2cUkTZeLMTh=_nsHcXzUKeq6sGJ9+5V_KocMs-g7SdE3n=0w@mail.gmail.com>
Subject: Re: [RFC/PATCH] week numbers for cal
From: Tommi Kyntola <tommi.kyntola@gmail.com>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: Sami Kerola <kerolasa@gmail.com>, util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> It's generally best to avoid optional args on short args,
> as in this case -w3 is ambiguous and -wj is problematic.
> So I'd instead support an interface like -w,--week[=NUM]

Agreed. I dropped the :: from the short arg.

cheers,
Tommi Kyntola
