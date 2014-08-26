Return-Path: util-linux-owner@vger.kernel.org
Received: from edony.tuxfamily.net ([212.85.158.2]:50680 "EHLO
	edony.tuxfamily.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbaHZT2P (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 26 Aug 2014 15:28:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 26 Aug 2014 21:28:12 +0200
From: tnut@nutyx.org
To: Karel Zak <kzak@redhat.com>
Cc: <util-linux@vger.kernel.org>
Subject: Re: cfdisk, wrong interpretation of yes in non-english language
In-Reply-To: <20140826175817.GA30359@x2.net.home>
References: <d8263f3bc98929c82bbd0962ca77a159@nutyx.org>
 <20140826175817.GA30359@x2.net.home>
Message-ID: <f11615173dffb9bf932036b327450ed0@nutyx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le 2014-08-26 19:58, Karel Zak a écrit :
> On Tue, Aug 26, 2014 at 11:18:09AM +0200, tnut@nutyx.org wrote:
>> -               if (rc <= 0 || strcasecmp(buf, "yes") != 0
>> -                           || strcasecmp(buf, _("yes")) != 0) {
>> +               if (rc <= 0 ||  (strcasecmp(buf, "yes") != 0
>> +                           && strcasecmp(buf, _("yes")) != 0)) {
>
>  Fixed, thanks!
>
>     Karel

Actually there is another problem with the NLS, but is it possible to 
test the latest git or svn version ? as it could be allready fixed in 
the latest version

Thanks

Thierry
