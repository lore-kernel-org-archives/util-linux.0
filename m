Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:60418 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbaIAGeq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Sep 2014 02:34:46 -0400
Message-ID: <54041383.2090700@bernhard-voelker.de>
Date: Mon, 01 Sep 2014 08:34:43 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>, util-linux@vger.kernel.org
Subject: Re: Debugging why fstrim doesn't work
References: <20140829093522.GA32003@citd.de>
In-Reply-To: <20140829093522.GA32003@citd.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/29/2014 11:35 AM, Matthias Schniedermeyer wrote:
> $ fstrim -v /
> fstrim: /: discard operation not supported.
> 
> How can i debug why fstrim/the kernel thinks discard isn't supported?

  $ strace -v fstrim -v /
  ...
  ioctl(3, FITRIM, 0x7fff4d693590)        = -1 EOPNOTSUPP (Operation not supported)
  ...

Interestingly, fstrim's error message has changed from the more precise

  fstrim: /: FITRIM ioctl failed: Operation not supported

(e.g. in 2.23.2) to a probably more user-friendly

  fstrim: /: the discard operation is not supported

(in the current git version).

Have a nice day,
Berny

