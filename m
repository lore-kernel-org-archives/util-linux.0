Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43204 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbcHQMue (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2016 08:50:34 -0400
Date: Wed, 17 Aug 2016 14:49:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/8] losetup: Prevent rare detach race
Message-ID: <20160817124950.g3drwmdtrlbmfxeg@ws.net.home>
References: <53d613e5-fb85-c47f-18e7-05b5086586b8@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53d613e5-fb85-c47f-18e7-05b5086586b8@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2016 at 07:59:09PM +0200, Stanislav Brabec wrote:
> There is still a race risk: Device scheduled to detach is found by
> loopcxt_find_by_backing_file(), but released before loopcxt_set_status() is
> called, causing error on subsequent calls. To prevent error, retry it once
> again.

This is not merged, I have doubts we really need it. Maybe later, but
it does not seem like urgent issue (I don't remember any reports).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
