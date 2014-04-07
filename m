Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbaDGJ2V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Apr 2014 05:28:21 -0400
Date: Mon, 7 Apr 2014 11:28:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/10] kill: use control structure to pass user input to
 functions
Message-ID: <20140407092810.GE22126@x2.net.home>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
 <1394397023-7050-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394397023-7050-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 09, 2014 at 03:30:20PM -0500, Sami Kerola wrote:
> -			if (!check_all)
> +			if (ctl.check_all)
>  				proc_processes_filter_by_uid(ps, getuid());

 It would be nice to have regression test, right? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
