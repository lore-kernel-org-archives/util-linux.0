Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeACKE6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 3 Jan 2018 05:04:58 -0500
Date: Wed, 3 Jan 2018 11:04:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: fsync(2) after writing partition data
Message-ID: <20180103100454.lu3gqiqcy2ijymm2@ws.net.home>
References: <20180102204504.1543-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180102204504.1543-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 02, 2018 at 08:45:04PM +0000, Sami Kerola wrote:
> In reply to reference comment commit:
> > It would be nice to have something more elegant than sleep, any idea?
> 
> Adding fsync(2) might be superficial when writing to device file, but

Well, we use fsync() before close(). I don't think we want to use
fsync() after a separate write as we use more than one write pretty
often.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
