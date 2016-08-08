Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59988 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbcHHPah (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2016 11:30:37 -0400
Date: Mon, 8 Aug 2016 17:30:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Ales Novak <alnovak@suse.cz>
Cc: util-linux@vger.kernel.org, nfbrown@suse.com, jeffm@suse.com
Subject: Re: [PATCH] libmount: after colon, ignore double slashes in path
 start
Message-ID: <20160808153034.vnmpc76o5psdq4z6@ws.net.home>
References: <1469018169-5650-1-git-send-email-alnovak@suse.cz>
 <1469018169-5650-2-git-send-email-alnovak@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469018169-5650-2-git-send-email-alnovak@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 20, 2016 at 02:36:09PM +0200, Ales Novak wrote:
> With NFSv4, the path appearing in /proc/mounts may further differ from
> the one for which it was asked (say in /etc/fstab) and /run/mount/utab.
> That causes problems at least for applying userspace-stored flags (like
> "user").
> 
> server exports | client mounts | /proc/mounts | utab        | ->
>                |               |              |             |
> /tmp           | euler://tmp   | euler:/tmp   | euler://tmp | ERR
>                | euler:/tmp    | euler:/tmp   | euler:/tmp  | OK
>                |               |              |             |
> /              | euler://tmp   | euler://tmp  | euler://tmp | OK
>                | euler:/tmp    | euler://tmp  | euler:/tmp  | ERR
> 

I have applied a different patch (see commit d4e89dea4e8e95cee0cede39dc77618a181b8d19).

It seems like a generic problem and we should be robust enough to
ignore redundant slashes (///aaa/bbb /aaa/bbb/ ...etc).

Please, re-test if the solution works for your use-case.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
