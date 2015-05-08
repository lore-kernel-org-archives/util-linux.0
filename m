Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33650 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176AbbEHM3G (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 8 May 2015 08:29:06 -0400
Received: by wgin8 with SMTP id n8so71079010wgi.0
        for <util-linux@vger.kernel.org>; Fri, 08 May 2015 05:29:05 -0700 (PDT)
Received: from [192.168.178.22] (adsl-89-217-233-109.adslplus.ch. [89.217.233.109])
        by mx.google.com with ESMTPSA id l3sm8687547wik.16.2015.05.08.05.29.03
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 05:29:04 -0700 (PDT)
Message-ID: <554CAC0F.5050604@gmail.com>
Date: Fri, 08 May 2015 14:29:03 +0200
From: =?UTF-8?B?U3RlcGhhbiBNw7xsbGVy?= <fruktopus@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: New linux command "hexed"
References: <1431085018.447503889@m.mail.ru>
In-Reply-To: <1431085018.447503889@m.mail.ru>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am 08.05.2015 um 13:36 schrieb Hypsurus:
> i wrote a new Linux command called hexed
> 
> to encode and decode hex string from the command line.
> 
> and i want to add it to util linux.
> 
> how can help me to do this? and what i need to do?
> i already checked the Docs in github but i'm not sure what to do.
> 
> Source code:
> https://github.com/Hypsurus/hexed
> 
> thanks!
> 

It seems you implemented a subset of the functionality of 'od' or 'xxd' from coreutils. I guess these are widely spread and there is no need for another converter (albeit the cooler name). If hexed provides some extra features, you can integrate those in the tools above.
 
