Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab3JIHxZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Oct 2013 03:53:25 -0400
Date: Wed, 9 Oct 2013 09:53:05 +0200
From: Karel Zak <kzak@redhat.com>
To: butter@breezl.com
Cc: util-linux@vger.kernel.org, Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d does not move partition devices
Message-ID: <20131009075305.GG13559@x2.net.home>
References: <5241BC33.8050700@breezl.com>
 <20131007113852.GF14360@x2.net.home>
 <525493CA.40207@breezl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <525493CA.40207@breezl.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 09, 2013 at 01:22:50AM +0200, butter@breezl.com wrote:
> Anyway, one last minor comment: 
> 
> Ubuntu 13.04 64bit does not yet support option -P for losetup. So
> this must be an older version of util-linux. But then: how do I
> determine the version of util-linux installed? The binaries have
> no --version option and 'strings /sbin/losetup | egrep '[0-9]' does
> not reveal anything useful either. Maybe there is a general version
> for util-linux available in another binary? The man page does not
> tell. I failed to identify the version number!

 The option --version for losetup is supported since v2.21.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
