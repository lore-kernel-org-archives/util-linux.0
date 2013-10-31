Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab3JaLe7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 31 Oct 2013 07:34:59 -0400
Date: Thu, 31 Oct 2013 12:34:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/10] cal: determine output width at beginning of run
 and reuse result
Message-ID: <20131031113449.GD1536@x2.net.home>
References: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
 <1382906556-16442-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382906556-16442-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 27, 2013 at 08:42:31PM +0000, Sami Kerola wrote:
> +struct cal_width {
> +	size_t dy;			/* day width in characters in printout */
> +	size_t wk;			/* week width == (7 * dlen + possible week num) */
> +};

 Is it really necessary to have a special struct for this setting? I
 see that everywhere in the code you have

    ctl.width.wk or ctl.width.wk

 what about to add 
 
    int day_width;
    int week_width; 
    
 to the control struct?
 
 BTW, yes, it's C, but ... "dy" and "wk" seems pretty unreadable :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
