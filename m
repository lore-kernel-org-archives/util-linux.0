Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757079Ab3CTM7g (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Mar 2013 08:59:36 -0400
Date: Wed, 20 Mar 2013 13:59:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 7/7] whereis: remove duplicates from search results
Message-ID: <20130320125927.GB14833@x2.net.home>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
 <1363477219-29245-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363477219-29245-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 16, 2013 at 11:40:19PM +0000, Sami Kerola wrote:
> Now when the whereis will not have search directory duplicates, and it
> finds real path for symlinked files in paths it is time to remove search
> result duplicates.

 Hmm... it seems like unnecessary patch. I guess that

> Addresses: https://bugzilla.redhat.com/show_bug.cgi?id=835211

 is resolved by unique canonicalized directories where we search for
 the files.

   $ ./whereis -b ls
   ls: /usr/bin/ls

 (no more duplicate results like "ls: /bin/ls /usr/bin/ls").

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
