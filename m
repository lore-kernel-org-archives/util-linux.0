Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaAaJSF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 31 Jan 2014 04:18:05 -0500
Date: Fri, 31 Jan 2014 10:17:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: Phillip Susi <psusi@ubuntu.com>, util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
Message-ID: <20140131091759.GA10498@x2.net.home>
References: <52E91888.4080601@ubuntu.com>
 <20140130081651.GE22884@x2.net.home>
 <52EA5E6F.6040203@ubuntu.com>
 <52EA66CC.9070107@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52EA66CC.9070107@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 30, 2014 at 03:50:52PM +0100, Thomas Bächler wrote:
> In particular, if systemd is used in the initramfs, it will do an
> equivalent to util-linux's switch_root, but it will use an internal
> reimplementation to be able to pass some internal state from the
> initrd's systemd to the system's systemd (which would be lost if systemd
> would exec an external binary other than systemd).

Just for the record, switch_root has been originally implemented by
dracut folks and then moved to util-linux. (I guess that dracut
without systemd still uses the original switch_root.)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
