Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:63730 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab1KPPFM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2011 10:05:12 -0500
Message-ID: <4EC3D126.4050101@bernhard-voelker.de>
Date: Wed, 16 Nov 2011 16:05:10 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/15] prlimit: add warning diagnostic when attempting
 to change prlimit's limits
References: <4EC0735B.2010504@bernhard-voelker.de> <20111116124537.GD7916@nb.net.home>
In-Reply-To: <20111116124537.GD7916@nb.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/16/2011 01:45 PM, Karel Zak wrote:

>   Anyway, it would be nice to have something like:
>
>      prlimit --nofile=1000 /bin/program
>
>   so somewhere after show_limits() should be exec().

Great idea. ;-)
Would you like me to give it a try?

Have a nice day,
Berny

