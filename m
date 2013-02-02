Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.collax.com ([213.218.25.154]:35357 "EHLO mail.collax.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757731Ab3BBTpd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 2 Feb 2013 14:45:33 -0500
Message-ID: <510D6CF6.4050603@collax.com>
Date: Sat, 02 Feb 2013 20:45:58 +0100
From: Andreas Hofmeister <andi@collax.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: output from "blkid" unstable (util-linux 2.22.2)
References: <5106F0FB.8020907@collax.com> <20130201151131.GA14089@x2.net.home>
In-Reply-To: <20130201151131.GA14089@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/01/2013 04:11 PM, Karel Zak wrote:

>    cd util-linux
>    ./autogen.sh

Had a bit if a problem with my auto-tools, so I could not actually check 
"master"

But apparently you found the problem already :-)

I applied your commit 6a0766444dc4f1b23b1f0da9c380fb1ced0bfb0a onto the 
sources from the v2.22.2 tar archive. So far, that seems to have fixed 
the problem.

Thanks
   Andi


