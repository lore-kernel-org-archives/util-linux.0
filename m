Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:59499 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaHRBXk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Aug 2014 21:23:40 -0400
Received: from [192.168.4.12] (athenae [192.168.4.12])
	by Ishtar.hs.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id s7I1NZwY048693
	for <util-linux@vger.kernel.org>; Sun, 17 Aug 2014 18:23:37 -0700
Message-ID: <53F15592.9020403@tlinx.org>
Date: Sun, 17 Aug 2014 18:23:30 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: Utilities don't take into account capabilities
References: <fbcec6cf5352.53efd3e4@langara.bc.ca> <53F11687.5060805@tlinx.org> <fb20984219ad.53f14f7a@langara.bc.ca>
In-Reply-To: <fb20984219ad.53f14f7a@langara.bc.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Steven Stewart-Gallus wrote:
>> Seriously... What capabilities does mount need in order to function?
>>     
>
> I can help out with this one.
>   
----
awesome... but, um... was hoping the author of mount could
tell me what caps I needed to enable to use his program
w/a non-root user... ;-)... oh well... um...now as to when we
can get a version that doesn't check for UID & EUID==0?

well... maybe in the works?




