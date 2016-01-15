Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754914AbcAOJ3H (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jan 2016 04:29:07 -0500
Date: Fri, 15 Jan 2016 10:29:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Isaac Dunham <ibid.ag@gmail.com>
Cc: flylehe <flylehe@gmail.com>, util-linux@vger.kernel.org
Subject: Re: How to obtain the manual of util-linux?
Message-ID: <20160115092905.odbdjrg63llloyf5@ws.net.home>
References: <CAP0dga9EC649Wv04qSgythX2t+yO8gg=6TH80K6dBY4D1yUgCg@mail.gmail.com>
 <20160115053903.GB10573@newbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160115053903.GB10573@newbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 14, 2016 at 09:39:04PM -0800, Isaac Dunham wrote:
> On Thu, Jan 14, 2016 at 09:36:44PM -0500, flylehe wrote:
> > Does util-linux have a manual, similar to coreutils' official manual
> > https://www.gnu.org/software/coreutils/manual/ ?
> 
> Not in info format.
> 
> Every command is documented by a manpage (*.1 for user commands, *.8 for
> administrative commands, *.5 for files, and *.3 for programming interfaces
> like libblkid).
> 
> There is also plain-text documentation in Documentation/.

 And we provide API docs for all libs, it's on-line available at:

    http://ftp.kernel.org/pub/linux/utils/util-linux/v2.27/

 *-docs dirs.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
