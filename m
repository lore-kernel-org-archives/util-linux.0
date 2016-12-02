Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbcLBNPa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Dec 2016 08:15:30 -0500
Date: Fri, 2 Dec 2016 14:15:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Jim Patterson <jimp@wegrok.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH v2] wall: add --group option
Message-ID: <20161202131522.y4cfcle5yaa3u27n@ws.net.home>
References: <1479316934-1578-1-git-send-email-jimp@wegrok.net>
 <alpine.LNX.2.20.1611162155200.7871@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1611162155200.7871@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 16, 2016 at 09:59:28PM +0000, Sami Kerola wrote:
> On Wed, 16 Nov 2016, Jim Patterson wrote:
> 
> > The wall command on AIX supports a "-g" option to limit the message
> > to a group of users by gid.  Add compatibility to the Linux version.
> 
> A bit more work to this change: 1) numeric gid is no checked to be valid, 
> 2) gid is checked to be withing range of gid_t and 3) --group option is 
> added to bash completion hints 4) add Reviewed-by line.

Ah... I miss this comment before merge. So, I have applied an extra
patch with 1) and 3). The 2) seems like overkill, getgrgid() is
probably good enough.

> This change is also available from here:
> git://github.com/kerolasa/lelux-utiliteetit.git wall-group
 
Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
