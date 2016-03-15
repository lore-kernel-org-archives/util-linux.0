Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52474 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934342AbcCOJ0I (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 05:26:08 -0400
Date: Tue, 15 Mar 2016 10:26:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: George Spelvin <linux@horizon.com>, util-linux@vger.kernel.org
Subject: Re: e2fsck: /dev/hda2 is mounted.
Message-ID: <20160315092604.fhvvwmk5luqdrkhm@ws.net.home>
References: <20160314184419.7527.qmail@ns.horizon.com>
 <201603150038.11408.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201603150038.11408.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 15, 2016 at 12:38:10AM +0100, Ruediger Meier wrote:
> On Monday 14 March 2016, George Spelvin wrote:
> > Thanks for the help.  I don't quite understand the structure of
> > libmount well enough to know where a fix *should* go.
> >
> > > Can you send me your /proc/self/mountinfo? (or at least root fs
> > > entry from the file)
> 
> > 12 0 3:2 / / rw,relatime - ext4 /dev/root
> > [...]
> 
> Maybe it's not related but I've noticed a similar issue where 
> getmntent() was not able to parse long lines in /proc/mounts. It was 
> with musl and I've asked there
> http://permalink.gmane.org/gmane.linux.lib.musl.general/9548
> 
> I've got no reply, so maybe it was a stupid question and we are doing 
> something wrong ;)

The problem in this case is /dev/root, libmount tries to convert it to
the real device name by root= command line option, but the conversion
is pretty poor and it does not support all relevant use-cases. 

I'll try to improve it. It also seems that in many cases (except
btrfs) we can follow maj:min from mountinfo entry rather than parse
the complicated root= option.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
