Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20258 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638Ab3JDK3u (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Oct 2013 06:29:50 -0400
Date: Fri, 4 Oct 2013 12:29:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: some spelling and grammar fixes for messages and man pages
Message-ID: <20131004102946.GC14360@x2.net.home>
References: <1380799327.6719.29499593.49A8C84F@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380799327.6719.29499593.49A8C84F@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 03, 2013 at 01:22:07PM +0200, Benno Schulenberg wrote:
> About the 0003 patch I'm not entirely sure, but looking at almost
> identical messages, a path should be %s, not %d.

 You're right, %d is bug. Almost all your patches applied, thanks!

> -		fdisk_warn(cxt, _("open failed %s"), path);
> +		fdisk_warn(cxt, _("opening %s failed"), path);

 I don't like this kind of change.

 Please, ALWAYS when you want to change any very common message then
 see po/util-linux.pot. 
 
 We have on "cannot open %s" on more than 100 places!

 The ideal solution is to use already translated message than
 introduce new one. Or if you don't like the message then change the
 string on *all places*. 
 
 The goal is to minimize number of messages and unify our utils.

 It would be nice to cleanup all the messages and use for example

    cannot open %s
    cannot close %s
    cannot read %s
    cannot write %s
    seek on %s failed

 on all places. Now (rc1) is the ideal time for this change. 
 
 (Not sure why someone updated util-linux on translationproject.org
  when there is no -rc2 yet.)

>  	if (read_all(fd, ptr, size) != size) {
> -		fdisk_warn(cxt, _("read failed %s"), path);
> +		fdisk_warn(cxt, _("reading %s failed"), path);

...

>  	if (write_all(cxt->dev_fd, l->bsdbuffer, BSD_BBSIZE)) {
> -		fdisk_warn(cxt, _("write failed %s"), cxt->dev_path);
> +		fdisk_warn(cxt, _("writing %s failed"), cxt->dev_path);

 I have committed "cannot {write,read} %s".


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
