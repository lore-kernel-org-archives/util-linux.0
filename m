Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab2DCMwP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Apr 2012 08:52:15 -0400
Date: Tue, 3 Apr 2012 14:51:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/20] uuidd: implement --no-pid option
Message-ID: <20120403125146.GG1084@x2.net.home>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
 <1333039528-24784-5-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333039528-24784-5-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 29, 2012 at 06:45:12PM +0200, Petr Uzel wrote:
> +	if (pidfile_path) {
> +		sprintf(reply_buf, "%8d\n", getpid());
> +		if (ftruncate(fd_pidfile, 0)) {
> +			/* Silence warn_unused_result */
> +		}

 #include "c.h"

 ignore_result( ftruncate(fd_pidfile, 0) );


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
