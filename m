Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245Ab1KPPzN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 10:55:13 -0500
Date: Wed, 16 Nov 2011 16:55:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/15] prlimit: add warning diagnostic when attempting
	to change prlimit's limits
Message-ID: <20111116155508.GO7916@nb.net.home>
References: <4EC0735B.2010504@bernhard-voelker.de> <20111116124537.GD7916@nb.net.home> <4EC3D126.4050101@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC3D126.4050101@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 16, 2011 at 04:05:10PM +0100, Bernhard Voelker wrote:
> On 11/16/2011 01:45 PM, Karel Zak wrote:
>
>>   Anyway, it would be nice to have something like:
>>
>>      prlimit --nofile=1000 /bin/program
>>
>>   so somewhere after show_limits() should be exec().
>
> Great idea. ;-)
> Would you like me to give it a try?

 Sure, go ahead!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
