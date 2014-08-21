Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:63764 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbaHUT2q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 15:28:46 -0400
Message-ID: <53F64865.4090706@bernhard-voelker.de>
Date: Thu, 21 Aug 2014 21:28:37 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH] mountpoint: symlinks are not mount points
References: <1408644191-13523-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1408644191-13523-1-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/21/2014 08:03 PM, Sami Kerola wrote:
> Earlier the mountpoint(1) followed symlinks

IMO this is correct as symlinks only have to be treated
as such when explicitly not de-referencing.
As mountpoint(1) does not have a --no-dereference option,
symlinks should always be transparent for this tool.

Furthermore, the patch would break scripts relying on existing
behavior:

  $ ln -s / slink

  $ /usr/bin/mountpoint slink
  slink is a mountpoint

  $ # ~berny/util-linux/mountpoint slink
  slink is not a mountpoint


Have a nice day,
Berny
