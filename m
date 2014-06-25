Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540AbaFYMMG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Jun 2014 08:12:06 -0400
Date: Wed, 25 Jun 2014 14:11:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/6] rename: continue despite something failed
Message-ID: <20140625121153.GC30418@x2.net.home>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
 <1403433117-32652-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403433117-32652-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 22, 2014 at 11:31:56AM +0100, Sami Kerola wrote:
> Try to do all file operations even when one or some of them fail.

 It would be nice to have a special return code for situation when
 something failed. See for example "mount -a" of kill(1) where we have 

    #define KILL_EXIT_SOMEOK      64

 and add to man page:

       0      success
       1      failure
       64     partial success

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
