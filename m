Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:61669 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932874AbbDVOuv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 22 Apr 2015 10:50:51 -0400
Message-ID: <5537B53F.2070805@bernhard-voelker.de>
Date: Wed, 22 Apr 2015 16:50:39 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: sfdisk, latest fixes break ppc64
References: <201504211234.27649.sweet_f_a@gmx.de> <201504221242.18521.sweet_f_a@gmx.de> <20150422132827.GF27969@ws.net.home> <201504221620.01771.sweet_f_a@gmx.de>
In-Reply-To: <201504221620.01771.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/22/2015 04:20 PM, Ruediger Meier wrote:
> On Wednesday 22 April 2015, Karel Zak wrote:
>>   I hope so:-) Next time it would be nice to detect and fix such bugs
>>   in major release or in .1  ... we need a way how to motivate users
>> to use -rc releases (t-shits, beers? ;-)
>
> Hehe, maybe the only way is like we have it right now. 2.xx and 2.xx.1
> are the real rc1 and rc2. The distributors have to learn to use 2.xx.2
> only ;)

Isn't there a cross-platform CI system somewhere?
... okay, http://build.opensuse.org/ is one, but it usually
doesn't track upstream changes.  There's also things like
Hydra (http://hydra.nixos.org/) ... but this only seems to
cover i686 and x86_64.

Have a nice day,
Berny


