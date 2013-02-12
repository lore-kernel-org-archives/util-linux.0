Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1608 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706Ab3BLKfx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Feb 2013 05:35:53 -0500
Date: Tue, 12 Feb 2013 11:35:49 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: "Mantas M." <grawity@gmail.com>, util-linux@vger.kernel.org
Subject: Re: lslocks =?utf-8?B?4oCTICJmYWlsZQ==?= =?utf-8?Q?d?= to parse pid:
 'WRITE'"
Message-ID: <20130212103549.GF20408@x2.net.home>
References: <kf0ehe$q7h$1@ger.gmane.org>
 <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 11, 2013 at 10:42:36PM +0000, Sami Kerola wrote:
> Subject: [PATCH] lslocks: print waiting state when necessary
> Organization: Lastminute.com
> 
> Earlier output was primarily unexpected.
> 
> $ flock foo -c "sleep 100" & flock foo -c "sleep 100" & flock foo -c
> "sleep 100" & lslocks
> [1] 22352
> [2] 22353
> [3] 22354
> lslocks: failed to parse pid: 'WRITE'
> 
> This commit adds WAITING mode to output listing.  The locks which failed
> with earlier version will look the following.
> 
> COMMAND           PID  TYPE SIZE MODE    M      START        END PATH
> [...]
> flock           22354 FLOCK   0B WAITING 0          0          0
> /home/src/util-linux/foo
> flock           22352 FLOCK   0B WAITING 0          0          0
> /home/src/util-linux/foo
> flock           22353 FLOCK   0B WRITE   0          0          0
> /home/src/util-linux/foo

 It's probably good idea to add information that the process is blocked,
 but I don't think that use WAITING in the MODE column is the right way. 
 We will lost the original information about the lock mode.

 It would be better to add a new column (e.g. BLOCKED).

 We can also add a prefix to MODE, for example ">WRITE" for blocked
 process. The disadvantage is that ">WRITE" is not backwardly compatible.

 (Hmm.. lslocks was introduced in release 2.22 and it's broken now ...
  maybe it's not so big problem ;-)

 It would be also nice to have --blocked command line option to list
 blocked processes only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
