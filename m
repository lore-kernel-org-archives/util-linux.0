Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35569 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755649AbbFOJDu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Jun 2015 05:03:50 -0400
Date: Mon, 15 Jun 2015 11:03:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Felipe Franciosi <felipe.franciosi@citrix.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: losetup race on -f file
Message-ID: <20150615090347.GR1992@ws.net.home>
References: <9F2C4E7DFB7839489C89757A66C5AD62BA1A0C@AMSPEX01CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9F2C4E7DFB7839489C89757A66C5AD62BA1A0C@AMSPEX01CL03.citrite.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 12, 2015 at 09:44:03AM +0000, Felipe Franciosi wrote:
> Hi All,
> 
> I'm seeing a race when using "losetup -f file". Some research
> pointed me to a 2007 path that introduced a "retry" mechanism if the
> module returned EBUSY. At some point before the project went into
> git.kernel.org this commit went away.

I still see EBUSY sensitivity:

  https://github.com/karelzak/util-linux/blob/master/sys-utils/losetup.c#L684

the problem is probably loopcxt_setup_device() where we does not save
errno and does not set proper return value.

I'll try to fix it. Thanks for you report!

> Can anyone clarify? I'm currently flock()ing /var/lock/losetup outside calls to losetup.
> Objections to a losetup patch to do that internally?

Do you mean flock() within losetup? I'd like to avoid such thing.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
