Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887Ab3KDJGP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 04:06:15 -0500
Date: Mon, 4 Nov 2013 10:06:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid: reports swap version + 1
Message-ID: <20131104090611.GD23604@x2.net.home>
References: <527416C9.9020702@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <527416C9.9020702@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 01, 2013 at 05:02:01PM -0400, Phillip Susi wrote:
> blkid adds one to the version number it reports when probing swap,
> saying version 2 for swap version 1, and saying version 1 for the old
> and no longer supported v0.

 Hmm.. old bug (introduced in udev volume_id), it's probably because
 the magic string is "SWAPSPACE2".

 Fixed (I hope it does not introduce a regression).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
